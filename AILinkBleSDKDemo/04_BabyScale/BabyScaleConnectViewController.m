//
//  BabyScaleConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "BabyScaleConnectViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBabyScaleBleManager.h>
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

@interface BabyScaleConnectViewController ()<ELBluetoothManagerDelegate,BabyScaleBleDelegate>
@property (nonatomic, strong) UITextView *textView;
@end

@implementation BabyScaleConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELBabyScaleBleManager shareManager].babyScaleDelegate = self;
    [ELBabyScaleBleManager shareManager].delegate  =self;
    [[ELBabyScaleBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELBabyScaleBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELBabyScaleBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELBabyScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    }else if (tag == 2){
    
        [[ELBabyScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    }else if (tag == 3){
        [[ELBabyScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    }else if (tag == 4){
        [[ELBabyScaleBleManager shareManager] setBluetoothName:@"AILink"];
    }else if (tag == 5){
        [[ELBabyScaleBleManager shareManager] changeHold:YES];
    }else if (tag == 6){
        [[ELBabyScaleBleManager shareManager] changeHold:NO];
    }else if (tag == 7){
        [[ELBabyScaleBleManager shareManager] changeHeightUnit:(ELDeviceHeightUnit_CM) AndWeightUnit:(ELDeviceWeightUnit_KG)];
    }

}
-(void)setupUIView{
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
    [button5 setTitle:@"Hold" forState:(UIControlStateNormal)];
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
    //
    UIButton *button6 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button6 setTitle:@"Zero" forState:(UIControlStateNormal)];
    button6.tag = 6;
    button6.titleLabel.adjustsFontSizeToFitWidth = YES;
    button6.titleLabel.numberOfLines = 2;
    button6.backgroundColor = [UIColor blackColor];
    [button6 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button6];
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button5.mas_right).mas_offset(10);
        make.top.equalTo(button1.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    //
    UIButton *button7 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button7 setTitle:@"Change Unit" forState:(UIControlStateNormal)];
    button7.tag = 7;
    button7.titleLabel.adjustsFontSizeToFitWidth = YES;
    button7.titleLabel.numberOfLines = 2;
    button7.backgroundColor = [UIColor blackColor];
    [button7 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button7];
    [button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(button4.mas_bottom).mas_offset(10);
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
//错误
-(void)babyScaleBackDeviceErrorCode:(BabyScaleDeviceErrorCode)code{
    [self addLog:[NSString stringWithFormat:@"error code = %ld",code]];
}
//体重
-(void)babyScaleManagerReceiveWeightModel:(ELBabyScaleBleWeightModel *)model{
    [self addLog:[NSString stringWithFormat:@"weight = %ld unit=%@ point = %ld",model.weight,model.unitStr,model.weightPoint]];
}
//身长数据
-(void)babyScaleManagerHeightModel:(ELBabyScaleBleHeightModel *)model{
    [self addLog:[NSString stringWithFormat:@"height = %ld unit=%@ point = %ld",model.height,model.unitStr,model.heightPoint]];
}
-(void)babyScaleBackCtrlType:(NSInteger)type Results:(BabyScaleResultType)result{
//    0去皮，1锁定）
    if (type == 0) {
        if (result == BabyScaleResultType_Succeed) {
            [self addLog:@"Zero Unit success"];
        }else if (result == BabyScaleResultType_Failure){
            [self addLog:@"Zero Unit failure"];
        }else if (result == BabyScaleResultType_Unsupported){
            [self addLog:@"Zero Unit unsupported"];
        }
    }else{
        if (result == BabyScaleResultType_Succeed) {
            [self addLog:@"Hold Unit success"];
        }else if (result == BabyScaleResultType_Failure){
            [self addLog:@"Hold Unit failure"];
        }else if (result == BabyScaleResultType_Unsupported){
            [self addLog:@"Hold Unit unsupported"];
        }
    }

}
-(void)babyScaleBackSetUnitResults:(BabyScaleResultType)result{
    if (result == BabyScaleResultType_Succeed) {
        [self addLog:@"Change Unit success"];
    }else if (result == BabyScaleResultType_Failure){
        [self addLog:@"Change Unit failure"];
    }else if (result == BabyScaleResultType_Unsupported){
        [self addLog:@"Change Unit unsupported"];
    }

}
-(void)bluetoothManagerReceiceResponseType:(ELInetSetCmdType)type result:(ELSetBluetoothResponseType)result{
    if (type == ELInetSetCmdTypeSetName) {
        if (result == ELSetBluetoothResponseTypeSuccess) {
            [self addLog:@"Set name Success "];
        }else if (result == ELSetBluetoothResponseTypeFailure){
            [self addLog:@"Set name failure "];
        }else if (result == ELSetBluetoothResponseTypeNoSupport){
            [self addLog:@"Set name unsupport "];
        }

    }

}
-(void)bluetoothManagerReceiceName:(NSString *)name{
    [self addLog:name];
}
-(void)bluetoothManagerReceiveDID:(struct ELDIDStruct)did{
    [self addLog:[NSString stringWithFormat:@"CID = %d,VID = %d,PID = %d",did.deviceType,did.vendorID,did.productID]];
}

-(void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion{
    [self addLog:bmVersion];
}
//MARK:获取设备支持的单位
-(void)bluetoothManagerBackDeviceSupportUnitWithWeight:(NSArray<NSNumber *> *)weightArray Height:(NSArray<NSNumber *> *)heightArray Temperature:(NSArray<NSNumber *> *)temperatureArray BloodPressure:(NSArray<NSNumber *> *)bloodPressureArray Pressure:(NSArray<NSNumber *> *)pressureArray{
    //这里体重和身高单位
    //设置单位时，要设置设备支持的单位
    
}

-(void)babyScaleManagerUpdateState:(ELBluetoothState)state{
    switch (state) {
        case ELBluetoothStateUnavailable:
        {
            self.title = @"Please open the bluetooth";
        }
            break;
        case ELBluetoothStateAvailable:
        {
            self.title = @"Bluetooth is open";
        }
            break;
        case ELBluetoothStateScaning:
        {
            self.title = @"Scaning";
        }
            break;
        case ELBluetoothStateConnectFail:
        {
            self.title = @"Connect fail";
        }
            break;
        case ELBluetoothStateDidDisconnect:
        {
            self.title = @"Disconnected";
        }
            break;
        case ELBluetoothStateDidValidationPass:
        {
            self.title = @"Connected";
            [[ELBabyScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
        }
            break;
        case ELBluetoothStateFailedValidation:
        {
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
-(void)dealloc{
    
    
}

@end
