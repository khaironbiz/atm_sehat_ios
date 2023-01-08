//
//  BodyFatScaleConnectViewController.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/8.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "ELBfsWifiConnectVC.h"
#import "Masonry.h"
#import <AILinkBleSDK/ELBodyFatScaleBleManager.h>
#import <AILinkBleSDK/ELBodyFatScaleBleUserModel.h>
#import <AILinkBleSDK/ELBodyFatScaleBleWeightModel.h>
#import "ELBfsWifiConnectTableViewCell.h"
#import <AILinkBleSDK/ELBluetoothManager+Settings.h>
#import <AILinkBleSDK/ELBleWifiDetailModel.h>
#import <AILinkBleSDK/ELBluetoothManager+BleWifi.h>

@interface ELBfsWifiConnectVC ()<ELBluetoothManagerDelegate,ELBodyFatScaleBleDelegate,ElBleWifiDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ELBleWifiDetailModel *> *dataSource;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *changeIpBtn;

@end

@implementation ELBfsWifiConnectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ELBodyFatScaleBleManager shareManager].bodyFatScaleDelegate = self;
    [ELBodyFatScaleBleManager shareManager].delegate  = self;
    [[ELBodyFatScaleBleManager shareManager] connectPeripheral:self.p];
    [ELBodyFatScaleBleManager shareManager].bleWifiDelegate = self;
    
    self.dataSource = [NSMutableArray array];
    [self setupUIView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ELBodyFatScaleBleManager shareManager] disconnectPeripheral];
}
-(void)addLog:(NSString *)log{
    self.textView.text = [NSString stringWithFormat:@"%@\n%@",log,self.textView.text];
}
-(void)buttonAction:(UIButton *)sender{
    if ([ELBodyFatScaleBleManager shareManager].state != ELBluetoothStateDidValidationPass) {
        [self addLog:@"Disconnected"];
        return;
    }
    
    switch (sender.tag) {
        case 1: {
            //获取BM Version
            [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeGetBMVersion];
        }
            break;
        case 2: {
            //Get CVP ID
            [self addLog:[NSString stringWithFormat:@"Cid:%zd, Vid:%zd, Pid:%zd",self.p.deviceType,self.p.vendorID,self.p.productID]];
        }
            break;
        case 3: {
            //Get Name
            [self addLog:[NSString stringWithFormat:@"DeviceName:%@",self.p.deviceName]];
        }
            break;
        case 4: {
            //Set name
            [[ELBodyFatScaleBleManager shareManager] setBluetoothName:@"Ailink_Dev"];
        }
            break;
        case 5: {
            //Change unit
            if (sender.selected) {
                [[ELBodyFatScaleBleManager shareManager] changeBodyFatScaleUnit:ELDeviceWeightUnit_LB];
                [self addLog:@"set lb unit"];
            } else {
                [[ELBodyFatScaleBleManager shareManager] changeBodyFatScaleUnit:ELDeviceWeightUnit_KG];
                [self addLog:@"set kg unit"];
            }
            sender.selected = !sender.selected;
        }
            break;
        default:
            break;
    }
    
    [self addLog:sender.titleLabel.text];
}

-(void)setupUIView{
//    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [button1 setTitle:@"Get BM Version" forState:(UIControlStateNormal)];
//    button1.tag = 1;
//    button1.titleLabel.adjustsFontSizeToFitWidth = YES;
//    button1.titleLabel.numberOfLines = 2;
//    button1.backgroundColor = [UIColor blackColor];
//    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button1];
//    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(85);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(40);
//    }];
//
//    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [button2 setTitle:@"Get C V P ID" forState:(UIControlStateNormal)];
//    button2.tag = 2;
//    button2.titleLabel.adjustsFontSizeToFitWidth = YES;
//    button2.titleLabel.numberOfLines = 2;
//    button2.backgroundColor = [UIColor blackColor];
//    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button2];
//    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(button1.mas_right).mas_offset(10);
//        make.top.mas_equalTo(85);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(40);
//    }];
//
//    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [button3 setTitle:@"Get Name" forState:(UIControlStateNormal)];
//    button3.tag = 3;
//    button3.titleLabel.adjustsFontSizeToFitWidth = YES;
//    button3.titleLabel.numberOfLines = 2;
//    button3.backgroundColor = [UIColor blackColor];
//    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button3];
//    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(button2.mas_right).mas_offset(10);
//        make.top.mas_equalTo(85);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(40);
//    }];
//    //
//    UIButton *button4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [button4 setTitle:@"Set Name" forState:(UIControlStateNormal)];
//    button4.tag = 4;
//    button4.titleLabel.adjustsFontSizeToFitWidth = YES;
//    button4.titleLabel.numberOfLines = 2;
//    button4.backgroundColor = [UIColor blackColor];
//    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:button4];
//    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.equalTo(button1.mas_bottom).mas_offset(10);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(40);
//    }];
    
    UIButton *button5 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button5 setTitle:@"Change unit" forState:(UIControlStateNormal)];
    button5.tag = 5;
    button5.titleLabel.adjustsFontSizeToFitWidth = YES;
    button5.titleLabel.numberOfLines = 2;
    button5.backgroundColor = [UIColor blackColor];
    [button5 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button5];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(button4.mas_right).mas_offset(10);
//        make.top.equalTo(button1.mas_bottom).mas_offset(10);
        make.left.offset(10);
        make.top.offset(90);
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
        make.height.mas_equalTo(300);
    }];
    
    self.changeIpBtn = [[UIButton alloc] init];
    [self.changeIpBtn setTitle:@"Switch to the test environment" forState:UIControlStateNormal];
    [self.changeIpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.changeIpBtn setTitle:@"Switch to the formal environment" forState:UIControlStateSelected];
    [self.changeIpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.changeIpBtn.adjustsImageWhenHighlighted = YES;
    self.changeIpBtn.backgroundColor = [UIColor blackColor];
    self.changeIpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.changeIpBtn.titleLabel.numberOfLines = 2;
    [self.changeIpBtn addTarget:self action:@selector(changeDevIpAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeIpBtn];
    [self.changeIpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button5.mas_right).mas_offset(10);
        make.centerY.equalTo(button5.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
        
//        make.left.offset(20);
//        make.top.offset(100);
//        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.changeIpBtn.mas_bottom).offset(15);
        make.bottom.equalTo(self.textView.mas_top).offset(-20);
    }];
}


-(void)bodyFatScaleManagerUpdateState:(ELBluetoothState)state{
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
            
            if (self.p.deviceType == ELSupportDeviceTypeBLE_WIFIScale) {
                //获取蓝牙连接状态
                [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeGetConnectState)];
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


-(void)bluetoothManagerReceiveMCUConnectedState:(struct ELMCUStateStruct)stateStrct{
    
    BleWiFiConnectState wifiState = stateStrct.wifiState;
    

    if (self.p.deviceType == ELSupportDeviceTypeBLE_WIFIScale) { //蓝牙WiFi体脂秤
        //请求会话码
        [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetSNNumber];
        //MARK:1.WiFi配置提示用户配网
        //TODO:注意：wifi配置过程必须保持蓝牙与设备的连接
        if (wifiState == BleWiFiConnectStateNoWiFi) {
            //1.如果没有配网，则提示用户去配网
            //MARK:2.WiFi配置先获取wifi列表
            [self.dataSource removeAllObjects];
            [self.tableView reloadData];
            [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetNearbyWifi];
        } else {
            //MARK:2.没网也可以获取Wi-Fi列表，如果需要更新Wi-Fi的话
            [self.dataSource removeAllObjects];
            [self.tableView reloadData];
            [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetNearbyWifi];
        }
    }
    ///MARK:9.wifi配置结果
    //wifi相关的其他指令和数据接收，请查看ELBluetoothManager.h文件
    if (stateStrct.wifiState == BleWiFiConnectStateSuccess) {
        //成功
        //MARK:10.获取wifi设备的SN号，即设备id
        [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:(ELInetGetCmdTypeBleWifiGetSNNumber)];
    }else{
        //失败
    }

}


//MARK:回调Wifi列表
-(void)bleWifiReceiveWifiDetailModel:(ELBleWifiDetailModel *)model{
    //用一个tableview显示喽
    [self addLog:[NSString stringWithFormat:@"wifi type---%lu name---%@ link state--%zd",(unsigned long)model.wifiState,model.wifiName,model.wifiState]];
    //    MARK:3.WiFi配置得到Wifi列表
    if (model.wifiName.length > 0) {
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
    
}
-(void)bleWifiReceiveScanedWifiCount:(int)count {
    //MARK:扫描Wifi结束
    //MARK:4.WiFi配置得到一个附近wifi的列表，点击选择一个wifi，进行配置
    [self.tableView reloadData];
    
}
-(void)bleWifiReceiceResponseType:(ELInetSetCmdType)type result:(ELSetBluetoothResponseType)result{
    
    [self addLog:[NSString stringWithFormat:@"bleWifiReceiceResponseType==%lu----%lu",type,result]];
    if (result == ELSetBluetoothResponseTypeSuccess) {
        //设置WiFi结果
        if (type == ELInetSetCmdTypeBleWifiSetWifiMac) {
            
        }else if (type == ELInetSetCmdTypeBleWifiSetWifiPwd){
            //MARK:8.然后发起连接Wifi
            [[ELBodyFatScaleBleManager shareManager] bleWifiSetupWifiConnect:YES];
        }else if (type == ELInetSetCmdTypeBleWifiSetConnectWifi){
            //获取连接状态,更新Wi-Fi列表
            [self.dataSource removeAllObjects];
            [self.tableView reloadData];
            [[ELBodyFatScaleBleManager shareManager] getBluetoothInfoWithELInetGetCmdType:ELInetGetCmdTypeBleWifiGetNearbyWifi];
        }
    }
    else{
        //TODO:Wifi配置过程中失败的情况自行处理
    }
    
}

-(void)bleWifiReceiveWifiSNCode:(int)code{
    //MARK:11.根据wifi设备的设备id从服务器获取离线数据（找自己后台要接口）
}


#pragma mark - textField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@",textField.text);
    
    //MARK:7.再发送配置wifi的密码的指令
    [[ELBodyFatScaleBleManager shareManager] bleWifiSetWifiPwd:textField.text];
}

#pragma mark - tableView Delegate And DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ELBfsWifiConnectTableViewCell";
    ELBfsWifiConnectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ELBfsWifiConnectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    ELBleWifiDetailModel *model = self.dataSource[indexPath.row];
    
    cell.wifiName = model.wifiName;
    if (model.wifiState == ELBleWifiUseStateConnected) {
        cell.isLink = YES;
    } else {
        cell.isLink = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ELBleWifiDetailModel *model = self.dataSource[indexPath.row];
    
    //MARK:5.先发送配置wifi的mac地址的指令
    [[ELBodyFatScaleBleManager shareManager] bleWifiSetConnectWifiMac:model.macData];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入wifi密码" message:model.wifiName preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确认按钮");
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    //MARK:6.输入wifi密码
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        textField.delegate = self;
    }];
    
    [alert addAction:conform];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 切换秤环境

static NSString *formalAddress = @"ailink.iot.aicare.net.cn";
static NSString *testAddress = @"test.ailink.revice.aicare.net.cn";
//static NSString *pathURL = @"/devivce/serverRedirect/";
static NSInteger portNumber = 80;

- (void)changeDevIpAddress:(UIButton *)sender {
//    if ([self.title isEqualToString:@"Connected"]) {
        if (sender.selected) {
            //切换到生产环境
            [[ELBodyFatScaleBleManager shareManager] setDevAccessIpAddress:formalAddress portNumber:portNumber path:@""];
            [self addLog:@"Start to configure as a production environment（开始配置为生产环境"];
        } else {
            //切到测试环境
            [[ELBodyFatScaleBleManager shareManager] setDevAccessIpAddress:testAddress portNumber:portNumber path:@""];
//            [[ELBodyFatScaleBleManager shareManager] setDevAccessIpAddress:@"ABCD1234567890" path:pathURL];
            [self addLog:@"Start to configure as a test environment（开始配置为测试环境"];
        }
//        sender.selected = !sender.selected;
//    } else {
//        [self addLog:@"当前设备未连接"];
//    }
    
}

/** 返回ip地址配置结果 */
- (void)bodyFatScaleManagerCallBackSetIPAddressResult:(NSInteger)result {
    NSString *resultStr = @"";
    if (result == 0) {
        //失败
        resultStr = @"Environment configuration failed（环境配置失败";
    } else if (result == 1) {
        //成功
        resultStr = @"Environment configuration is successful（环境配置成功";
        self.changeIpBtn.selected = !self.changeIpBtn.selected;
    } else {
        //不支持
        resultStr = @"The current device does not support environment configuration（当前设备不支持环境配置";
    }
    [self addLog:resultStr];
}


#pragma mark -

- (void)dealloc
{
    [[ELBodyFatScaleBleManager shareManager] disconnectPeripheral];
}



#pragma mark ============ 如下是蓝牙交互部分，wifi不用管 ==============


- (void)bluetoothManagerReceiveBMVersion:(NSString *)bmVersion {
    [self addLog:[NSString stringWithFormat:@"BMVersion :%@",bmVersion]];
}

/**
 MCU requests user information( MCU 请求用户信息)

 @param status 请求状态
 */
- (void)bodyFatScaleManagerMCURequestAppUserInfoType:(BodyFatScaleMCURequestUserInfoStatus)status{
    if (status == BodyFatScaleMCURequestUserInfoStatus_Get) {
        //下发当前用户给秤
        [[ELBodyFatScaleBleManager shareManager] sendCurrentUserToBle:[self getOneUser]];
    }else if (status == BodyFatScaleMCURequestUserInfoStatus_Success){
        [self addLog:@"MCU requests user information success"];
    }else if (BodyFatScaleMCURequestUserInfoStatus_Fail){
        [self addLog:@"MCU requests user information failure"];
    }

}


/**
 Return weight and body fat model(返回重量及体脂model)
 */
-(void)bodyFatScaleManagerCallBackWeight:(ELBodyFatScaleBleWeightModel *)weightModel state:(BodyFatScaleMeasureStatus)status{
    switch (status) {
        case BodyFatScaleMeasureStatus_Unstable:
        {
            [self addLog:[NSString stringWithFormat:@"Unstable data weight = %ld unit = %@ point = %ld adc = %ld",weightModel.weight,AiLinkBleWeightUnitDic[@(weightModel.weightUnit)],weightModel.weightPoint,weightModel.adc]];
        }
            break;
        case BodyFatScaleMeasureStatus_Stable:
        {
            [self addLog:[NSString stringWithFormat:@"Stable data weight = %ld unit = %@ point = %ld adc = %ld",weightModel.weight,AiLinkBleWeightUnitDic[@(weightModel.weightUnit)],weightModel.weightPoint,weightModel.adc]];
        }
            break;
        case BodyFatScaleMeasureStatus_Failed:
        {
            [self addLog:@"Test failure"];
        }
            break;
        case BodyFatScaleMeasureStatus_Complete:
        {
            [self addLog:[NSString stringWithFormat:@"Tested weight = %ld unit = %@ point = %ld adc = %ld",weightModel.weight,AiLinkBleWeightUnitDic[@(weightModel.weightUnit)],weightModel.weightPoint,weightModel.adc]];

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


/**
 Return temperature (unit: ° C)(返回温度（单位：°C）)

 @param temp 温度（单位：°C）
 */
-(void)bodyFatScaleManagerCallBackTemp:(NSString *)temp{
    [self addLog:[NSString stringWithFormat:@"temperature is %@",temp]];
}

/**
 Back to impedance measurement(返回阻抗测量)

 @param status 阻抗测量状态
 @param adc 阻抗
 */
-(void)bodyFatScaleManagerCallBackAdcMeasureStatus:(BodyFatScaleAdcMeasureStatus)status adcValue:(NSInteger)adc{
    switch (status) {
        case BodyFatScaleAdcMeasureStatus_Testing:
        {
            [self addLog:@"adc testing"];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_Success:
        {
            [self addLog:[NSString stringWithFormat:@"adc is %ld",adc]];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_Fail:
        {
            [self addLog:@"adc test failure"];
        }
            break;
        case BodyFatScaleAdcMeasureStatus_SuccessCustom:
        {
            [self addLog:[NSString stringWithFormat:@"adc is %ld and user app algum",adc]];
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
-(void)bodyFatScaleManagerCallBackHeartRateMeasureStatus:(BodyFatScaleHeartRateMeasureStatus)status heartRateValue:(NSInteger)heartRate{
    switch (status) {
        case BodyFatScaleHeartRateMeasureStatus_Testing:
        {
            [self addLog:@"Heart Rate Testing"];
        }
            break;
        case BodyFatScaleHeartRateMeasureStatus_Success:
        {
            [self addLog:[NSString stringWithFormat:@"Heart Rate is %ld",heartRate]];
        }
            break;
        case BodyFatScaleHeartRateMeasureStatus_Fail:
        {
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
-(void)bodyFatScaleManagerCallBackErrorCode:(NSInteger)code{
    [self addLog:[NSString stringWithFormat:@"error code = %ld",code]];
}


////MARK:回调A6指令数据
//
///**
// Send success or failure callback for offline user list(发送离线用户列表的成功或失败回调)
//
// @param status 状态
// */
//-(void)bodyFatScaleManagerCallBackUpdateRecordStatus:(BodyFatScaleUpdateRecordStatus)status{
//    switch (status) {
//        case BodyFatScaleUpdateRecordStatus_AllSuccess:
//        {
//            [self addLog:@"Update All Users Success"];
//        }
//            break;
//        case BodyFatScaleUpdateRecordStatus_OneSuccess:
//        {
//            [self addLog:@"Update A User Success"];
//        }
//            break;
//        case BodyFatScaleUpdateRecordStatus_OneFail:
//        {
//            [self addLog:@"Update A User Failure"];
//        }
//            break;
//        case BodyFatScaleUpdateRecordStatus_AllFail:
//        {
//            [self addLog:@"Update All Users Failure"];
//        }
//            break;
//        default:
//            break;
//    }
//}
//
///**
// Request callback for offline history(请求离线历史记录的回调)
//
// @param status 状态
// */
//-(void)bodyFatScaleManagerCallBackSendHistoryDataStatus:(BodyFatScaleSendHistoryDataStatus)status{
//    if (status == BodyFatScaleSendHistoryDataStatus_No) {
//        [self addLog:@"No offline datas"];
//    }else if (status == BodyFatScaleSendHistoryDataStatus_Begin){
//        [self addLog:@"Begin receive offline datas"];
//    }else if (status == BodyFatScaleSendHistoryDataStatus_End){
//        [self addLog:@"End receive offline datas"];
//    }
//
//}
//
///**
// APP algorithm-offline history data(APP 算法-离线历史记录数据)
//
// @param user 用户信息
// */
//-(void)bodyFatScaleManagerCallBackBleUserHistoryDataCustomADCModel:(ELBodyFatScaleBleUserModel *)user bodyDataModel:(ELBodyFatScaleBleWeightModel *)bodyModel{
//    //这里的身体指标等数据由app自定义算法计算得到，请区分bodyModel.algNum来调用算法
//    [self addLog:[NSString stringWithFormat:@"App algorithm-offline history data:userId = %ld weight = %ld unit =%@ point = %ld",user.usrID,bodyModel.weight,AiLinkBleWeightUnitDic[@(bodyModel.weightUnit)],bodyModel.weightPoint]];
//}
//
///**
// MCU algorithm-offline history data(MCU 算法-离线历史记录数据)
//
// @param user 用户信息
// @param bodyModel 体脂数据
// */
//-(void)bodyFatScaleManagerCallBackBleUserHistoryDataModel:(ELBodyFatScaleBleUserModel *)user bodyDataModel:(ELBodyFatScaleBleWeightModel *)bodyModel{
//    //这里的身体指标数据由秤计算得到
//    [self addLog:[NSString stringWithFormat:@"MCU algorithm-offline history data:userId = %ld weight = %ld unit =%@ point = %ld",user.usrID,bodyModel.weight,AiLinkBleWeightUnitDic[@(bodyModel.weightUnit)],bodyModel.weightPoint]];
//}


-(NSArray<ELBodyFatScaleBleUserModel *> *)get8Users{
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (int i=0; i<8; i++) {
        ELBodyFatScaleBleUserModel *user = [[ELBodyFatScaleBleUserModel alloc] init];
        user.createTime = [[NSDate date] timeIntervalSince1970];
        user.usrID = i;
        user.role = i%4;
        user.sex = i%2;
        user.age = 26+i;
        user.height = 170+i;
        user.weight = 600+i;
        user.adc = 560+i;
        [users addObject:user];
    }

    return users.copy;
}

-(ELBodyFatScaleBleUserModel *)getOneUser{
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

@end
