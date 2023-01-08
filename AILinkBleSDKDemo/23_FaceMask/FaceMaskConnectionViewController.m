//
//  FaceMaskConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "FaceMaskConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELFaceMaskBleHeader.h>
#import <AILinkBleSDK/ELFaceMaskBleManager.h>

@interface FaceMaskConnectionViewController () <FaceMaskBleDelegate, ELBluetoothManagerDelegate>

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;

@property(nonatomic, strong) UIButton *connectButton;

@end

@implementation FaceMaskConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [ELFaceMaskBleManager shareManager].faceMaskDelegate = self;
    [ELFaceMaskBleManager shareManager].delegate = self;
    [[ELFaceMaskBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELFaceMaskBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@", log, self.textView.text];
}

- (void)connectDevice {
    [[ELFaceMaskBleManager shareManager] startScan];
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
- (void)faceMaskBleReceiveState:(ELBluetoothState)state {
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
            [[ELFaceMaskBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeReadDeviceSupportUnit];

            //获取版本号
            [[ELFaceMaskBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];

            //同步时间到设备
            [[ELFaceMaskBleManager shareManager] syncMCUNowDate];

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
- (void)faceMaskBleReceiveDevices:(NSArray<ELPeripheralModel *> *)devices {
    for (ELPeripheralModel *model in devices) {
        if ([model.macAddress isEqualToString:self.p.macAddress]) {
            [[ELFaceMaskBleManager shareManager] connectPeripheral:model];
        }
    }
}

- (void)faceMaskBleReceiveStatusDataModel:(ELFaceMaskBleDataModel *_Nonnull)model {

    NSString *str = [NSString stringWithFormat:@"空气质量指数:%@", @(model.index)];
    str = [str stringByAppendingFormat:@" 风扇状态:%@", @(model.fanStatus)];
    str = [str stringByAppendingFormat:@" 电池状态:%@", @(model.batteryStatus)];
    str = [str stringByAppendingFormat:@" 电池续航:%@", @(model.batteryLife)];
    str = [str stringByAppendingFormat:@" 呼吸频率:%@", @(model.breathRate)];
    str = [str stringByAppendingFormat:@" 呼吸状态:%@", @(model.breathStatus)];
    str = [str stringByAppendingFormat:@" 滤网的总工作时长:%@", @(model.workTime)];

    [self addLog:[NSString stringWithFormat:@"ELFaceMaskBleDataModel() %@", str]];

}

- (void)faceMaskReplaceSuccess:(BOOL)success {
    [self addLog:[NSString stringWithFormat:@"faceMaskReplaceSuccess() success:%@", @(success)]];
}

- (void)faceMaskSwitchFanResult:(FaceMaskFanControlResult)result {
    [self addLog:[NSString stringWithFormat:@"faceMaskSwitchFanResult() result:%@", @(result)]];
}

- (void)faceMaskPoweroffSuccess:(BOOL)success {
    [self addLog:[NSString stringWithFormat:@"faceMaskPoweroffSuccess() success:%@", @(success)]];
}


@end
