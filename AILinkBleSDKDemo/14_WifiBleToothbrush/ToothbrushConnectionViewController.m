//
//  ToothbrushConnectionViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/9/29.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "ToothbrushConnectionViewController.h"
#import <AILinkBleSDK/ELToothbrushBleManager.h>
#import "Masonry.h"
#import "ELInputAlertView.h"
#import "ELSelectView.h"
#import <AILinkBleSDK/ELBluetoothManager+BleWifi.h>

static NSString * const authorizeIntervalKey = @"authorizeIntervalKey";

@interface ToothbrushConnectionViewController ()<ToothbrushDelegate,ELBluetoothManagerDelegate,ElBleWifiDelegate>
@property (nonatomic, strong) UITextView *textView;
//附近wifi
@property (nonatomic, strong) NSMutableArray<ELBleWifiDetailModel *> *wifiArr;
@property (nonatomic, copy) NSString *wifiPwd;
@end

@implementation ToothbrushConnectionViewController

-(NSMutableArray<ELBleWifiDetailModel *> *)wifiArr{
    if (_wifiArr==nil) {
        _wifiArr = [[NSMutableArray alloc] init];
    }
    return _wifiArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [[ELToothbrushBleManager shareManager] startScan];
    [ELToothbrushBleManager shareManager].toothbrushDelegate = self;
    [ELToothbrushBleManager shareManager].delegate = self;
    [ELToothbrushBleManager shareManager].bleWifiDelegate = self;
    
}

-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag == 1) {
        //MARK:配网
        if ([ELToothbrushBleManager shareManager].state == ELBluetoothStateDidValidationPass) {
            [self.wifiArr removeAllObjects];
            [self addLog:@"正在搜索附近的WiFi..."];
            //搜索附近网络
            [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetNearbyWifi];
        }else{
            [self addLog:@"未连接设备"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (tag == 2){
        //MARK:配对
        long long interval = [[NSUserDefaults standardUserDefaults] integerForKey:authorizeIntervalKey];
        if (interval == 0) {
            interval = [[NSDate date] timeIntervalSince1970];
            [[NSUserDefaults standardUserDefaults] setInteger:interval forKey:authorizeIntervalKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self addLog:@"发起配对"];
        [[ELToothbrushBleManager shareManager] requestDeviceAuthorization:interval];
    }
    else if (tag == 3){
        //MARK:获取设备ID
        [self addLog:@"请求设备ID"];
        [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetSNNumber];
    }
    else if (tag == 4){
        //MARK:获取档位
        [self addLog:@"请求支持的档位"];
        [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBasicInfoData];
    }else if (tag == 5){
        //MARK:获取三轴方向
        [self addLog:@"获取三轴方向"];
        [[ELToothbrushBleManager shareManager] getTriaxialDirection];
    }else if (tag == 6){
        //MARK:获取三轴数据
        [self addLog:@"获取三轴数据"];
        [[ELToothbrushBleManager shareManager] getTriaxialData];
    }else if (tag == 7){
        //MARK:查询默认刷牙时长和工作档位
        [self addLog:@"查询默认刷牙时长和工作档位"];
        [[ELToothbrushBleManager shareManager] getWorkGear];
    }
    else if (tag == 8){
        //MARK:查询手动设置信息
        [self addLog:@"查询手动设置信息"];
        [[ELToothbrushBleManager shareManager] getCustomGear];
    }
    else if (tag == 9){
        //MARK:查询二级档位默认值
        [self addLog:@"查询二级档位默认值"];
        [[ELToothbrushBleManager shareManager] getTwoGearDefualt];
    }else if (tag == 10){
        //MARK:上报工作阶段
        [self addLog:@"上报工作阶段"];
        [[ELToothbrushBleManager shareManager] getWorkPhase];
    }
    else if (tag == 11){
        //MARK:设置刷牙模式
        [self addLog:@"设置刷牙模式:舒柔"];
        [[ELToothbrushBleManager shareManager] setWorkGear:(ToothbrushGearTypeSoft_0A) interval:120 supportGearType:(ToothSupportGearTypeOneGear_01)];
    }else if (tag == 12){
        //MARK:开关
        [self addLog:@"开关"];
        [[ELToothbrushBleManager shareManager] switchToothbrush];
    }else if (tag == 13){
        //MARK:设置二档默认
        [self addLog:@"设置二档默认(清洁)"];
        [[ELToothbrushBleManager shareManager] setTwoGearDefaultGear:(ToothbrushGearTypeClean_01)];
    }else if (tag == 14){
        //MARK:试用
        [self addLog:@"试用,手动设置,二档,frequency:67 duty:50"];
        [[ELToothbrushBleManager shareManager] tryGear:(ToothbrushGearTypeCustom_FF) supportType:(ToothSupportGearTypeTwoGear_02) frequency:67 duty:50];
    }else if (tag == 15){
        //MARK:设置手动档
        [self addLog:@"设置手动档:frequency:67 duty:50 interval:120"];
        [[ELToothbrushBleManager shareManager] setCustomGearData:67 duty:50 interval:120];
    }else if (tag == 16){
        //MARK:上报接收数据结果
        [self addLog:@"上报接收数据结果"];
        [[ELToothbrushBleManager shareManager] reportReceiveResultOfToothbrushData:YES];
    }
    else{
        
    }

}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [self getButtonWithTitle:@"配网" withTag:1];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(70);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button2 = [self getButtonWithTitle:@"配对" withTag:2];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1.mas_right).mas_offset(5);
        make.top.equalTo(button1);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button3 = [self getButtonWithTitle:@"获取设备ID" withTag:3];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button2.mas_right).mas_offset(5);
        make.top.equalTo(button2);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button4 = [self getButtonWithTitle:@"获取档位" withTag:4];
    [self.view addSubview:button4];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button3.mas_right).mas_offset(5);
        make.top.equalTo(button3);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button5 = [self getButtonWithTitle:@"获取三轴方向" withTag:5];
    [self.view addSubview:button5];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(button4.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button6 = [self getButtonWithTitle:@"获取三轴数据" withTag:6];
    [self.view addSubview:button6];
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button5.mas_right).mas_offset(5);
        make.top.equalTo(button5);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button7 = [self getButtonWithTitle:@"查询默认模式和时长" withTag:7];
    [self.view addSubview:button7];
    [button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button6.mas_right).mas_offset(5);
        make.top.equalTo(button6);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button8 = [self getButtonWithTitle:@"查询手动设置" withTag:8];
    [self.view addSubview:button8];
    [button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button7.mas_right).mas_offset(5);
        make.top.equalTo(button7);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button9 = [self getButtonWithTitle:@"查询二级档位默认" withTag:9];
    [self.view addSubview:button9];
    [button9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button5);
        make.top.equalTo(button5.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button10 = [self getButtonWithTitle:@"上报工作阶段" withTag:10];
    [self.view addSubview:button10];
    [button10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button9.mas_right).mas_offset(5);
        make.top.equalTo(button9);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button11 = [self getButtonWithTitle:@"设置刷牙模式(0A)" withTag:11];
    [self.view addSubview:button11];
    [button11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button10.mas_right).mas_offset(5);
        make.top.equalTo(button9);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button12 = [self getButtonWithTitle:@"开关" withTag:12];
    [self.view addSubview:button12];
    [button12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button11.mas_right).mas_offset(5);
        make.top.equalTo(button9);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button13 = [self getButtonWithTitle:@"设置二档默认" withTag:13];
    [self.view addSubview:button13];
    [button13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button9);
        make.top.equalTo(button9.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button14 = [self getButtonWithTitle:@"试用" withTag:14];
    [self.view addSubview:button14];
    [button14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button13.mas_right).mas_offset(5);
        make.top.equalTo(button13);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button15 = [self getButtonWithTitle:@"设置手动档" withTag:15];
    [self.view addSubview:button15];
    [button15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button14.mas_right).mas_offset(5);
        make.top.equalTo(button13);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];

    UIButton *button16 = [self getButtonWithTitle:@"上报接收数据结果" withTag:16];
    [self.view addSubview:button16];
    [button16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button15.mas_right).mas_offset(5);
        make.top.equalTo(button13);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    //
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.text = @"Log";
    self.textView.textColor = [UIColor redColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(200);
    }];
    
}

-(UIButton *)getButtonWithTitle:(NSString *)title withTag:(NSInteger)tag{
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button1 setTitle:title forState:(UIControlStateNormal)];
    button1.tag = tag;
    button1.titleLabel.adjustsFontSizeToFitWidth = YES;
    button1.titleLabel.numberOfLines = 2;
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1 setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    button1.backgroundColor = [UIColor blackColor];
    button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    button1.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return button1;
}

-(void)connectWiFiWithPwd:(NSString *)pwd wifi:(ELBleWifiDetailModel *)wifi{
    [self addLog:@"正在配置WiFi名称"];
    self.wifiPwd = pwd;
    [[ELToothbrushBleManager shareManager] bleWifiSetConnectWifiMac:wifi.macData];
    
}

-(void)connectWiFi:(ELBleWifiDetailModel *)wifi{
    if (wifi.secureType ==ELBleWifiSecureTypeOpen) {
        [self connectWiFiWithPwd:@"" wifi:wifi];
    }else{
        ELInputAlertView *input = [[ELInputAlertView alloc] initWithTittle:@"配置WiFi" withText:@"" withMessage:@"请输入WiFi密码" withLeftButton:@"取消" withRightButton:@"确定"];

        [input show];
        __weak typeof(self) weakSelf = self;
        input.rightHideBlock = ^BOOL(NSString * _Nonnull text, UIView * _Nonnull view) {
            if ([ELBlePublicTool legalBleWifiPassword:text]) {
                [weakSelf connectWiFiWithPwd:text wifi:wifi];
                return YES;
            }else{
                [self addLog:@"请输入8～56位的密码"];
                return NO;
            }

        };
    }
}
#pragma mark ============ ElBleWifiDelegate ==============

//获取设备ID
-(void)bleWifiReceiveWifiSNCode:(int)code{
    if (code == 0) {
        [self addLog:@"设备ID不存在,请先配网再获取"];
    }else{
        [self addLog:[NSString stringWithFormat:@"设备ID = %d",code]];
    }

    
}
//设置wifi过程结果
-(void)bleWifiReceiceResponseType:(ELInetSetCmdType)type result:(ELSetBluetoothResponseType)result{
    if (result == ELSetBluetoothResponseTypeSuccess) {
        //设置WiFi结果
        if (type == ELInetSetCmdTypeBleWifiSetWifiMac) {
            [self addLog:@"正在配置WiFi密码"];
            [[ELToothbrushBleManager shareManager] bleWifiSetWifiPwd:self.wifiPwd];
        }else if (type == ELInetSetCmdTypeBleWifiSetWifiPwd){
            [self addLog:@"设置WiFi连接"];
            [[ELToothbrushBleManager shareManager] bleWifiSetupWifiConnect:YES];
        }else if (type == ELInetSetCmdTypeBleWifiSetConnectWifi){
            //获取连接状态
        }
    }
    else{
        [self addLog:@"WiFi配置失败"];
    }
}
//附近wifi
-(void)bleWifiReceiveWifiDetailModel:(ELBleWifiDetailModel *)model{
    [self addLog:[NSString stringWithFormat:@"搜索到wifi类型---%lu 名称---%@",(unsigned long)model.wifiState,model.wifiName]];
    if (model.wifiState == ELBleWifiUseStateConnected) {
        
    }
    [self.wifiArr addObject:model];
    
}
//附近wifi搜索结果
-(void)bleWifiReceiveScanedWifiCount:(int)count {
    
    [self addLog:@"搜索完成"];
    //扫描结束
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<self.wifiArr.count; i++) {
        ELBleWifiDetailModel *model = self.wifiArr[i];
        NSString *wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%lu 名称:%@",(unsigned long)model.secureType,model.wifiName];
        if (model.secureType == ELBleWifiSecureTypeOpen) {
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"Open",model.wifiName];
        }else if (model.secureType == ELBleWifiSecureTypeWEP){
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"WEP",model.wifiName];
        }else if (model.secureType == ELBleWifiSecureTypeWPA_PSK){
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"WPA_PSK",model.wifiName];
        }else if (model.secureType == ELBleWifiSecureTypeWPA2_PSK){
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"WPA2_PSK",model.wifiName];
        }else if (model.secureType == ELBleWifiSecureTypeWPA_WPA_2_PSK){
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"WPA_WPA_2_PSK",model.wifiName];
        }else if (model.secureType == ELBleWifiSecureTypeWPA2_ENTERPRISE){
            wifiTypeStr = [NSString stringWithFormat:@"wifi类型:%@ 名称:%@",@"WPA2_ENTERPRISE",model.wifiName];
        }

        [array addObject:wifiTypeStr];
    }
    ELSelectView *selectView = [[ELSelectView alloc] initWithTitle:@"附近WiFi" withSelectArray:array];
    [selectView show];
    __weak typeof(self) weakSelf = self;
    selectView.selectRowBlock = ^(NSInteger row) {
        [weakSelf connectWiFi:weakSelf.wifiArr[row]];
    };
    
}
//连接状态
-(void)toothbrushReceiveState:(ELBluetoothState)state{
    if (state == ELBluetoothStateUnavailable) {
        self.title = @"请打开蓝牙";
    }else if (state == ELBluetoothStateScaning || state == ELBluetoothStateWillConnect || state == ELBluetoothStateDidConnect){
        self.title = @"正在连接...";
    }else if (state == ELBluetoothStateConnectFail || state == ELBluetoothStateDidDisconnect || state == ELBluetoothStateFailedValidation){
        self.title = @"连接断开";
    }else if (state == ELBluetoothStateDidValidationPass){
        self.title = @"连接成功";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.title = self.p.macAddress;
        });
        //获取版本号
        [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBMVersion)];
        //获取电量
        [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetBatteryState)];
        //获取蓝牙和wifi连接状态
        [[ELToothbrushBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetConnectState)];
    }
}
#pragma mark ============ ELBluetoothManagerDelegate ==============

//
-(void)bluetoothManagerReceiveDeviceAuthorizeResult:(ELBluetoothDeviceAuthorizeResult)result{
    if (result == ELBluetoothDeviceAuthorizeResultNoAuth) {
        [self addLog:@"没有授权，请授权"];
    }else if (result == ELBluetoothDeviceAuthorizeResultAuthorized){
        [self addLog:@"已经授权"];
    }else if (result == ELBluetoothDeviceAuthorizeResultNoNeed){
        [self addLog:@"不需要授权"];
    }else if (result == ELBluetoothDeviceAuthorizeResultSuccess){
        [self addLog:@"授权成功"];
    }
}
//蓝牙和wifi连接状态
-(void)bluetoothManagerReceiveMCUConnectedState:(struct ELMCUStateStruct)stateStrct{
    [self addLog:[NSString stringWithFormat:@"wifi连接状态：%lu \n0:没有连接\n1:尝试连接热点，但是失败\n2:连接热点，热点无网络\n3:连接热点，热点有网络\n4:有热点信息，未连接",(unsigned long)stateStrct.wifiState]];
}
//电量
-(void)bluetoothManagerReceiveBattery:(struct ELBatteryStruct)battery{
    [self addLog:[NSString stringWithFormat:@"设备电量为：%d",battery.power]];
}
//版本号
-(void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion{
    [self addLog:[NSString stringWithFormat:@"BM版本号为：%@",bmVersion]];
}
#pragma mark ============ ToothbrushDelegate ==============

//试用
-(void)toothbrushReceiveTryResult:(ToothbrushSetResult)result{
    [self addLog:[NSString stringWithFormat:@"试用结果：%lu",result]];
}
//设置二档默认
-(void)toothbrushReceiveSettingTwoGearDefaultResult:(ELSetBluetoothResponseType)result{
    [self addLog:[NSString stringWithFormat:@"设置二档默认结果：%lu",result]];
}
//开关
-(void)toothbrushReceiveSwitchResult:(ToothbrushSetResult)result{
    [self addLog:[NSString stringWithFormat:@"开关结果：%lu",result]];
}
//设置刷牙模式结果
-(void)toothbrushReceiveSetWorkGearResult:(ELSetBluetoothResponseType)result{
    [self addLog:[NSString stringWithFormat:@"设置刷牙模式结果：%lu",(unsigned long)result]];
}
//刷牙数据
-(void)toothbrushtReceiveToothbrushData:(ToothbrushData)data{
    [self addLog:[NSString stringWithFormat:@"刷牙数据:档位=%lu,工作时长=%d,左时长=%d,右时长=%d,电量=%d",(unsigned long)data.gear,data.workTime,data.leftTime,data.rightTime,data.battery]];
}
//上报工作阶段
-(void)toothbrushReceiveWorkPhase:(ToothBrushWorkPhase)workPhase{
    [self addLog:[NSString stringWithFormat:@"当前工作阶段:%lu,档位：%lu, 第%lu档",workPhase.workPhase,workPhase.gear,workPhase.supportType]];
}
//获取二档档位信息
-(void)toothbrushReceiveTwoGearDefault:(ToothbrushGearType)gear{
    [self addLog:[NSString stringWithFormat:@"二档默认档：%lu",gear]];
}
//手动设置信息
-(void)toothbrushReceiveCustomData:(ToothbrushCustomData)custom{
    [self addLog:[NSString stringWithFormat:@"频率：%d 占空比:%d 时长：%d",custom.frequency,custom.duty,custom.interval]];
}
//默认档位和时长
-(void)toothbrushReceiveWorkGear:(ToothbrushWorkGear)workGear{
    [self addLog:[NSString stringWithFormat:@"档位：%lu 时长：%d",workGear.gearType,workGear.interval]];
}
//三轴数据
-(void)toothbrushReceiveTriaxialData:(BOOL)success triaxialX:(int)x triaxialY:(int)y triaxialZ:(int)z{
    if (success) {
        [self addLog:[NSString stringWithFormat:@"三轴数据：x = %d , y = %d , = %d",x,y,z]];
    }else{
        [self addLog:@"三轴数据获取失败"];
    }

}
//三轴方向
-(void)toothbrushReceiveTriaxialDirection:(ToothbrushTriaxialDirection)direction{
    if (direction == ToothbrushTriaxialDirectionYTop_01) {
        [self addLog:@"Y轴朝上"];
    }else if (direction == ToothbrushTriaxialDirectionYBottom_02){
        [self addLog:@"Y轴朝下"];
    }else if (direction == ToothbrushTriaxialDirectionYLeft_03){
        [self addLog:@"Y轴朝左"];
    }else if (direction == ToothbrushTriaxialDirectionYRight_04){
        [self addLog:@"Y轴朝右"];
    }

}
-(void)toothbrushReceiveOneGear:(NSArray<NSNumber *> *)oneGear twoGear:(NSArray<NSNumber *> *)twoGear{
    NSString *onegearStr = @"一档：";
    for (NSNumber *one in oneGear) {
        onegearStr = [NSString stringWithFormat:@"%@,%@",onegearStr,one];
    }
    NSString *twogearStr = @"二档：";
    for (NSNumber *two in twoGear) {
        twogearStr = [NSString stringWithFormat:@"%@,%@",twogearStr,two];
    }
    [self addLog:[NSString stringWithFormat:@"%@\n%@",onegearStr,twogearStr]];
}

-(void)toothbrushReceiveDevices:(NSArray<ELPeripheralModel *> *)devices{
     ELPeripheralModel * connectModel;
    for (ELPeripheralModel *deviceModel in devices) {
        if ([deviceModel.macAddress isEqualToString:self.p.macAddress]) {
            connectModel = deviceModel;
            break;
        }
    }
    if (connectModel) {
        [[ELToothbrushBleManager shareManager] connectPeripheral:connectModel];
    }

}
-(void)dealloc{
    [[ELToothbrushBleManager shareManager] disconnectPeripheral];
}

@end
