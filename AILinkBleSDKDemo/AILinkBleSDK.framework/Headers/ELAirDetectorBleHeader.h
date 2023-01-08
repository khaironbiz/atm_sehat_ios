//
//  ELAirDetectorBleHeader.h
//  Pods
//
//  Created by LarryZhang on 2022/12/13.
//

#ifndef ELAirDetectorBleHeader_h
#define ELAirDetectorBleHeader_h


typedef NS_ENUM(NSUInteger, ELAirDetectorBleCMD) {
    ELAirDetectorBleCMD01 = 0x01, //CMD：获取设备支持的功能列表
    ELAirDetectorBleCMD02 = 0x02, //CMD：设备返回功能
    ELAirDetectorBleCMD03 = 0x03, //CMD：获取设备状态
    ELAirDetectorBleCMD04 = 0x04, //CMD：设备返回状态
    ELAirDetectorBleCMD05 = 0x05, //CMD：设置/获取参数功能
    ELAirDetectorBleCMD06 = 0x06, //CMD：MCU返回参数功能
    
    ELAirDetectorBleCMD07 = 0x07, //CMD：定时心跳包
    ELAirDetectorBleCMD08 = 0x08, //CMD：模块返回心跳包
    
    ELAirDetectorBleCMDF1 = 0xF1, //CMD：上发保存数据
};

typedef NS_ENUM(NSUInteger, ELAirDetectorTLVType) {
    ELAirDetectorTLVTypeHCHO  = 0x01, //甲醛
    ELAirDetectorTLVTypeTemperature  = 0x02, //温度
    ELAirDetectorTLVTypeHumidity  = 0x03, //湿度
    ELAirDetectorTLVTypePM2_5  = 0x04, //PM2.5
    ELAirDetectorTLVTypePM1  = 0x05, //PM1
    ELAirDetectorTLVTypePM10  = 0x06, //PM10
    ELAirDetectorTLVTypeVOC  = 0x07,
    ELAirDetectorTLVTypeCO2  = 0x08,
    ELAirDetectorTLVTypeAQI  = 0x09,
    
    ELAirDetectorTLVTypeSettingAlert  = 0x0A, //报警功能
    ELAirDetectorTLVTypeSettingVolume  = 0x0B, //音量
    ELAirDetectorTLVTypeSettingAlertDuration  = 0x0C, //报警时长
    ELAirDetectorTLVTypeSettingAlertRing  = 0x0D, //报警铃声
    ELAirDetectorTLVTypeSettingDeviceError  = 0x0E, //设备故障
    ELAirDetectorTLVTypeSettingDeviceSelfTest  = 0x0F, //设备自检
    ELAirDetectorTLVTypeTVOC  = 0x10, //TVOC
    ELAirDetectorTLVTypeSwitchTemperatureUnit  = 0x11, //单位切换
    ELAirDetectorTLVTypeBatteryState  = 0x12, //电池状态
    ELAirDetectorTLVTypeBindDevice  = 0x13, //设备绑定
    ELAirDetectorTLVTypeHeartbeat  = 0x14, //心跳包(用以模块和APP通信)

    ELAirDetectorTLVTypeCO  = 0x15, //CO(一氧化碳)
    ELAirDetectorTLVTypeAlarm  = 0x16, //闹钟功能
    ELAirDetectorTLVTypeRestoreFactorySetting  = 0x17, //恢复出厂设置
    ELAirDetectorTLVTypeCalibrationParameter  = 0x18, //参数校准
    ELAirDetectorTLVTypeTimeFormat  = 0x19, //时间格式
    ELAirDetectorTLVTypeDeviceBrightness  = 0x1A, //设备亮度
    ELAirDetectorTLVTypeKeySound  = 0x1B, //按键音效
    ELAirDetectorTLVTypeAlertSound  = 0x1C, //报警音效
    ELAirDetectorTLVTypeIconDisplay  = 0x1D, //图标显示
    ELAirDetectorTLVTypeMonitoringDisplayData  = 0x1E, //监控显示数据
    ELAirDetectorTLVTypeDataDisplayMode  = 0x1F, //数据显示模式
    
};

#endif /* ELAirDetectorBleHeader_h */
