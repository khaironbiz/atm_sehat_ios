//
//  FaceMaskConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by LarryZhang on 2021/12/13.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "SkipConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELSkipBleDataModel.h>
#import <AILinkBleSDK/ELSkipBleManager.h>

@interface SkipConnectionViewController () <ELSkipBleDelegate, ELBluetoothManagerDelegate>

@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;

@property(nonatomic, strong) UIButton *connectButton;

@end

@implementation SkipConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [ELSkipBleManager shareManager].skipDelegate = self;
    [ELSkipBleManager shareManager].delegate = self;
    [[ELSkipBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELSkipBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@", log, self.textView.text];
}

//- (void)connectDevice {
//    [[ELSkipBleManager shareManager] startScan];
//}

- (void)setupUIView {

//    self.connectButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 88, 100, 40)];
//    [self.connectButton setTitle:@"点击重连" forState:UIControlStateNormal];
//    [self.connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:self.connectButton];
//    [self.connectButton addTarget:self action:@selector(connectDevice) forControlEvents:UIControlEventTouchUpInside];
//    self.connectButton.hidden = YES;

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
        make.top.offset(80);
    }];
}

#pragma mark - ble Delegate

//- (void)skipManagerScanDevices:(nonnull NSArray<ELPeripheralModel *> *)scanDevices {
//    //reconnect
//}


/// 蓝牙连接状态
/// @param state 连接状态
- (void)skipManagerUpdateState:(ELBluetoothState)state {
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
            
            //获取版本号
            [[ELSkipBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];
       
            //发送绑定命令(如果设备不支持绑定确认，也可以不发)
            [[ELSkipBleManager shareManager] bindDeviceWithType:Skip_BindDeviceType_KeyBinding];
            //弹出提示框
            //[self showPopupView];


        }
            break;
        case ELBluetoothStateFailedValidation: {
            self.title = @"Illegal equipment";
        }
            break;
        case ELBluetoothStateWillConnect:
            self.title = @"Connecting";
            break;
            
        case ELBluetoothStateUnauthorized:
            self.title = @"BLE Unauthorized";
        default:
            break;
    }
}

//返回绑定结果
- (void)skipManagerResult:(enum Skip_ResultType)result bleHeaderType:(enum Skip_BleHeadType)type {

    if (type == Skip_BleHeadType_BindDevice) {
        if (result == Skip_ResultType_Success) {
            [self addLog:@"绑定成功"];

            
            //通过验证，同步设备时间
            [[ELSkipBleManager shareManager] syncDevTimeStamp:[[NSDate date] timeIntervalSince1970]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //获取离线历史记录
                [[ELSkipBleManager shareManager] getOfflineHistory];
            });
            
        } else {
            [self addLog:@"绑定失败"];
        }
    }
}

//返回版本号
- (void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion {
    [self addLog:[NSString stringWithFormat:@"ble version:%@", bmVersion]];
}


- (void)skipManagerRealtimeDataWithState:(enum Skip_ReadyStateType)readyState skipModel:(nonnull ELSkipBleDataModel *)model power:(NSUInteger)power {
    [self addLog:[NSString stringWithFormat:@"skip state:%zd  num:%zd",readyState, model.sportNum]];
}


- (void)skipManagerReportOfflineHistoryWithHistoryModelList:(nonnull NSArray<ELSkipHistoryDataModel *> *)modelList {
    [self addLog:[NSString stringWithFormat:@"skip history num:%zd",modelList.count]];
}



- (void)skipManagerSportEndReportDataWithHistoryModel:(nonnull ELSkipHistoryDataModel *)model {
    [self addLog:[NSString stringWithFormat:@"skip end, result:%zd",model.dataModel.sportNum]];
}




@end
