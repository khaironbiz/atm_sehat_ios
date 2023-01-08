//
//  BodyFatScaleConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/8.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "BodyFatScaleConnectViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBodyFatScaleBleManager.h>
#import <AILinkBleSDK/ELBodyFatScaleBleUserModel.h>
#import <AILinkBleSDK/ELBodyFatScaleBleWeightModel.h>
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

#import <AILinkBleSDK/AlgorithmSDK.h>
#import <AILinkBleSDK/ELUnitConvertTool.h>

@interface BodyFatScaleConnectViewController () <ELBluetoothManagerDelegate, ELBodyFatScaleBleDelegate>
@property(nonatomic, strong) UITextView *textView;

@property(nonatomic, copy) NSArray<NSNumber *> *units;


@end

@implementation BodyFatScaleConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [ELBodyFatScaleBleManager shareManager].bodyFatScaleDelegate = self;
    [ELBodyFatScaleBleManager shareManager].delegate = self;
    [[ELBodyFatScaleBleManager shareManager] connectPeripheral:self.p];

    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[ELBodyFatScaleBleManager shareManager] disconnectPeripheral];
}

- (void)addLog:(NSString *)log {
    self.textView.text = [NSString stringWithFormat:@"%@\n%@", log, self.textView.text];
}

- (void)buttonAction:(UIButton *)sender {
    if ([ELBodyFatScaleBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    } else if (tag == 2) {

        [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    } else if (tag == 3) {
        [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    } else if (tag == 4) {
        [[ELBodyFatScaleBleManager shareManager] setBluetoothName:@"AILink"];
    } else if (tag == 5) {
        if (self.units.count == 0) {
            [self addLog:@"No units obtained"];
            return;
        }

//        [[ELBodyFatScaleBleManager shareManager] changeBodyFatScaleUnit:(ELDeviceWeightUnit_KG)];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change Unit" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        for (int i = 0; i < self.units.count; i++) {

            UIAlertAction *action = [UIAlertAction actionWithTitle:AiLinkBleWeightUnitDic[self.units[i]] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *_Nonnull action) {
                [[ELBodyFatScaleBleManager shareManager] changeBodyFatScaleUnit:self.units[i].integerValue];
            }];
            [alert addAction:action];
        }
        [self presentViewController:alert animated:YES completion:nil];
    } else if (tag == 6) {

    } else if (tag == 7) {

    } else if (tag == 8) {

    } else if (tag == 9) {

    }

}

- (void)setupUIView {
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button1 setTitle:@"Get BM Version" forState:(UIControlStateNormal)];
    button1.tag = 1;
    button1.titleLabel.adjustsFontSizeToFitWidth = YES;
    button1.titleLabel.numberOfLines = 2;
    button1.backgroundColor = [UIColor blackColor];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(80);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];

    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button2 setTitle:@"Get C V P ID" forState:(UIControlStateNormal)];
    button2.tag = 2;
    button2.titleLabel.adjustsFontSizeToFitWidth = YES;
    button2.titleLabel.numberOfLines = 2;
    button2.backgroundColor = [UIColor blackColor];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1.mas_right).mas_offset(10);
        make.top.mas_equalTo(80);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];

    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button3 setTitle:@"Get Name" forState:(UIControlStateNormal)];
    button3.tag = 3;
    button3.titleLabel.adjustsFontSizeToFitWidth = YES;
    button3.titleLabel.numberOfLines = 2;
    button3.backgroundColor = [UIColor blackColor];
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button2.mas_right).mas_offset(10);
        make.top.mas_equalTo(80);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    //
    UIButton *button4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button4 setTitle:@"Set Name" forState:(UIControlStateNormal)];
    button4.tag = 4;
    button4.titleLabel.adjustsFontSizeToFitWidth = YES;
    button4.titleLabel.numberOfLines = 2;
    button4.backgroundColor = [UIColor blackColor];
    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button4];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(button1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    //
    UIButton *button5 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button5 setTitle:@"Change unit" forState:(UIControlStateNormal)];
    button5.tag = 5;
    button5.titleLabel.adjustsFontSizeToFitWidth = YES;
    button5.titleLabel.numberOfLines = 2;
    button5.backgroundColor = [UIColor blackColor];
    [button5 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button5];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button4.mas_right).mas_offset(10);
        make.top.equalTo(button1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    //
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.text = @"Log";
    self.textView.textColor = [UIColor redColor];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(200);
    }];
}

- (void)bluetoothManagerReceiceResponseType:(ELInetSetCmdType)type result:(ELSetBluetoothResponseType)result {
    if (type == ELInetSetCmdTypeSetName) {
        if (result == ELSetBluetoothResponseTypeSuccess) {
            [self addLog:@"Set name Success "];
        } else if (result == ELSetBluetoothResponseTypeFailure) {
            [self addLog:@"Set name failure "];
        } else if (result == ELSetBluetoothResponseTypeNoSupport) {
            [self addLog:@"Set name unsupport "];
        }

    }

}

- (void)bluetoothManagerReceiceName:(NSString *)name {
    [self addLog:name];
}

- (void)bluetoothManagerReceiveDID:(struct ELDIDStruct)did {
    [self addLog:[NSString stringWithFormat:@"CID = %d,VID = %d,PID = %d", did.deviceType, did.vendorID, did.productID]];
}

- (void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion {
    [self addLog:bmVersion];
}

- (void)bluetoothManagerBackDeviceSupportUnitWithWeight:(NSArray<NSNumber *> *)weightArray Height:(NSArray<NSNumber *> *)heightArray Temperature:(NSArray<NSNumber *> *)temperatureArray BloodPressure:(NSArray<NSNumber *> *)bloodPressureArray Pressure:(NSArray<NSNumber *> *)pressureArray {
    //这里只要体重数据
    self.units = weightArray;
}

- (void)bluetoothManagerReceiveMCUConnectedState:(struct ELMCUStateStruct)stateStrct {

}

/**
 Callback to set unit result(回调设置单位结果)
 
 @param result 结果
 */
- (void)bodyFatScaleManagerCallBackSetUnitResult:(ELSetBluetoothResponseType)result {
    switch (result) {
        case ELSetBluetoothResponseTypeSuccess: {
            [self addLog:@"Change Unit Success"];
        }
            break;
        case ELSetBluetoothResponseTypeFailure: {
            [self addLog:@"Change Unit Failure"];
        }
            break;
        case ELSetBluetoothResponseTypeNoSupport: {
            [self addLog:@"Unsupport Change Unit"];
        }
            break;
        default:
            break;
    }
}


/**
 MCU requests user information( MCU 请求用户信息)
 
 @param status 请求状态
 */
- (void)bodyFatScaleManagerMCURequestAppUserInfoType:(BodyFatScaleMCURequestUserInfoStatus)status {
    if (status == BodyFatScaleMCURequestUserInfoStatus_Get) {
        //下发当前用户给秤
        [[ELBodyFatScaleBleManager shareManager] sendCurrentUserToBle:[self getOneUser]];
    } else if (status == BodyFatScaleMCURequestUserInfoStatus_Success) {
        [self addLog:@"MCU requests user information success"];
    } else if (BodyFatScaleMCURequestUserInfoStatus_Fail) {
        [self addLog:@"MCU requests user information failure"];
    }

}


/**
 Return weight and body fat model(返回重量及体脂model)
 */
- (void)bodyFatScaleManagerCallBackWeight:(ELBodyFatScaleBleWeightModel *)weightModel state:(BodyFatScaleMeasureStatus)status {
    switch (status) {
        case BodyFatScaleMeasureStatus_Unstable: {
            [self addLog:[NSString stringWithFormat:@"Unstable data weight = %ld unit = %@ point = %ld adc = %ld", weightModel.weight, AiLinkBleWeightUnitDic[@(weightModel.weightUnit)], weightModel.weightPoint, weightModel.adc]];
        }
            break;
        case BodyFatScaleMeasureStatus_Stable: {
            [self addLog:[NSString stringWithFormat:@"Stable data weight = %ld unit = %@ point = %ld adc = %ld", weightModel.weight, AiLinkBleWeightUnitDic[@(weightModel.weightUnit)], weightModel.weightPoint, weightModel.adc]];
        }
            break;
        case BodyFatScaleMeasureStatus_Failed: {
            [self addLog:@"Test failure"];
        }
            break;
        case BodyFatScaleMeasureStatus_Complete: {
            [self addLog:[NSString stringWithFormat:@"Tested weight = %ld unit = %@ point = %ld adc = %ld", weightModel.weight, AiLinkBleWeightUnitDic[@(weightModel.weightUnit)], weightModel.weightPoint, weightModel.adc]];
            NSLog(@"weightModel:%@", weightModel);

            //App算法
            [self algorithmWithBleModel:weightModel user:self.getOneUser];

            //更新用户信息给秤
            [[ELBodyFatScaleBleManager shareManager] sendCurrentUserToBle:[self getOneUser]];
            //下发用户列表
            [[ELBodyFatScaleBleManager shareManager] sendOfflineUserListToBle:[self get8Users]];
        }
            break;
        default:
            break;
    }
}

- (void)algorithmWithBleModel:(ELBodyFatScaleBleWeightModel *)weightModel user:(ELBodyFatScaleBleUserModel *)user {

    NSString *weightKg = [ELUnitConvertTool getWeightShowStrWithTargetUnit:ELDeviceWeightUnit_KG bleWeightInt:weightModel.weight bleWeightUnit:weightModel.weightUnit bleWeightPoint:weightModel.weightPoint];

    AlgorithmModel *algorithmModel = [AlgorithmSDK getBodyfatWithWeight:weightKg.floatValue adc:(int) weightModel.adc sex:user.sex age:(int) user.age height:(int) user.height];
    NSLog(@"algorithmModel:%@", algorithmModel);
}


/**
 Return temperature (unit: ° C)(返回温度（单位：°C）)
 
 @param temp 温度（单位：°C）
 */
- (void)bodyFatScaleManagerCallBackTemp:(NSString *)temp {
    [self addLog:[NSString stringWithFormat:@"temperature is %@", temp]];
}

/**
 Back to impedance measurement(返回阻抗测量)
 
 @param status 阻抗测量状态
 @param adc 阻抗
 */
- (void)bodyFatScaleManagerCallBackAdcMeasureStatus:(BodyFatScaleAdcMeasureStatus)status adcValue:(NSInteger)adc {
    switch (status) {
        case BodyFatScaleAdcMeasureStatus_Testing: {
            [self addLog:@"adc testing"];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_Success: {
            [self addLog:[NSString stringWithFormat:@"adc is %ld", adc]];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_Fail: {
            [self addLog:@"adc test failure"];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_SuccessCustom: {
            [self addLog:[NSString stringWithFormat:@"adc is %ld and user app algum", adc]];
        }
            break;
        default:
            break;
    }
}

/**
 Callback heart rate measurement(回调心率测量)
 
 @param status 心率测量状态
 @param heartRate 心率
 */
- (void)bodyFatScaleManagerCallBackHeartRateMeasureStatus:(BodyFatScaleHeartRateMeasureStatus)status heartRateValue:(NSInteger)heartRate {
    switch (status) {
        case BodyFatScaleHeartRateMeasureStatus_Testing: {
            [self addLog:@"Heart Rate Testing"];
        }
            break;
        case BodyFatScaleHeartRateMeasureStatus_Success: {
            [self addLog:[NSString stringWithFormat:@"Heart Rate is %ld", heartRate]];
        }
            break;
        case BodyFatScaleHeartRateMeasureStatus_Fail: {
            [self addLog:@"Heart Rate Test failure"];
        }
            break;
        default:
            break;
    }
}

/**
 Return error code(返回错误码)
 
 @param code 错误码
 1:超重
 */
- (void)bodyFatScaleManagerCallBackErrorCode:(NSInteger)code {
    [self addLog:[NSString stringWithFormat:@"error code = %ld", code]];
}
//MARK:回调A6指令数据

/**
 Send success or failure callback for offline user list(发送离线用户列表的成功或失败回调)
 
 @param status 状态
 */
- (void)bodyFatScaleManagerCallBackUpdateRecordStatus:(BodyFatScaleUpdateRecordStatus)status {
    switch (status) {
        case BodyFatScaleUpdateRecordStatus_AllSuccess: {
            [self addLog:@"Update All Users Success"];
        }
            break;
        case BodyFatScaleUpdateRecordStatus_OneSuccess: {
            [self addLog:@"Update A User Success"];
        }
            break;
        case BodyFatScaleUpdateRecordStatus_OneFail: {
            [self addLog:@"Update A User Failure"];
        }
            break;
        case BodyFatScaleUpdateRecordStatus_AllFail: {
            [self addLog:@"Update All Users Failure"];
        }
            break;
        default:
            break;
    }
}

/**
 Request callback for offline history(请求离线历史记录的回调)
 
 @param status 状态
 */
- (void)bodyFatScaleManagerCallBackSendHistoryDataStatus:(BodyFatScaleSendHistoryDataStatus)status {
    if (status == BodyFatScaleSendHistoryDataStatus_No) {
        [self addLog:@"No offline datas"];
    } else if (status == BodyFatScaleSendHistoryDataStatus_Begin) {
        [self addLog:@"Begin receive offline datas"];
    } else if (status == BodyFatScaleSendHistoryDataStatus_End) {
        [self addLog:@"End receive offline datas"];
    }

}

/**
 APP algorithm-offline history data(APP 算法-离线历史记录数据)
 
 @param user 用户信息
 */
- (void)bodyFatScaleManagerCallBackBleUserHistoryDataCustomADCModel:(ELBodyFatScaleBleUserModel *)user bodyDataModel:(ELBodyFatScaleBleWeightModel *)bodyModel {
    //这里的身体指标等数据由app自定义算法计算得到，请区分bodyModel.algNum来调用算法
    [self addLog:[NSString stringWithFormat:@"App algorithm-offline history data:userId = %ld weight = %ld unit =%@ point = %ld", user.usrID, bodyModel.weight, AiLinkBleWeightUnitDic[@(bodyModel.weightUnit)], bodyModel.weightPoint]];
}

/**
 MCU algorithm-offline history data(MCU 算法-离线历史记录数据)
 
 @param user 用户信息
 @param bodyModel 体脂数据
 */
- (void)bodyFatScaleManagerCallBackBleUserHistoryDataModel:(ELBodyFatScaleBleUserModel *)user bodyDataModel:(ELBodyFatScaleBleWeightModel *)bodyModel {
    //这里的身体指标数据由秤计算得到
    [self addLog:[NSString stringWithFormat:@"MCU algorithm-offline history data:userId = %ld weight = %ld unit =%@ point = %ld", user.usrID, bodyModel.weight, AiLinkBleWeightUnitDic[@(bodyModel.weightUnit)], bodyModel.weightPoint]];
}

- (void)bodyFatScaleManagerUpdateState:(ELBluetoothState)state {
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
        }
            break;
        case ELBluetoothStateDidValidationPass: {
            self.title = @"Connected";
            //获取设备支持的单位
            [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
            //将你自己设置的单位发给秤
            ELDeviceWeightUnit unit = ELDeviceWeightUnit_KG;
            [[ELBodyFatScaleBleManager shareManager] changeBodyFatScaleUnit:unit];
            //请求历史记录
            [[ELBodyFatScaleBleManager shareManager] sendCmd_RequestHistory];

            //下发用户列表
            [[ELBodyFatScaleBleManager shareManager] sendOfflineUserListToBle:[self get8Users]];
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

- (NSArray<ELBodyFatScaleBleUserModel *> *)get8Users {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        ELBodyFatScaleBleUserModel *user = [[ELBodyFatScaleBleUserModel alloc] init];
        user.createTime = [[NSDate date] timeIntervalSince1970];
        user.usrID = i;
        user.role = i % 4;
        user.sex = i % 2;
        user.age = 26 + i;
        user.height = 170 + i;
        user.weight = 600 + i;
        user.adc = 560 + i;
        [users addObject:user];
    }

    return users.copy;
}

- (ELBodyFatScaleBleUserModel *)getOneUser {
    ELBodyFatScaleBleUserModel *user = [[ELBodyFatScaleBleUserModel alloc] init];
    user.createTime = [[NSDate date] timeIntervalSince1970];
    user.usrID = 0;
    user.role = BodyFatScaleRole_Ordinary;
    user.sex = ELBluetoothUserSex_Woman;
    user.age = 26;
    user.height = 170;
    user.weight = 600;
    user.adc = 560;
    return user;
}

- (void)dealloc {


}

@end
