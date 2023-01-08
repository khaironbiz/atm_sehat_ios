//
//  OximeterConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by cliCk on 2021/1/28.
//  Copyright © 2021 IOT. All rights reserved.
//

#import "OximeterConnectionViewController.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELOximeterBleManager.h>
#import <AILinkBleSDK/ELPeripheralModel.h>
#import <AILinkBleSDK/ELOximeterBleModel.h>

@interface OximeterConnectionViewController () <ELOximeterBleDelegate, ELBluetoothManagerDelegate>
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) NSArray<NSNumber *> *units;
@end

@implementation OximeterConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [ELOximeterBleManager shareManager].oximeterBleDelegate = self;
    [ELOximeterBleManager shareManager].delegate = self;
    [[ELOximeterBleManager shareManager] connectPeripheral:self.p];
    
    [self setupUIView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[ELOximeterBleManager shareManager] disconnectPeripheral];
}

-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n\n%@",log,self.textView.text];
}

- (void)setupUIView {
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.text = @"Log";
    self.textView.textColor = [UIColor redColor];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.offset(-44);
        make.top.offset(150);
    }];
}

#pragma mark - ble Delegate

- (void)oximeterManagerBleState:(ELBluetoothState)state {
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
            //获取设备设置信息
            [[ELOximeterBleManager shareManager] sendToBleWithGetDeviceStaus];
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

- (void)oximeterManagerSetupState:(ELOximeterBleModel *)bleModel markType:(enum OximeterTestMarkType)markType {
    
    NSString *logString = [NSString stringWithFormat:@"SpO2 : %zd \n bpm : %zd \n PI : %.1f \n power : %zd",bleModel.SpO2,bleModel.pulseRate,bleModel.pi/10.f,bleModel.power];
    
    [self addLog:logString];
}

- (void)oximeterManagerBleBackManufactureData:(NSData *)data {
    [self addLog:[NSString stringWithFormat:@"收到的原始数据 : %@",data]];
}

@end
