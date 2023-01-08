//
//  ELAirDetectorBleStatusModel.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELAirDetectorBleStatusModel : NSObject

//0x01:甲醛
@property (nonatomic, assign) NSInteger HCHOValue;

//0x02:温度
@property (nonatomic, assign) NSInteger temperatureScale;
@property (nonatomic, assign) NSInteger temperatureValue;
@property (nonatomic, assign) NSInteger temperatureUint;

//0x03:湿度
@property (nonatomic, assign) NSInteger humidityValue;

//0x04:PM2.5
@property (nonatomic, assign) NSInteger PM2_5Value;

//0x05:PM1.0
@property (nonatomic, assign) NSInteger PM1Value;

//0x06:PM10
@property (nonatomic, assign) NSInteger PM10Value;

//0x07:VOC
@property (nonatomic, assign) NSInteger VOCValue;

//0x08:CO2
@property (nonatomic, assign) NSInteger CO2Value;

//0x09:AQI
@property (nonatomic, assign) NSInteger AQIValue;

//0x0A:报警状态
@property (nonatomic, assign) BOOL alertOn;
@property (nonatomic, assign) BOOL alertHCHOHigh;
@property (nonatomic, assign) BOOL alertTemperatureLow;
@property (nonatomic, assign) BOOL alertTemperatureHigh;
@property (nonatomic, assign) BOOL alertHumidityLow;
@property (nonatomic, assign) BOOL alertHumidityHigh;
@property (nonatomic, assign) BOOL alertPM2_5;
@property (nonatomic, assign) BOOL alertPM1;
@property (nonatomic, assign) BOOL alertPM10;
@property (nonatomic, assign) BOOL alertVOC;
@property (nonatomic, assign) BOOL alertCO2;
@property (nonatomic, assign) BOOL alertAQI;
@property (nonatomic, assign) BOOL alertTVOC;

//0x0B:音量状态
@property (nonatomic, assign) BOOL volumeOn;
@property (nonatomic, assign) NSInteger volumeValue;

//0x0C:报警时长
@property (nonatomic, assign) NSInteger alertDurationValue;

//0x0D:报警铃声
@property (nonatomic, assign) NSInteger alertRingValue;

//0x0E:设备故障
@property (nonatomic, assign) BOOL deviceError;

//0x0F:设备自检
@property (nonatomic, assign) BOOL deviceSelfTesting;

//0x10:TVOC
@property (nonatomic, assign) NSInteger TVOCValue;

//0x12:电池状态
@property (nonatomic, assign) NSInteger batteryState;
@property (nonatomic, assign) NSInteger batteryPercentValue;

//0x15:CO
@property (nonatomic, assign) NSInteger COValue;

//0x16:闹钟状态  //原始数据未解析
@property (nonatomic, strong) NSData *alarmStatusData;

//0x17:恢复出厂设置
@property (nonatomic, assign) NSInteger restoreFactoryState;

//0x18:参数校准状态  //原始数据未解析
@property (nonatomic, strong) NSData *calibrationStatusData;

//0x19:时间格式状态
@property (nonatomic, assign) NSInteger timeFormatValue;

//0x1A:设备亮度状态
@property (nonatomic, assign) BOOL deviceBrightnessOn;
@property (nonatomic, assign) NSInteger deviceBrightnessValue;

//0x1B:按键音效状态
@property (nonatomic, assign) BOOL keySoundOn;

//0x1C:报警音效状态
@property (nonatomic, assign) BOOL alertSoundOn;

//0x1D:图标显示状态
@property (nonatomic, assign) BOOL iconDisplayOn;

//0x1E:监控显示数据状态
@property (nonatomic, assign) BOOL monitoringDisplayDataOn;

//0x1F:数据显示模式
@property (nonatomic, assign) NSInteger dataDisplayModeValue;

@end

NS_ASSUME_NONNULL_END
