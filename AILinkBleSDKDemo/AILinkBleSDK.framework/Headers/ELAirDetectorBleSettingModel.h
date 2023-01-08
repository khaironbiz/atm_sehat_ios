//
//  ELAirDetectorBleSettingModel.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELAirDetectorBleSettingModel : NSObject

//0x01:甲醛
@property (nonatomic, assign) BOOL HCHOAlertOn;
@property (nonatomic, assign) NSInteger HCHOAlertValue;

//0x02:温度
@property (nonatomic, assign) NSInteger temperatureScale;
@property (nonatomic, assign) NSInteger temperatureUint;
@property (nonatomic, assign) NSInteger temperatureAlertMinValue;
@property (nonatomic, assign) NSInteger temperatureAlertMaxValue;

//0x03:湿度
@property (nonatomic, assign) NSInteger humidityAlertMinValue;
@property (nonatomic, assign) NSInteger humidityAlertMaxValue;

//0x04:PM2.5
@property (nonatomic, assign) BOOL PM2_5AlertOn;
@property (nonatomic, assign) NSInteger PM2_5AlertValue;

//0x05:PM1.0
@property (nonatomic, assign) BOOL PM1AlertOn;
@property (nonatomic, assign) NSInteger PM1AlertValue;

//0x06:PM10
@property (nonatomic, assign) BOOL PM10AlertOn;
@property (nonatomic, assign) NSInteger PM10AlertValue;

//0x07:VOC
@property (nonatomic, assign) BOOL VOCAlertOn;
@property (nonatomic, assign) NSInteger VOCAlertValue;

//0x08:CO2
@property (nonatomic, assign) BOOL CO2AlertOn;
@property (nonatomic, assign) NSInteger CO2AlertValue;

//0x09:AQI
@property (nonatomic, assign) BOOL AQIAlertOn;
@property (nonatomic, assign) NSInteger AQIAlertValue;

//0x0B:音量状态
@property (nonatomic, assign) BOOL volumeAlertOn;
@property (nonatomic, assign) NSInteger volumeValue;

//0x0C:报警时长
@property (nonatomic, assign) NSInteger alertDurationValue;

//0x0D:报警铃声
@property (nonatomic, assign) NSInteger alertRingValue;

//0x0F:设备自检
@property (nonatomic, assign) BOOL deviceSelfTesting;

//0x10:TVOC
@property (nonatomic, assign) BOOL TVOCAlertOn;
@property (nonatomic, assign) NSInteger TVOCAlertValue;

//0x11:单位切换
@property (nonatomic, assign) NSInteger switchTemperatureUint;

//0x13:设备绑定
@property (nonatomic, assign) NSInteger bandState;

//0x15:CO
@property (nonatomic, assign) BOOL COAlertOn;
@property (nonatomic, assign) NSInteger COAlertValue;

//0x16:闹钟设置 //原始数据未解析
@property (nonatomic, strong) NSData *alarmSettingData;

//0x17:恢复出厂设置
@property (nonatomic, assign) NSInteger restoreFactoryState;

//0x18:参数校准设置  //原始数据未解析
@property (nonatomic, strong) NSData *calibrationSettingData;

//0x19:时间格式设置
@property (nonatomic, assign) NSInteger timeFormatValue;

//0x1A:设备亮度状态
@property (nonatomic, assign) BOOL deviceBrightnessOn;
@property (nonatomic, assign) NSInteger deviceBrightnessValue;

//按键音效设置
@property (nonatomic, assign) BOOL keySoundOn;

//0x1C:报警音效设置
@property (nonatomic, assign) BOOL alertSoundOn;

//0x1D:图标显示设置
@property (nonatomic, assign) BOOL iconDisplayOn;

//0x1E:监控显示数据
@property (nonatomic, assign) BOOL monitoringDisplayDataOn;

//0x1F:数据显示模式设置
@property (nonatomic, assign) NSInteger dataDisplayModeValue;


@end

NS_ASSUME_NONNULL_END
