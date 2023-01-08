//
//  NutritionScaleConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "NutritionScaleConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELNutritionScaleBleHeader.h>
#import <AILinkBleSDK/ELNutritionScaleBleManager.h>

@interface NutritionScaleConnectionViewController () <NutritionScaleBleDelegate, ELBluetoothManagerDelegate>

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;

@property(nonatomic, strong) UIButton *connectButton;

@end

@implementation NutritionScaleConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [ELNutritionScaleBleManager shareManager].nutritionScaleBleDelegate = self;
    [ELNutritionScaleBleManager shareManager].delegate = self;
    [[ELNutritionScaleBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELNutritionScaleBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@", log, self.textView.text];
}

- (void)connectDevice {
    [[ELNutritionScaleBleManager shareManager] startScan];
}

- (void)setupUIView {

    self.connectButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 88, 100, 40)];
    [self.connectButton setTitle:@"点击重连" forState:UIControlStateNormal];
    [self.connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.connectButton];
    [self.connectButton addTarget:self action:@selector(connectDevice) forControlEvents:UIControlEventTouchUpInside];
    self.connectButton.hidden = YES;

    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.text = @"Log";
    self.textView.textColor = [UIColor redColor];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.offset(-44);
//        make.height.mas_equalTo(350);
        make.top.offset(150);
    }];
}

#pragma mark - ble Delegate

/// 蓝牙连接状态
/// @param state 连接状态
- (void)deviceBleReceiveState:(ELBluetoothState)state {
    switch (state) {
        case ELBluetoothStateUnavailable: {
            self.title = @"Please open the bluetooth";
        }
            break;
        case ELBluetoothStateAvailable: {
            self.title = @"Bluetooth is open";
        }
            break;
        case ELBluetoothStateScaning: {
            self.title = @"Scanning";
        }
            break;
        case ELBluetoothStateConnectFail: {
            self.title = @"Connect fail";
        }
            break;
        case ELBluetoothStateDidDisconnect: {
            self.title = @"Disconnected";
            self.connectButton.hidden = NO;
        }
            break;
        case ELBluetoothStateDidValidationPass: {
            self.connectButton.hidden = YES;
            self.title = @"Connected";
            //连接成功，获取单位
            [[ELNutritionScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeReadDeviceSupportUnit];

            //获取版本号
            [[ELNutritionScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];

            //同步时间到设备
            [[ELNutritionScaleBleManager shareManager] syncMCUNowDate];

        }
            break;
        case ELBluetoothStateFailedValidation: {
            self.title = @"Illegal equipment";
        }
            break;
        case ELBluetoothStateWillConnect:
            self.title = @"Connecting";
            break;
        default:
            break;
    }
}

/// 附近的设备
/// @param devices 设备列表
- (void)deviceBleReceiveDevices:(NSArray<ELPeripheralModel *> *)devices {
    for (ELPeripheralModel *model in devices) {
        if ([model.macAddress isEqualToString:self.p.macAddress]) {
            [[ELNutritionScaleBleManager shareManager] connectPeripheral:model];
        }
    }
}

//获得支持单位列表
- (void)supportWeightUnits:(NSArray *_Nullable)weightArray {
    NSLog(@"weightArray: %@", weightArray);
    [self addLog:@"获得支持单位列表"];
}

//称重数据
- (void)nutritionScaleBleDataModel:(ELNutritionScaleDataModel *_Nonnull)model {
    NSLog(@"%s model:%@", __FUNCTION__, model);
    NSString *testData = [NSString stringWithFormat:@"weight:%@ weightPoint:%@ weightUnit:%@ sn:%d", @(model.weight), @(model.weightPoint), @(model.weightUnit), model.serialNumber];
    [self addLog:testData];
}

//超载
- (void)overload:(BOOL)status {
    [self addLog:[NSString stringWithFormat:@"超载: %d", status]];
}

//低电
- (void)lowPower:(BOOL)status {
    [self addLog:[NSString stringWithFormat:@"低电: %d", status]];
}

@end
