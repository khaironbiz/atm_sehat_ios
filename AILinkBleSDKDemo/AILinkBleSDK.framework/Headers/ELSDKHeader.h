//
//  ELSDKHeader.h
//  AILinkSDKDemo
//
//  Created by iot_user on 2019/5/10.
//  Copyright © 2019 IOT. All rights reserved.
//

#ifndef ELSDKHeader_h
#define ELSDKHeader_h


//Bluetooth command type(蓝牙指令类型)
typedef NS_ENUM(NSUInteger, ELInetBleDataType) {
    ELInetBleDataPackHead_A6        = 0xA6,
    ELInetBleDataPackTail_6A        = 0x6A,
    ELInetBleDataPackHead_A7        = 0xA7,
    ELInetBleDataPackTail_7A        = 0x7A,
};

//The type of instruction acquired by Inet(Inet获取的指令类型)
typedef NS_ENUM(NSUInteger, ELInetGetCmdType) {
    ELInetGetCmdTypeGetName                  = 0x02, //-Get the Bluetooth name(获取蓝牙名称)
    ELInetGetCmdTypeGetBroadcastInterval     = 0x06, //-Get broadcast interval (unit: ms)(获取广播间隔时间（单位：ms）)
    ELInetGetCmdTypeGetConnectedInterval     = 0x08, //-Get Bluetooth connection interval(获取蓝牙连接间隔)
    ELInetGetCmdTypeGetTransmittingPower     = 0x0A, //-Get Bluetooth transmit power(获取蓝牙发射功率)
    ELInetGetCmdTypeGetSerialPortbaudRate    = 0x0C, //-Get the serial port baud rate(获取串口波特率)
    ELInetGetCmdTypeGetMACAddress            = 0x0D, //-Read MAC address value(读取MAC地址值)
    ELInetGetCmdTypeGetBMVersion             = 0x0E, //-Read the BM module software and hardware version number(读取BM模块软硬件版本号)
    ELInetGetCmdTypeGetMCUVersion            = 0x10, //-Obtain the MCU software and hardware version number(获取MCU软硬件版本号)
    ELInetGetCmdTypeGetMACAddressType        = 0x12, //-Get the big endian or little endian of the Mac address in the broadcast manufacturer's custom data(获取广播厂家自定义数据中Mac地址的大端序或小端序)
    ELInetGetCmdTypeGetUUID                  = 0x14, //-Get service and feature UUID(获取服务和特征UUID)
    ELInetGetCmdTypeGetMCUMode               = 0x16, //-Get master-slave mode(获取主从模式)
    ELInetGetCmdTypeGetAutoSleepTime         = 0x18, //-Get automatic sleep time value(获取自动睡眠时间值)
    ELInetGetCmdTypeGetMCUDate               = 0x1C, //-Get the current time of the system(获取系统当前时间)
    ELInetGetCmdTypeGetC_V_P_ID              = 0x1E, //-Read CID, VID, PID(读取CID、VID、PID)
    ELInetGetCmdTypeGetCommunicationMode     = 0x20, //-Get module communication mode(获取模块通信模式)
    ELInetGetCmdTypeGetConnectState          = 0x26, //-Get Bluetooth and WiFi connection status(获取蓝牙和WiFi连接状态)
    ELInetGetCmdTypeGetBatteryState          = 0x28, //-Get MCU battery status(获取MCU电池状态)
    ELInetGetCmdTypeGetHandshake             = 0x24, //-Encrypted handshake data returned by Bluetooth(蓝牙返回的加密的握手数据)
    ELInetGetCmdTypeGetBodyFatScaleA6Data    = 0x2B, //-Body fat scale 0x2B stands for A6 protocol (see the second level instructions for details)(体脂秤0x2B代表A6协议(具体见二级指令))
    ELInetGetCmdTypeReadDeviceSupportUnit    = 0x2C, //-APP reads the MCU end unit instruction(APP读取MCU端单位指令)
    ELInetGetCmdTypeGetSendKeyState          = 0x31, //-APP reads the result of sending the decoding key(APP读取下发解码秘钥的结果)
    ELInetGetCmdTypeGetSmartLockA6Data       = 0x34, //-Door lock 0x34 represents the A6 protocol (see the second level command for details)(门锁0x34代表A6协议（具体见二级指令）)
    ELInetGetCmdTypeGetBasicInfoData         = 0x36, //Obtain basic device information data(获取设备基本信息数据)
    ELInetGetCmdTypeSyncMCUNowDate           = 0x38, //MCU request sync the current time of the system(MCU请求设置手机时间给MCU)
    ELInetGetCmdTypeGetBMVersionPro          = 0x46, //增强版-Read the BM module software and hardware version number(读取BM模块软硬件版本号)
#pragma mark  ============ Begin 蓝牙Wifi ==============
    ELInetGetCmdTypeBleWifiGetNearbyWifi     = 0x80, //Get nearby Wifi(获取附近Wifi)
    ELInetGetCmdTypeBleWifiReceiveWifiName   = 0x81, //Reply to wifi name(回复wifi名字)
    ELInetGetCmdTypeBleWifiReceiveWifiMac    = 0x82, //Reply to wifi mac(回复wifi mac)
    ELInetGetCmdTypeBleWifiReceiveScanResult = 0x83, //Reply to scan Wifi result(回复扫描Wifi结果)
    ELInetGetCmdTypeBleWifiGetWifiMac        = 0x85, //Get Wifi Mac address(获取Wifi的Mac地址)
    ELInetGetCmdTypeBleWifiGetWifiPwd        = 0x87, //Get Wifi password(获取Wifi密码)
    ELInetGetCmdTypeBleWifiGetDTIMInterval   = 0x8A, //Get DTIM interval(获取DTIM间隔)
    ELInetGetCmdTypeBleWifiSetIpAddress      = 0x8B, //Set the access ip address（设置访问的ip地址
    ELInetGetCmdTypeBleWifiGetURL            = 0x8C, //Get visited sites(获取访问的网站)
    ELInetGetCmdTypeBleWifiSetPort           = 0x8D,  //set acces port number
    ELInetGetCmdTypeBleWifiGetPort           = 0x8E, //Get access port number(获取访问的端口号)
    ELInetGetCmdTypeBleWifiGetSNNumber       = 0x93, //Get SN number (session code:deviceId)(获取SN号(会话码:设备ID))
    ELInetGetCmdTypeBleWifiName              = 0x94, //获取wifi名称
    ELInetGetCmdTypeBleWifiSetPathAddress    = 0x96, //Set access path（设置访问的路径
    ELInetGetCmdTypeBleWifiGetPathAddress    = 0x97, //get access path
#pragma mark  ============End 蓝牙Wifi ==============
    ELInetGetCmdTypeRequestAuthorize         = 0x7F, //Request device authorization (请求设备授权)
    ELInetGetCmdTypeToothbrushA6Data         = 0xC0, //A6 data for toothbrush(牙刷专用A6数据,详情请见协议的2级指令)(See the second order for details)
    
    ELInetGetDevOfflineHistory               = 0xF1,    //获取离线历史记录
};
//Instruction type set by Inet(Inet设置的指令类型)
typedef NS_ENUM(NSUInteger, ELInetSetCmdType) {
    ELInetSetCmdTypeSetName                  = 0x01, //Set the broadcast name(设置广播名称)
    ELInetSetCmdTypeSetBroadcastInterval     = 0x05, //Set the broadcast interval(设置广播间隔时间)
    ELInetSetCmdTypeSetConnectedInterval     = 0x07, //Set the connection interval(设置连接间隔)
    ELInetSetCmdTypeSetTransmittingPower     = 0x09, //Set the transmit power(设置发射功率)
    ELInetSetCmdTypeSetSerialPortbaudRate    = 0x0B, //Set the serial port baud rate(设置串口波特率)
    ELInetSetCmdTypeSetMCUVersion            = 0x0F, //Set the MCU software and hardware version number(设置MCU软硬件版本号)
    ELInetSetCmdTypeSetMACAddressType        = 0x11, //Set the big endian or little endian of the Mac address in the broadcast manufacturer's custom data.(设置广播厂家自定义数据中Mac地址的大端序或小端序)
    ELInetSetCmdTypeSetUUID                  = 0x13, //Set the module's service and feature UUID(设置模块的服务和特征UUID)
    ELInetSetCmdTypeSetMCUMode               = 0x15, //Set the master-slave mode of the module(设置模块的主从模式)
    ELInetSetCmdTypeSetAutoSleepTime         = 0x17, //Set the module's automatic sleep time without connection(设置模块无连接的自动休眠时间)
    ELInetSetCmdTypeSetGotoSleep             = 0x19, //Set to sleep(设置进入睡眠)
    ELInetSetCmdTypeSetMCUWakeUp             = 0x1A, //Set module wake up(设置模块唤醒)
    ELInetSetCmdTypeSyncBleNowDate            = 0x1B, //Set the current time of the system(设置手机时间给蓝牙模块Type：1B、1C)
    ELInetSetCmdTypeSetC_V_P_ID              = 0x1D, //Set CID, VID, PID(设置CID、VID、PID)
    ELInetSetCmdTypeSetCommunicationMode     = 0x1F, //Set module serial port mode, I2C mode, SPI mode(设置模块串口模式、I2C模式、SPI模式)
    ELInetSetCmdTypeSetMCURestart            = 0x21, //Set module restart(设置模块重启)
    ELInetSetCmdTypeSetFactoryDataReset      = 0x22, //Set factory reset(设置恢复出厂设置)
    ELInetSetCmdTypeSetHandshake             = 0x23, //Encrypted handshake data returned by Bluetooth(蓝牙返回的加密的握手数据)
    ELInetSetCmdTypeSetConnectState          = 0x25, //Set the Bluetooth connection status(设置蓝牙连接状态)
    ELInetSetCmdTypeSetMCUPowerState         = 0x27, //上报电池状态
    ELInetSetCmdTypeSetKey                   = 0x31, //APP sends the decoding key(APP下发解码秘钥)
    ELInetSetCmdTypeSetSmartLockA6Data       = 0x34, //Door lock 0x34 represents the A6 protocol (see the second level command for details)(门锁0x34代表A6协议（具体见二级指令）)
    ELInetSetCmdTypeSetBasicInfoData         = 0x35, //Obtain basic device information data(获取设备基本信息数据)
    ELInetSetCmdTypeSyncMCUNowDate           = 0x37, //Sync the current time of the system(设置手机时间给MCU)
#pragma mark  ============ 蓝牙Wifi ==============
    ELInetSetCmdTypeBleWifiSetWifiMac        = 0x84, //设置WIFI Mac地址
    ELInetSetCmdTypeBleWifiSetWifiPwd        = 0x86, //设置WIFI 密码
    ELInetSetCmdTypeBleWifiSetConnectWifi    = 0x88, //设置设备连接WIFI
    ELInetSetCmdTypeBleWifiSetDTIMInterval   = 0x89, //设置DTIM间隔
    ELInetSetCmdTypeBleWifiSetWifiURL        = 0x8B, //设置访问的URL
    ELInetSetCmdTypeBleWifiSetWifiPort       = 0x8D, //设置端口号
};

//Response to Bluetooth after device(给蓝牙进行设置后的响应)
typedef NS_ENUM(NSUInteger, ELSetBluetoothResponseType) {
    ELSetBluetoothResponseTypeSuccess    =0  ,     //success(成功)
    ELSetBluetoothResponseTypeFailure    =1  ,     //failure(失败)
    ELSetBluetoothResponseTypeNoSupport  =2  ,     //not support(不支持)
};

//Device types supported by Elink: Please communicate with the hardware to set(Elink支持的设备类型：请与硬件沟通后设置)
typedef NS_ENUM(NSUInteger, ELSupportDeviceType) {
    ELSupportDeviceTypeUnkonwn        = 0x0000 ,     //unknown(未知)
    ELSupportDeviceTypeBlood          = 0x0001 ,     //sphygmomanometer(血压计)
    ELSupportDeviceTypeForehead       = 0x0002 ,     //Temperature gun(额温枪)
    ELSupportDeviceTypeThermometer    = 0x0003 ,     //thermometer(体温计)
    ELSupportDeviceTypeBabyScale      = 0x0004 ,     //Baby scale(婴儿秤)
    ELSupportDeviceTypeHeightGauge    = 0x0005 ,     //Height meter(身高仪)
    ELSupportDeviceTypeSmartLock      = 0x000B ,     //Smart door lock(智能门锁)
    ELSupportDeviceTypeRemoteControl  = 0x000C ,     //Internal projection vision tester(内投影视力检查仪)
    ELSupportDeviceTypeWheelMonitor   = 0x000D ,     //TPMS(胎压转接板)
    ELSupportDeviceTypeBodyFatScale   = 0x000E ,     //Body fat scale(体脂秤)
    ELSupportDeviceTypeSmatLockRemote = 0x0010 ,     //Smart door lock remote control(智能门锁遥控器)
    ELSupportDeviceTypeBLE_WIFIScale  = 0x0011 ,     //Ble and wifi Scale(蓝牙Wifi体脂秤)
    ELSupportDeviceTypeBLE_WIFIToothbrush = 0x0012,  //Bluetooth and wifi toothbrush(蓝牙wifi牙刷)
    ELSupportDeviceTypeBLE_EightScale = 0x0013 ,     //Eight electrode scale（八电极蓝牙秤）
    ELSupportDeviceTypeAnemometer     = 0x0014 ,     //anemometer（风速计）,0x0015
    ELSupportDeviceTypeClampMeter     = 0x0015 ,     //clamp meter(钳表)
    ELSupportDeviceTypeWatch          = 0x001D ,     //华盛达手表
    
    ELSupportDeviceTypeBloodSugar     = 0x001C ,     //blood sugar(血糖仪)
    ELSupportDeviceTypeInfThermt      = 0x0020 ,     //Infrared Thermometer(红外测温仪)
    ELSupportDeviceTypeOximeter       = 0x0021 ,     //Oximeter （血氧仪）
    ELSupportDeviceTypeFaceMask       = 0x0022 ,     //face mask(智能口罩)
    
    ELSupportDeviceTypeCoffeeScale    = 0x0024 ,     //咖啡秤
    
    ELSupportDeviceTypeHeightBodyFatScale = 0x0026 ,    //身高体脂秤
    ELSupportDeviceTypeFoodThermometer = 0x002B,  //Food Thermometer(食品温度计)
    
    
    ELSupportDeviceTypeBLEToothbrush = 0x002D,  //Bluetooth toothbrush(蓝牙牙刷)
    ELSupportDeviceTypeHygrothermograph = 0x002E ,      //温湿度计
    
    ELSupportDeviceTypeSkip             = 0x002F ,      //跳绳
    ELSupportDeviceTypeBLE_BfrEightScale = 0x0032, //MCU会计算体脂信息的八电极蓝牙秤
    ELSupportDeviceTypeElectricScooter= 0x0033 ,     //滑板车
    ELSupportDeviceTypeNutritionScale = 0x0034 , //营养秤(蓝牙连接)
    ELSupportDeviceType_WiFi_Hygrothermograph = 0x0036 , //wifi温湿度计
    ELSupportDeviceTypeAiFreshNutritionScale = 0x0037 , //好营养营养秤(蓝牙连接)
    ELSupportDeviceTypeBLE_WIFIBlood = 0x0038 , //Bluetooth and wifi Blood(蓝牙wifi智能血压计)
    ELSupportDeviceTypeFasciaGun        = 0x003B , //筋膜枪
    
    ELSupportDeviceType_4G_Hygrothermograph = 0x003A ,  //4g温湿度计
    
    ELSupportDeviceTypeAutomaticThermometer        = 0x003D , //61 //测温仪(蓝牙)
    
    ELSupportDeviceType_BraceletWatch  = 0x003E, //Leap手环
    
    ELSupportDeviceTypeMeatProbe  = 0x003F, //食物探针
    
    ELSupportDeviceTypeVictorClampMeter  = 0x0040, //Victor钳表
    
    ELSupportDeviceTypeVictorNoiseMeter  = 0x0043, //胜利噪音计
    
    ELSupportDeviceTypeVictorAnemometer  = 0x0044, //胜利风速计
    
    ELSupportDeviceTypeVictorLuxMeter  = 0x0045, //胜利照度计
    
    ELSupportDeviceTypeAirDetector  = 0x0048, //环境气体检测仪
    
    ELSupportDeviceTypeTPMS  = 0x0049, //智能胎压
    
    ELSupportDeviceType电动自行车  = 0x004A, //电动自行车
    
    ELSupportDeviceType电动车  = 0x004C, //电动车
    
    ELSupportDeviceType电动平衡车  = 0x004E, //电动平衡车
    
    ELSupportDeviceTypeBLEWiFiNoiseMeter  = 0x0050, //噪音计(WiFi+BLE)
    
    ELSupportDeviceType智能仪表  = 0x0051, //CM01-C02智能仪表
    
    ELSupportDeviceType双频八电极体脂秤  = 0x0052, //双频八电极体脂秤
    
//    ELSupportDeviceType53  = 0x0053,
//    ELSupportDeviceType54  = 0x0054,
//    ELSupportDeviceType55  = 0x0055,
//    ELSupportDeviceType56  = 0x0056,
//    ELSupportDeviceType57  = 0x0057,
//    ELSupportDeviceType58  = 0x0058,
//    ELSupportDeviceType59  = 0x0059,
    
    ELSupportDeviceTypeBroadcastScale = (0xffff +0x01)  ,     //655536 Broadcast body fat scale(AILink广播体脂秤)
    ELSupportDeviceTypeBroadcastHeightGauge = (0xffff + 0x03) , //65538 广播身高仪
    ELSupportDeviceTypeBroadcastScale_Lingyang = (0xffff +0x16)  ,     //65557 凌阳广播体脂秤
    
    ELSupportDeviceTypeBroadcastNutritionFoodScale = (0xffff + 0x04) , //65539 广播营养秤
    ELSupportDeviceTypeBroadcastHygrothermograph = (0xffff + 0x06) , //65541 广播温湿度计
    
};
//Communication mode(通信模式)
typedef NS_ENUM(NSInteger, ELCommunicationModeType) {
    ELCommunicationModeTypeSerialPort = 0,   //Serial port mode(串口模式)
    ELCommunicationModeTypeI2C        = 1,   //I2C mode(I2C模式)
    ELCommunicationModeTypeSPI        = 2,   //SPI mode( SPI模式)
};
//Battery charge status (电池充电状态)
typedef NS_ENUM(NSUInteger, ELBatteryChargingState) {
    ELBatteryChargingStateDefault     = 0x00, //No charging (default)(没有充电（默认）)
    ELBatteryChargingStateWorking     = 0x01, //charging(充电中)
    ELBatteryChargingStateComplete    = 0x02, //full charge(充满电)
    ELBatteryChargingStateException   = 0x03, //Abnormal charging（充电异常）
    ELBatteryChargingStatePowerLow    = 0x04, //Low battery（电量过低）
    
};


//CID,VID,PID
struct ELDIDStruct {
    ELSupportDeviceType deviceType; //CID
    int vendorID;                 //VID
    int productID;                //PID
};
//Battery charging state and power structur（电池充电状态和电量的结构体）
struct ELBatteryStruct {
    ELBatteryChargingState state;   //charging（充电状态）
    int power;                          //Electricity（电量）（0—100%）
};
//Connection interval structure（连接间隔时间的结构体）
struct ELConnectIntervalStruct {
    int interval;         //Connection interval, unit: ms; range: 20-2000(连接间隔,单位:ms;范围:20-2000)
    int latency;          //Slave delay, value: 0-4(从设备延时,取值:0-4)
    int timeout;          //Connection timeout, unit: ms; Range: 1000~6000(连接超时,单位:ms; 范围: 1000~6000)
};

struct ELUUIDStruct {
    char *serviceUUID;    //Service UUID（服务UUID）
    char *writeUUID;      //For APP to send data to MCU (write)（用于 APP 下发数据到 MCU(write)）
    char *notifyUUID;     //Used for MCU data transfer to APP (notify)（用于 MCU 数据传输到 APP (notify)）
};

struct ELAutoSleepTimeStruct {
    int sleepTime;   //Automatic sleep time, unit: s（自动睡眠时间,单位:s）
    int open;       //Whether to enable low frequency broadcast after sleep: 0: not open, 1: open（睡眠后是否开启低频广播: 0:不开启 ,1:开启）
    int interval;    //Low frequency broadcast interval, unit: ms; range 20~2000(低频广播间隔,单位 :ms ;范围 20~2000)
};
//WiFi连接状态
typedef NS_ENUM(NSUInteger, BleWiFiConnectState) {
    /// 0:没配网，没有连接，0: No connection
    BleWiFiConnectStateNoWiFi      = 0,
    /// 1:尝试连接热点，但是失败1: Attempt to connect to the hotspot, but failed
    BleWiFiConnectStateConnectFail = 1   ,
    /// 2:连接热点，热点无网络,2: Connected to the hotspot, the hotspot has no network
    BleWiFiConnectStateNoNetwork   = 2   ,
    /// 3:连接热点，热点有网络,3: Connected to the hotspot, the hotspot has a network
    BleWiFiConnectStateSuccess     = 3   ,
    /// 4:有热点信息，未连接,4: There is hotspot information, not connected
    BleWiFiConnectStateNoConnect   = 4   ,
    
    /// 5:ap信号差，连接失败
    BleWiFiConnectStatePoorApSignal = 5 ,
    /// 6:密码错误
    BleWiFiConnectStatePasswordWrong = 6 ,
    /// 7:获取不到IP，连接失败
    BleWiFiConnectStateCantGetIP = 7 ,
};

//连网失败原因，对于温湿度计来说，如果 BleWiFiConnectState 状态为1，则需要判断该值，牙刷的话byte位够长，可以直接判断BleWiFiConnectState
typedef NS_ENUM(NSUInteger, BleWiFiConnectServerFaildState) {
    BleWiFiConnectServerFaildState_Unknow       = 0 ,
    BleWiFiConnectServerFaildState_ApSignal     = 1 ,
    BleWiFiConnectServerFaildState_PwdWrong     = 2 ,
    BleWiFiConnectServerFaildState_CantGetIP    = 3 ,
};


struct ELMCUStateStruct {
    int connectState;     //Connection status: 0: no connection 1: connected（蓝牙连接状态: 0:无连接 1:已连接 2:配对完成）
    BleWiFiConnectState wifiState;        //
    int workState;        //Working status: 0: Wake 1: Go to sleep 2: Module is ready（工作状态: 0:唤醒 1:进入休眠 2:模块准备就绪）
    BleWiFiConnectServerFaildState faildState;
};

#pragma mark  - AiLink unit

/** Type key of unit string(单位字符串的type key) */
#define ELDeviceUnitTypeKey           @"type"
/** supportUnit key */
#define ELDeviceUnitSupportUnitKey    @"supportUnit"

/** Ailink unit */
typedef NS_ENUM(NSInteger, ELDeviceUnitType) {
    /** Weight(重量) */
    ELDeviceUnitType_Weight             = 1 ,
    /** length(长度) */
    ELDeviceUnitType_Height             = 2 ,
    /** temperature(温度) */
    ELDeviceUnitType_Temperature        = 3 ,
    /** Pressure(血压) */
    ELDeviceUnitType_BloodPressure      = 4 ,
    /** Tire pressure(轮胎胎压压力) */
    ELDeviceUnitType_Pressure           = 5 ,
    /**Blood sugar(血糖单位)*/
    ELDeviceUnitType_BloodSugar         = 6 ,
    /**体积(体积单位)*/
    ELDeviceUnitType_Volume             = 7 ,
    /**营养秤专用单位*/
    ELDeviceUnitType_Nutrition          = 8 ,
};

#define AiLinkBleWeightUnit_KG_Str @"kg"
#define AiLinkBleWeightUnit_Jin_Str @"斤"
#define AiLinkBleWeightUnit_LB_OZ_Str @"lb:oz"
#define AiLinkBleWeightUnit_OZ_Str @"oz"
#define AiLinkBleWeightUnit_ST_LB_Str @"st:lb"
#define AiLinkBleWeightUnit_G_Str @"g"
#define AiLinkBleWeightUnit_LB_Str @"lb"
#define AiLinkBleWeightUnit_ML_Str @"ml"
#define AiLinkBleWeightUnit_FL_OZ_Str @"fl.oz"
#define AiLinkBleWeightUnit_CC_Str @"cc"
#define AiLinkBleWeightUnit_L_Str @"l"
#define AiLinkBleWeightUnit_GAL_Str @"gal"

#define AiLinkBleWeightUnitStrDic(key) [@{AiLinkBleWeightUnit_KG_Str:@(ELDeviceWeightUnit_KG),AiLinkBleWeightUnit_Jin_Str:@(ELDeviceWeightUnit_JIN),AiLinkBleWeightUnit_LB_OZ_Str:@(ELDeviceWeightUnit_LB_OZ),AiLinkBleWeightUnit_OZ_Str:@(ELDeviceWeightUnit_OZ),AiLinkBleWeightUnit_ST_LB_Str:@(ELDeviceWeightUnit_ST_LB),AiLinkBleWeightUnit_G_Str:@(ELDeviceWeightUnit_G),AiLinkBleWeightUnit_LB_Str:@(ELDeviceWeightUnit_LB)}[key] integerValue]

//#define AiLinkBleWeightUnitDic @{@(ELDeviceWeightUnit_KG):AiLinkBleWeightUnit_KG_Str,@(ELDeviceWeightUnit_JIN):AiLinkBleWeightUnit_Jin_Str,@(ELDeviceWeightUnit_LB_OZ):AiLinkBleWeightUnit_LB_OZ_Str,@(ELDeviceWeightUnit_OZ):AiLinkBleWeightUnit_OZ_Str,@(ELDeviceWeightUnit_ST_LB):AiLinkBleWeightUnit_ST_LB_Str,@(ELDeviceWeightUnit_G):AiLinkBleWeightUnit_G_Str,@(ELDeviceWeightUnit_LB):AiLinkBleWeightUnit_LB_Str}
#define AiLinkBleWeightUnitDic @{@(ELDeviceWeightUnit_KG):AiLinkBleWeightUnit_KG_Str,@(ELDeviceWeightUnit_JIN):AiLinkBleWeightUnit_Jin_Str,@(ELDeviceWeightUnit_LB_OZ):AiLinkBleWeightUnit_LB_OZ_Str,@(ELDeviceWeightUnit_OZ):AiLinkBleWeightUnit_OZ_Str,@(ELDeviceWeightUnit_ST_LB):AiLinkBleWeightUnit_ST_LB_Str,@(ELDeviceWeightUnit_G):AiLinkBleWeightUnit_G_Str,@(ELDeviceWeightUnit_LB):AiLinkBleWeightUnit_LB_Str, @(ELDeviceWeightUnit_ML):AiLinkBleWeightUnit_ML_Str, @(ELDeviceWeightUnit_FLOZ):AiLinkBleWeightUnit_FL_OZ_Str, @(ELDeviceWeightUnit_CC):AiLinkBleWeightUnit_CC_Str, @(ELDeviceWeightUnit_L):AiLinkBleWeightUnit_L_Str, @(ELDeviceWeightUnit_GAL):AiLinkBleWeightUnit_GAL_Str}

/** AiLink Weight unit(体重单位)*/
typedef NS_ENUM(NSInteger, ELDeviceWeightUnit) {
    /** kg */
    ELDeviceWeightUnit_KG            = 0x00 ,
    /** 斤 */
    ELDeviceWeightUnit_JIN           = 0x01 ,
    /** lb:oz */
    ELDeviceWeightUnit_LB_OZ         = 0x02 ,
    /** oz */
    ELDeviceWeightUnit_OZ            = 0x03 ,
    /** st:lb */
    ELDeviceWeightUnit_ST_LB         = 0x04 ,
    /** g */
    ELDeviceWeightUnit_G             = 0x05 ,
    /** lb */
    ELDeviceWeightUnit_LB            = 0x06 ,
    //体积 咖啡秤有ml单位 所以协议增加体积部分
    /** ml */
    ELDeviceWeightUnit_ML            = 0x10 ,
    /** fl.oz */
    ELDeviceWeightUnit_FLOZ          = 0x20 ,
    /** cc */
    ELDeviceWeightUnit_CC            = 0x30 ,
    /** l */
    ELDeviceWeightUnit_L             = 0x40 ,
    /** gal */
    ELDeviceWeightUnit_GAL           = 0x50 ,
    
    /** Unsupported unit */
    ELDeviceWeightUnit_Fail          = 0xFF ,
};

#define AiLinkBleHeightUnit_CMStr   @"cm"
#define AiLinkBleHeightUnit_InchStr @"inch"//@"in"//
#define AiLinkBleHeightUnit_FeetStr @"feet"//@"ft"//

#define AiLinkBleHeightUnitDic @{@(ELDeviceHeightUnit_CM):AiLinkBleHeightUnit_CMStr,@(ELDeviceHeightUnit_Inch):AiLinkBleHeightUnit_InchStr,@(ELDeviceHeightUnit_FT_IN):AiLinkBleHeightUnit_FeetStr}
/** AiLink Length unit(长度单位) */
typedef NS_ENUM(NSInteger, ELDeviceHeightUnit) {
    /** cm */
    ELDeviceHeightUnit_CM            = 0x00 ,
    /** inch */
    ELDeviceHeightUnit_Inch          = 0x01 ,
    /** feet:inch */
    ELDeviceHeightUnit_FT_IN         = 0x02 ,
    //
    ELDeviceHeightUnit_M             = 0x03 ,
    /** Unsupported unit */
    ELDeviceHeightUnit_Fail          = 0xFF ,
};

#define AiLinkBleSpeedUnit_M_S      @"m/s"
#define AiLinkBleSpeedUnit_KM_H     @"km/h"
#define AiLinkBleSpeedUnit_FT_Min   @"ft/min"
#define AiLinkBleSpeedUnit_Knots    @"knots"
#define AiLinkBleSpeedUnit_MPH      @"MPH"

#define AiLinkBleSpeedUnitDic  @{@(ELDeviceSpeedUnit_M_S):AiLinkBleSpeedUnit_M_S,@(ELDeviceSpeedUnit_KM_H):AiLinkBleSpeedUnit_KM_H,@(ELDeviceSpeedUnit_FT_Min):AiLinkBleSpeedUnit_FT_Min,@(ELDeviceSpeedUnit_Knots):AiLinkBleSpeedUnit_Knots,@(ELDeviceSpeedUnit_MPH):AiLinkBleSpeedUnit_MPH}

/** AiLink速度单位 */
typedef NS_ENUM(NSInteger, ELDeviceSpeedUnit) {
    /** m/s */
    ELDeviceSpeedUnit_M_S       = 0x00 ,
    /** km/h */
    ELDeviceSpeedUnit_KM_H      = 0x01 ,
    /** ft/min */
    ELDeviceSpeedUnit_FT_Min    = 0x02 ,
    /** knots（节，海里/小时，1节=1海里/小时=1.852公里/小时） */
    ELDeviceSpeedUnit_Knots     = 0x03 ,
    /** MPH（1 迈= 1.609344 千米/小时） */
    ELDeviceSpeedUnit_MPH       = 0x04 ,
    /** Unsupported unit */
    ELDeviceSpeedUnit_Fail      = 0xFF ,
};

#define AiLinkBleTempUnit_CStr @"℃"

#define AiLinkBleTempUnit_FStr @"℉"

#define AiLinkBleTempUnitDic @{@(ELDeviceTemperatureUnit_C):AiLinkBleTempUnit_CStr,@(ELDeviceTemperatureUnit_F):AiLinkBleTempUnit_FStr}
/** AiLink Temperature unit(温度单位)*/
typedef NS_ENUM(NSInteger, ELDeviceTemperatureUnit) {
    /** ℃ */
    ELDeviceTemperatureUnit_C        = 0x00 ,
    /** ℉ */
    ELDeviceTemperatureUnit_F        = 0x01 ,
    
    /** Unsupported unit */
    ELDeviceTemperatureUnit_Fail     = 0xFF ,
};

#define AiLinkBloodUnit_mmHgStr @"mmHg"
#define AiLinkBloodUnit_kPaStr  @"kPa"

#define AiLinkBloodUnitDic @{\
        @(ELDeviceBloodPressureUnit_mmhg):AiLinkBloodUnit_mmHgStr,\
        @(ELDeviceBloodPressureUnit_kPa):AiLinkBloodUnit_kPaStr\
       }
/** AiLink Blood pressure unit(血压单位) */
typedef NS_ENUM(NSInteger, ELDeviceBloodPressureUnit) {
    /** mmhg */
    ELDeviceBloodPressureUnit_mmhg   = 0x00 ,
    /** kPa */
    ELDeviceBloodPressureUnit_kPa           ,
    
    /** Unsupported unit */
    ELDeviceBloodPressureUnit_Fail          ,
};

#define AiLinkBlePressureUnit_BarStr  @"Bar"
#define AiLinkBlePressureUnit_PsiStr  @"Psi"
#define AiLinkBlePressureUnit_KpaStr  @"Kpa"

#define AiLinkBlePressureUnitDic @{@(ELDevicePressureUnit_Bar):AiLinkBlePressureUnit_BarStr,@(ELDevicePressureUnit_Psi):AiLinkBlePressureUnit_PsiStr,@(ELDevicePressureUnit_kPa):AiLinkBlePressureUnit_KpaStr}
/** AiLink Tire tire pressure unit（轮胎胎压单位） */
typedef NS_ENUM(NSInteger, ELDevicePressureUnit) {
    /** kPa */
    ELDevicePressureUnit_kPa         = 0x00 ,
    /** Psi */
    ELDevicePressureUnit_Psi         = 0x01 ,
    /** Bar */
    ELDevicePressureUnit_Bar         = 0x02 ,
    
    /** Unsupported unit */
    ELDevicePressureUnit_Fail               ,
};

#define AiLinkBleBloodSugarUnit_mmolStr  @"mmol/L"
#define AiLinkBleBloodSugarUnit_mgStr  @"mg/dL"

#define AiLinkBleBloodSugarUnitDic @{@(ELDeviceBloodSugarUnit_mmol_L):AiLinkBleBloodSugarUnit_mmolStr,@(ELDeviceBloodSugarUnit_mg_dL):AiLinkBleBloodSugarUnit_mgStr,}

typedef NS_ENUM(NSUInteger, ELDeviceBloodSugarUnit) {
    ELDeviceBloodSugarUnit_mmol_L = 0x01,//mmol/L 毫摩尔/升
    ELDeviceBloodSugarUnit_mg_dL  = 0x02,//mg/dL 毫克/分升
    ELDeviceBloodSugarUnit_Fail         ,
};


#define AiLinkBleVolumeUnit_mlStr @"ml"
#define AiLinkBleVolumeUnit_flozStr @"fl.oz"
#define AiLinkBleVolumeUnit_ccStr @"cc"
#define AiLinkBleVolumeUnit_lStr @"l"
#define AiLinkBleVolumeUnit_galStr @"gal"

#define AiLinkBleVolumeUnitDic @{@(ELDeviceVolumeUnit_ML):AiLinkBleVolumeUnit_mlStr, @(ELDeviceVolumeUnit_FLOZ):AiLinkBleVolumeUnit_flozStr, @(ELDeviceVolumeUnit_CC):AiLinkBleVolumeUnit_ccStr, @(ELDeviceVolumeUnit_L):AiLinkBleVolumeUnit_lStr, @(ELDeviceVolumeUnit_GAL):AiLinkBleVolumeUnit_galStr}
/** AiLink Temperature unit(温度单位)*/
typedef NS_ENUM(NSInteger, ELDeviceVolumeUnit) {
    /** ml */
    ELDeviceVolumeUnit_ML           = 0x00 ,
    /** fl.oz */
    ELDeviceVolumeUnit_FLOZ         = 0x01 ,
    /** cc */
    ELDeviceVolumeUnit_CC           = 0x02 ,
    /** l */
    ELDeviceVolumeUnit_L            = 0x03 ,
    /** gal */
    ELDeviceVolumeUnit_GAL          = 0x04 ,
    
    /** Unsupported unit */
    ELDeviceVolumeUnit_Fail         = 0xFF ,
};

/** AiLink Nutrition unit(营养秤专用单位)*/
typedef NS_ENUM(NSInteger, ELDeviceNutritionUnit) {
    /** g */
    ELDeviceNutritionUnit_G             = 0x00 ,
    /** ml */
    ELDeviceNutritionUnit_ML            = 0x01 ,
    /** lb.oz */
    ELDeviceNutritionUnit_LBOZ          = 0x02 ,
    /** oz */
    ELDeviceNutritionUnit_OZ            = 0x03 ,
    /** kg */
    ELDeviceNutritionUnit_KG            = 0x04 ,
    /** jin */
    ELDeviceNutritionUnit_JIN           = 0x05 ,
    /** 牛奶ml */
    ELDeviceNutritionUnit_MILK_ML       = 0x06 ,
    /** 水ml */
    ELDeviceNutritionUnit_WATER_ML      = 0x07 ,
    /** 牛奶floz */
    ELDeviceNutritionUnit_MILK_FLOZ     = 0x08 ,
    /** 水floz */
    ELDeviceNutritionUnit_WATER_FLOZ    = 0x09 ,
    /** lb. */
    ELDeviceNutritionUnit_LB            = 0x0A ,

    
    /** Unsupported unit */
    ELDeviceNutritionUnit_Fail          = 0xFF ,
};


#pragma mark  ============ 枚举 ==============
typedef NS_ENUM(NSUInteger, ELBluetoothState) {
    ELBluetoothStateUnavailable,                  //Bluetooth is not available（蓝牙不可用）0
    ELBluetoothStateAvailable,                    //Bluetooth available（蓝牙可用）1
    ELBluetoothStateStopScan,                     //Stop scanning（停止扫描）2
    ELBluetoothStateScaning,                      //Scanning（正在扫描）3
    ELBluetoothStateWillConnect,                  //Will connect（将要连接）4
    ELBluetoothStateDidConnect,                   //Already connected（已经连接）5
    ELBluetoothStateConnectFail,                  //Connection error（连接出错）6
    ELBluetoothStateDidDiscoverCharacteristics,   //Peripheral feature callback（外设特征回调）7
    ELBluetoothStateDidDisconnect,                //Disconnect（断开连接）8
    ELBluetoothStateDidValidationPass,            //approved（通过验证）9
    ELBluetoothStateFailedValidation,             //Failed verification（未通过验证）10
    
    
    ELBluetoothStateUnauthorized          = 0XFF ,    //No Bluetooth permission （没有蓝牙权限）
};

//sex(性别)
typedef NS_ENUM(NSUInteger, ELBluetoothUserSex) {
    ELBluetoothUserSex_Woman   = 0x00,//female(女)
    ELBluetoothUserSex_Man     = 0x01,//male(男)
};
//设备授权结果
typedef NS_ENUM(NSUInteger, ELBluetoothDeviceAuthorizeResult) {
    ELBluetoothDeviceAuthorizeResultNoAuth   =0,//No(没有)
    ELBluetoothDeviceAuthorizeResultAuthorized   ,//Authorized(已经授权)
    ELBluetoothDeviceAuthorizeResultNoNeed     ,//No authorization required(不需要授权)
    ELBluetoothDeviceAuthorizeResultSuccess    ,//Authorization succeeded(授权成功)
};


#endif /* ELSDKHeader_h */
