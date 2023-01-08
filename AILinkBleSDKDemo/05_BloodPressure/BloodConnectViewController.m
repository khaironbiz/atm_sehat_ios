//
//  BloodConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "BloodConnectViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBloodBleManager.h>
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

@interface BloodConnectViewController ()<ELBluetoothManagerDelegate,ELBloodBleManagerDelegate>
@property (nonatomic, strong) UITextView *textView;

@end

@implementation BloodConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELBloodBleManager shareManager].bloodDelegate = self;
    [ELBloodBleManager shareManager].delegate  =self;
    [[ELBloodBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELBloodBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELBloodBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELBloodBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    }else if (tag == 2){
    
        [[ELBloodBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    }else if (tag == 3){
        [[ELBloodBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    }else if (tag == 4){
        [[ELBloodBleManager shareManager] setBluetoothName:@"AILink"];
    }else if (tag == 5){
        [[ELBloodBleManager shareManager] sendInteractiveInstructions:(ELBloodInteractionTypeStartTest)];
    }else if (tag == 6){
        [[ELBloodBleManager shareManager] sendInteractiveInstructions:(ELBloodInteractionTypeStopTest)];
    }else if (tag == 7){
        [[ELBloodBleManager shareManager] changeUnit:(ELDeviceBloodPressureUnit_mmhg)];
    }else if (tag == 8){
        [[ELBloodBleManager shareManager] sendSwitchVoice:(ELBloodBleSwitchVoiceTypeOff)];
    }else if (tag == 9){
        [[ELBloodBleManager shareManager] sendSwitchVoice:(ELBloodBleSwitchVoiceTypeOn)];
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
    [button5 setTitle:@"Start Test" forState:(UIControlStateNormal)];
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
    [button6 setTitle:@"Stop Test" forState:(UIControlStateNormal)];
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
    
    UIButton *button8 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button8 setTitle:@"Close Voice" forState:(UIControlStateNormal)];
    button8.tag = 8;
    button8.titleLabel.adjustsFontSizeToFitWidth = YES;
    button8.titleLabel.numberOfLines = 2;
    button8.backgroundColor = [UIColor blackColor];
    [button8 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button8];
    [button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(button4.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *button9 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button9 setTitle:@"Open Voice" forState:(UIControlStateNormal)];
    button9.tag = 9;
    button9.titleLabel.adjustsFontSizeToFitWidth = YES;
    button9.titleLabel.numberOfLines = 2;
    button9.backgroundColor = [UIColor blackColor];
    [button9 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button9];
    [button9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button8.mas_right).mas_offset(10);
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
    [self addLog:[NSString stringWithFormat:@"CID = %lu,VID = %d,PID = %d",(unsigned long)did.deviceType,did.vendorID,did.productID]];
}

-(void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion{
    [self addLog:bmVersion];
}
//MARK:获取设备支持的单位
-(void)bluetoothManagerBackDeviceSupportUnitWithWeight:(NSArray<NSNumber *> *)weightArray Height:(NSArray<NSNumber *> *)heightArray Temperature:(NSArray<NSNumber *> *)temperatureArray BloodPressure:(NSArray<NSNumber *> *)bloodPressureArray Pressure:(NSArray<NSNumber *> *)pressureArray{
    //这里要血压单位
    //设置单位时，要设置设备支持的单位
    
}

-(void)bloodBleManagerReceiceTestData:(ELBloodBleDataModel *)model type:(ELBloodBleDataModelType)type{
    [self addLog:[NSString stringWithFormat:@"dia = %@--sys=%@ unit = %zd point = %d",model.dia,model.sys,model.unit,model.point]];
}
-(void)bloodBleManagerReceiveSetSwitchVoiceOperationType:(ELBloodBleSwitchVoiceType)type result:(ELSetBluetoothResponseType)result{
    if (type == ELBloodBleSwitchVoiceTypeOff) {
        [self addLog:[NSString stringWithFormat:@"close voice result = %ld",result]];
    }else{
        [self addLog:[NSString stringWithFormat:@"open voice result = %ld",result]];
    }
}
-(void)bloodBleManagerReceiveSetUnitResult:(ELSetBluetoothResponseType)type{
    [self addLog:[NSString stringWithFormat:@"change unit result = %ld",type]];
}
-(void)bloodBleManagerReceiveFailCode:(ELBloodFailCode)code{
    [self addLog:[NSString stringWithFormat:@"error code = %ld",code]];
}
-(void)bloodBleManagerUpdateBleState:(ELBluetoothState)state{
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
            [[ELBloodBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
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
