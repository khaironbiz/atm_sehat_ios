//
//  ForeheadConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/8.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "ForeheadConnectViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELForeHeadBleManager.h>
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

@interface ForeheadConnectViewController ()<ELBluetoothManagerDelegate,ELForeheadBleManagerDelegate>
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ForeheadConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELForeHeadBleManager shareManager].foreheadDelegate = self;
    [ELForeHeadBleManager shareManager].delegate  =self;
    [[ELForeHeadBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELForeHeadBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELForeHeadBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELForeHeadBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    }else if (tag == 2){
    
        [[ELForeHeadBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    }else if (tag == 3){
        [[ELForeHeadBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    }else if (tag == 4){
        [[ELForeHeadBleManager shareManager] setBluetoothName:@"AILink"];
    }else if (tag == 5){
        [[ELForeHeadBleManager shareManager] changeUnit:(ELDeviceTemperatureUnit_C)];
    }else if (tag == 6){
        [[ELForeHeadBleManager shareManager] changeUnit:(ELDeviceTemperatureUnit_F)];
    }else if (tag == 7){
        
    }else if (tag == 8){
        
    }else if (tag == 9){
        
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
    [button5 setTitle:@"Change Unit To C" forState:(UIControlStateNormal)];
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
    UIButton *button6 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button6 setTitle:@"Change Unit To F" forState:(UIControlStateNormal)];
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
    [self addLog:[NSString stringWithFormat:@"CID = %d,VID = %d,PID = %d",did.deviceType,did.vendorID,did.productID]];
}

-(void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion{
    [self addLog:bmVersion];
}

//MARK:获取设备支持的单位
-(void)bluetoothManagerBackDeviceSupportUnitWithWeight:(NSArray<NSNumber *> *)weightArray Height:(NSArray<NSNumber *> *)heightArray Temperature:(NSArray<NSNumber *> *)temperatureArray BloodPressure:(NSArray<NSNumber *> *)bloodPressureArray Pressure:(NSArray<NSNumber *> *)pressureArray{
    //这里要压力和温度单位
    //设置单位时，要设置设备支持的单位
    
}
/**
 Callback temperature(回调温度)

 @param model ELForeheadBleDataModel
 */
-(void)foreheadBleManagerReceiveTemperature:(ELForeheadBleDataModel *_Nonnull)model dataType:(ForeheadBleDataType)dataType{
    [self addLog:[NSString stringWithFormat:@"temperature = %@ unit = %@  point = %ld",model.temperature,AiLinkBleTempUnitDic[@(model.unit)],model.point]];
}

/**
Set unit callback( 设置单位回调)

 @param type 结果
 */
-(void)foreheadBleManagerReceiveSetUnitResult:(ELSetBluetoothResponseType)type{
    [self addLog:[NSString stringWithFormat:@"Change Unit result = %lu",(unsigned long)type]];
}

/**
 Error code sent on the device(设备上发错误码)

 @param code 错误码
 */
-(void)foreheadBleManagerReceiveFailCode:(ForeheadFailCode)code{
    [self addLog:[NSString stringWithFormat:@"error code = %lu",(unsigned long)code]];
}

-(void)foreheadBleManagerUpdateBleState:(ELBluetoothState)state{
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
            [[ELForeHeadBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
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
