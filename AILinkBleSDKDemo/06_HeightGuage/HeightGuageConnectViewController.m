//
//  HeightGuageConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "HeightGuageConnectViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELHeightGaugeBleManager.h>
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>

@interface HeightGuageConnectViewController ()<ELBluetoothManagerDelegate,ELHeightGaugeBleManagerDelegate>
@property (nonatomic, strong) UITextView *textView;

@end

@implementation HeightGuageConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELHeightGaugeBleManager shareManager].heightGaugeDelegate = self;
    [ELHeightGaugeBleManager shareManager].delegate  =self;
    [[ELHeightGaugeBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELHeightGaugeBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELHeightGaugeBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    [self addLog:sender.titleLabel.text];
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //getBluetoothInfoWithELInetGetCmdType是获取设备信息的方法
        [[ELHeightGaugeBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
    }else if (tag == 2){
    
        [[ELHeightGaugeBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetC_V_P_ID)];
    }else if (tag == 3){
        [[ELHeightGaugeBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetName)];
    }else if (tag == 4){
        [[ELHeightGaugeBleManager shareManager] setBluetoothName:@"AILink"];
    }else if (tag == 5){
        [[ELHeightGaugeBleManager shareManager] changeUnit:(ELDeviceHeightUnit_CM)];
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
    [button5 setTitle:@"Change Unit" forState:(UIControlStateNormal)];
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
    //这里要身高单位
    //设置单位时，要设置设备支持的单位
    
}

/**
 call back ELHeightGaugeBleDataModel
 */
-(void)heightGaugeBleManagerReceiceTestData:(ELHeightGaugeBleDataModel *_Nonnull)model{
    [self addLog:[NSString stringWithFormat:@"height = %ld  unit = %@ point = %ld",model.height,AiLinkBleHeightUnitDic[@(model.heightUnit)],model.heightPoint]];
}

/**
 call back the result of set unit
 */
-(void)heightGaugeBleManagerReceiveSetUnitResult:(ELSetBluetoothResponseType)type{
    [self addLog:[NSString stringWithFormat:@"change unit result = %lu",(unsigned long)type]];
}

/**
 call back fail code
 */
-(void)heightGaugeBleManagerReceiveFailCode:(ELHeightGaugeFailCode)code{
    [self addLog:[NSString stringWithFormat:@"error code = %lu",(unsigned long)code]];
}
-(void)heightGaugeBleManagerUpdateBleState:(ELBluetoothState)state{
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
            [[ELHeightGaugeBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeReadDeviceSupportUnit)];
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
