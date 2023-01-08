//
//  FoodThermometerConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "FoodThermometerConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELFoodThermometerHead.h>
#import <AILinkBleSDK/ELFoodThermometerBleManager.h>

@interface FoodThermometerConnectionViewController () <FoodThermometerBleDelegate, ELBluetoothManagerDelegate>
@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;

@property(nonatomic, strong) UIButton *connectButton;

@end

@implementation FoodThermometerConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [ELFoodThermometerBleManager shareManager].foodThermometerBleDelegate = self;
    [ELFoodThermometerBleManager shareManager].delegate = self;
    [[ELFoodThermometerBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELFoodThermometerBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@", log, self.textView.text];
}

- (void)connectDevice {
    [[ELFoodThermometerBleManager shareManager] startScan];
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
            self.title = @"Scaning";
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
            [[ELFoodThermometerBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeReadDeviceSupportUnit];

            //获取版本号
            [[ELFoodThermometerBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];

            //同步时间到设备
            [[ELFoodThermometerBleManager shareManager] syncMCUNowDate];


            //查询设备状态
            [[ELFoodThermometerBleManager shareManager] checkDeviceInfo];
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

- (void)deviceBleReceiveDevices:(NSArray<ELPeripheralModel *> *)devices {
    for (ELPeripheralModel *model in devices) {
        if ([model.macAddress isEqualToString:self.p.macAddress]) {
            [[ELFoodThermometerBleManager shareManager] connectPeripheral:model];
        }
    }
}

//设备返回基础信息
- (void)foodThermometerBasicInfo:(BasicInfo)basicInfo {
    NSLog(@"foodThermometerBasicInfo() basicInfo.batteryLevel:%@ basicInfo.charging:%@", @(basicInfo.batteryLevel), @(basicInfo.charging));
    [self addLog:[@"设备返回基础信息" stringByAppendingFormat:@"basicInfo.batteryLevel:%@ basicInfo.charging:%@", @(basicInfo.batteryLevel), @(basicInfo.charging)]];
}

//设备返回数据状态
- (void)foodThermometerProbeStatus:(ProbeStatus)probeStatus {
    NSLog(@"foodThermometerProbeStatus() probeStatus.index:%@ probeStatus.internalTemperature:%@", @(probeStatus.index), @(probeStatus.internalRawTemperature));
    [self addLog:[@"设备返回数据状态" stringByAppendingFormat:@"probeStatus.index:%@ probeStatus.internalTemperature:%@", @(probeStatus.index), @(probeStatus.internalRawTemperature)]];
}

//设备设置温度
- (void)foodThermometerSwitchTemperatureUnit:(ELDeviceTemperatureUnit)unit {
    NSLog(@"foodThermometerSwitchTemperatureUnit() unit: %@", @(unit));
    [self addLog:[@"设备设置温度" stringByAppendingFormat:@"unit: %@", @(unit)]];
}

@end
