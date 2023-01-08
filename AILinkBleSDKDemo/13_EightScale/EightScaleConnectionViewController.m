//
//  EightScaleConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/9/12.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "EightScaleConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELEightScaleBleManager.h>
#import <AILinkBleSDK/ELEightScaleBleDataModel.h>
#import <AILinkBleSDK/ELEightScaleSDKHeader.h>
#import "ELEightScaleAlgorithmTool.h"
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

@interface EightScaleConnectionViewController ()<ELBluetoothManagerDelegate,EightScaleBleDeletegate>
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) NSArray<NSNumber *> *units;

@end

@implementation EightScaleConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELEightScaleBleManager shareManager].eightScaleDelegate = self;
    [ELEightScaleBleManager shareManager].delegate  =self;
    [[ELEightScaleBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELEightScaleBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELEightScaleBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELEightScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    }else if (tag == 2){
        
        [[ELEightScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    }else if (tag == 3){
        [[ELEightScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    }else if (tag == 4){
        [[ELEightScaleBleManager shareManager] setBluetoothName:@"AILink"];
    }else if (tag == 5){
        if (self.units.count==0) {
            [self addLog:@"No units obtained"];
            return;
        }
        
//        [[ELEightScaleBleManager shareManager] changeBodyFatScaleUnit:(ELDeviceWeightUnit_KG)];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change Unit" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        for (int i=0; i<self.units.count; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:AiLinkBleWeightUnitDic[self.units[i]] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [[ELEightScaleBleManager shareManager] eightScaleSwitchWeightUnit:self.units[i].integerValue];
            }];
            [alert addAction:action];
        }
        [self presentViewController:alert animated:YES completion:nil];
    }else if (tag == 6){
        
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

-(void)bluetoothManagerBackDeviceSupportUnitWithWeight:(NSArray<NSNumber *> *)weightArray Height:(NSArray<NSNumber *> *)heightArray Temperature:(NSArray<NSNumber *> *)temperatureArray BloodPressure:(NSArray<NSNumber *> *)bloodPressureArray Pressure:(NSArray<NSNumber *> *)pressureArray{
    //这里只要体重数据
    self.units = weightArray;
}

-(void)eightScaleBleReceiveAdcData:(EightScaleAdcStruct)adcStruct{
    [self addLog:[NSString stringWithFormat:@"Impedance type = %lu  adc = %d",adcStruct.adcType,adcStruct.adc]];
}


-(void)eightScaleBleReceiveHeartRateTestStep:(EightScaleHeartRateTestStep)testStep heartRate:(int)heartRate{
    [self addLog:[NSString stringWithFormat:@"HeartRate = %d",heartRate]];
}

/**
 Callback to set unit result(回调设置单位结果)
 
 @param result 结果
 */
- (void)eightScaleBleReceiveSwitchWeightUnitResult:(EightScaleSwitchUnitResult)result{
    switch (result) {
        case EightScaleSwitchUnitResultSuccess:
        {
            [self addLog:@"Change Unit Success"];
        }
            break;
        case EightScaleSwitchUnitResultFailure:
        {
            [self addLog:@"Change Unit Failure"];
        }
            break;
        case EightScaleSwitchUnitResultOperation:
        {
            [self addLog:@"Operationing"];
        }
            break;
        default:
            break;
    }
}

/**
 Return weight and body fat model(返回重量及体脂model)
 */
-(void)eightScaleBleReceiveWeightData:(EightScaleWeightStruct)weightStruct{
    switch (weightStruct.weightType) {
        case EightScaleWeightTypeAuto:
        {
            [self addLog:[NSString stringWithFormat:@"Unstable data weight = %d unit = %@ point = %d adc = %ld",weightStruct.weight,AiLinkBleWeightUnitDic[@(weightStruct.unit)],weightStruct.point,weightStruct.weightType]];
        }
            break;
        case EightScaleWeightTypeStable:
        {
            [self addLog:[NSString stringWithFormat:@"Unstable data weight = %d unit = %@ point = %d adc = %ld",weightStruct.weight,AiLinkBleWeightUnitDic[@(weightStruct.unit)],weightStruct.point,weightStruct.weightType]];
        }
            break;
        default:
            break;
    }
}

-(void)eightScaleBleReceiveTestComplete{
    [self addLog:@"Measurn Complete"];
}

#pragma mark ============ get all body fat data ==============
-(void)eightScaleBleReceiveTestData:(ELEightScaleBleDataModel *)dataModel{
    [self addLog:[NSString stringWithFormat:@"weight = %@%@",dataModel.weight,AiLinkBleWeightUnitDic[@(dataModel.weightUnit)]]];
    
    //Please input the correct height, age, gender of your app user
    ELEightScaleRecordModel *bodyInfo = [ELEightScaleAlgorithmTool getRecordModelWithBleDataModel:dataModel withUserSex:1 height:175 age:25];
    [self addLog:[NSString stringWithFormat:@"---bodyInfo:%@",bodyInfo]];
    
}

-(void)eightScaleBleReceiveErrorCode:(int)errorCode{
    [self addLog:[NSString stringWithFormat:@"Error Code is  %d",errorCode]];
}

-(void)eightScaleBleReceiveTempData:(EightScaleTempStruct)tempStruct{
    [self addLog:[NSString stringWithFormat:@"temperature is %d ",tempStruct.temp]];
}


-(void)eightScaleBleReceiveState:(ELBluetoothState)state{
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
            //获取设备支持的单位
            [[ELEightScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
            //将你自己设置的单位发给秤
            ELDeviceWeightUnit unit = ELDeviceWeightUnit_KG;
            [[ELEightScaleBleManager shareManager] eightScaleSwitchWeightUnit:unit];
            
            if (self.p.deviceType == ELSupportDeviceTypeBLE_WIFIScale) {
                //获取蓝牙连接状态
                [[ELEightScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetConnectState)];
            }
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
