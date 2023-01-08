//
//  CoffeeScaleConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "CoffeeScaleConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELCoffeeScaleBleHeader.h>
#import <AILinkBleSDK/ELCoffeeScaleBleManager.h>

@interface CoffeeScaleConnectionViewController () <CoffeeScaleBleDelegate, ELBluetoothManagerDelegate>

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;

@property(nonatomic, strong) UIButton *connectButton;

@end

@implementation CoffeeScaleConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [ELCoffeeScaleBleManager shareManager].coffeeScaleDelegate = self;
    [ELCoffeeScaleBleManager shareManager].delegate = self;
    [[ELCoffeeScaleBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELCoffeeScaleBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@", log, self.textView.text];
}

- (void)connectDevice {
    [[ELCoffeeScaleBleManager shareManager] startScan];
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
            [[ELCoffeeScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeReadDeviceSupportUnit];

            //获取版本号
            [[ELCoffeeScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];

            //同步时间到设备
            [[ELCoffeeScaleBleManager shareManager] syncMCUNowDate];

            //切换到app 冲煮 模式
            [[ELCoffeeScaleBleManager shareManager] sendSwithAppMode:YES subMode:0];
            [self addLog:@"切换到app 冲煮 模式"];

            //切换到app 称重 模式
//            [[ELCoffeeScaleBleManager shareManager] sendSwithAppMode:YES subMode:1];
//            [self addLog:@"切换到app 称重 模式"];

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
            [[ELCoffeeScaleBleManager shareManager] connectPeripheral:model];
        }
    }
}

//获得支持单位列表
- (void)supportWeightUnits:(NSArray *_Nullable)weightArray {
    NSLog(@"weightArray: %@", weightArray);
    [self addLog:@"获得支持单位列表"];
}

//正在连接中倒计时
- (void)deviceBleCountDown:(NSInteger)count {
    NSLog(@"count: %@", @(count));
    [self addLog:@"正在连接中倒计时"];
}



/** 返回咖啡秤称量的数据模型 */
- (void)coffeeScaleBleReceiveStatusDataModel:(ELCoffeeScaleBleDataModel *_Nonnull)model {
    NSLog(@"model.weightString: %@", model.weightString);
    [self addLog:[@"当前重量: " stringByAppendingFormat:@"%@", model.weightString]];
}

/** 返回设备电量 */
- (void)coffeeScaleBleRechargeState:(CoffeeChargingType)type powerNumber:(NSInteger)power {
    NSLog(@"coffeeScaleBleRechargeState() type: %@ power: %@", @(type), @(power));
    [self addLog:[@"设备电量: " stringByAppendingFormat:@"type: %@ power: %@", @(type), @(power)]];
}

// 计时功能控制
- (void)coffeeScaleBleReceiveTimerControl:(BOOL)countdown duration:(NSUInteger)duration control:(ELCoffeeScaleTimerControl)control {
    NSLog(@"coffeeScaleBleReceiveTimerControl() countdown: %@ duration: %@ control: %@", @(countdown), @(duration), @(control));
    [self addLog:[@"计时功能: " stringByAppendingFormat:@"countdown: %@ duration: %@ control: %@", @(countdown), @(duration), @(control)]];
}


@end
