//
//  BloodSugarConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by cliCk on 2021/1/28.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "BloodSugarConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBloodSugarBleHeader.h>
#import <AILinkBleSDK/ELBloodSugarBleManager.h>

@interface BloodSugarConnectionViewController () <BloodSugarBleDelegate, ELBluetoothManagerDelegate>
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) NSArray<NSNumber *> *units;

@property (nonatomic, strong) UIButton *connectButton;
@end

@implementation BloodSugarConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [ELBloodSugarBleManager shareManager].bloodSugarDelegate = self;
    [ELBloodSugarBleManager shareManager].delegate = self;
    [[ELBloodSugarBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELBloodSugarBleManager shareManager] disconnectPeripheral];
}

-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",log,self.textView.text];
}

- (void)connectDevice {
    [[ELBloodSugarBleManager shareManager] startScan];
}

- (void)setupUIView {
    
    self.connectButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 88, 100, 40)];
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

- (void)bloodSugarBleReceiveState:(ELBluetoothState)state {
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
            self.connectButton.hidden = NO;
        }
            break;
        case ELBluetoothStateDidValidationPass:
        {
            self.connectButton.hidden = YES;
            self.title = @"Connected";
            //连接成功，获取单位
            [[ELBloodSugarBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeReadDeviceSupportUnit];

            //获取版本号
            [[ELBloodSugarBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];
            
            //同步时间到设备
            [[ELBloodSugarBleManager shareManager] syncMCUNowDate];
            
        
            //查询设备状态
            [[ELBloodSugarBleManager shareManager] bloodSugarQueryDeviceStatus];
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

- (void)bloodSugarBleReceiveDevices:(NSArray<ELPeripheralModel *> *)devices {
    for (ELPeripheralModel *model in devices) {
        if ([model.macAddress isEqualToString:self.p.macAddress]) {
            [[ELBloodSugarBleManager shareManager] connectPeripheral:model];
        }
    }
}

-(void)bloodSugarBleReceiveDeviceStatus:(BloodSugarDeviceStatus)status{
    if (status == BloodSugarDeviceStatusNoStatus) {
//        self.measureView.status = BloodSugarMeasureViewStatusDefault;
    } else if (status == BloodSugarDeviceStatusTestWaiting) {
        [self addLog:@"请插入试纸"];
    } else if (status == BloodSugarDeviceStatusSamplingWaiting){
        [self addLog:@"获取血样中..."];
    } else if (status == BloodSugarDeviceStatusAnalysising){
        [self addLog:@"血样分析中..."];
    } else if (status == BloodSugarDeviceStatusTestComplete){
        [self addLog:@"测量完成"];
    }
}

- (void)bloodSugarBleReceiveTestData:(BloodSugarDataStruct *)data {
    NSString *unit = [NSString string];
    if (data.unit == ELDeviceBloodSugarUnit_mmol_L) {
        unit = @"mmol/L";
    }else {
        unit = @"mg/dl";
    }
    [self addLog:[NSString stringWithFormat:@"测量结果 数值 : %d, 单位 : %@ point : %d",data.value,unit,data.point]];
}

- (void)bloodSugarBleReceiveErrorCode:(BloodSugarErrorCode)errorCode {
    NSString *errorMsg = @"测量失败";
    switch (errorCode) {
        case BloodSugarErrorCodeLowBattery:
        {
            errorMsg = @"电量不足";
        }
            break;
        case BloodSugarErrorCodeUsedTestPaper: {
            errorMsg = @"使用了已使用过的试纸";
            break;
        }
        case BloodSugarErrorCodeTempHigh: {
            errorMsg = @"环境温度超出使用范围";
            break;
        }
        case BloodSugarErrorCodeCancelTest: {
            errorMsg = @"试纸施加血样后测试未完成，被退出试纸";
            break;
        }
        case BloodSugarErrorCodePassError: {
            errorMsg = @"机器自检未通过";
            break;
        }
        case BloodSugarErrorCodeLow: {
            errorMsg = @"测量结果过低，超出测量范围";
            break;
        }
        case BloodSugarErrorCodeHigh: {
            errorMsg = @"测量结果过高，超出测量范围";
            break;
        }
    }
    
    [self addLog:[NSString stringWithFormat:@"测量结果 :%@",errorMsg]];
}

- (void)bloodSugarBleBackManufactureData:(NSData *)data {
    [self addLog:[NSString stringWithFormat:@"收到的原始数据 : %@",data]];
}

@end
