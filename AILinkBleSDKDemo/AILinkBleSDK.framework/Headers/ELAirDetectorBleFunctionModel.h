//
//  ELAirDetectorBleFunctionModel.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELAirDetectorBleFunctionModel : NSObject

//0x01:甲醛
@property (nonatomic, assign) NSInteger HCHOScale;
@property (nonatomic, assign) NSInteger HCHOMin;
@property (nonatomic, assign) NSInteger HCHOMax;

//0x02:温度
@property (nonatomic, assign) NSInteger temperatureScale;
@property (nonatomic, assign) NSInteger temperatureMin;
@property (nonatomic, assign) NSInteger temperatureMax;

//0x03:湿度
@property (nonatomic, assign) NSInteger humidityScale;
@property (nonatomic, assign) NSInteger humidityMin;
@property (nonatomic, assign) NSInteger humidityMax;

//0x04:PM2.5
@property (nonatomic, assign) NSInteger PM2_5Scale;
@property (nonatomic, assign) NSInteger PM2_5Min;
@property (nonatomic, assign) NSInteger PM2_5Max;

//0x05:PM1.0
@property (nonatomic, assign) NSInteger PM1Scale;
@property (nonatomic, assign) NSInteger PM1Min;
@property (nonatomic, assign) NSInteger PM1Max;

//0x06:PM10
@property (nonatomic, assign) NSInteger PM10Scale;
@property (nonatomic, assign) NSInteger PM10Min;
@property (nonatomic, assign) NSInteger PM10Max;

//0x07:VOC
@property (nonatomic, assign) NSInteger VOCScale;
@property (nonatomic, assign) NSInteger VOCMin;
@property (nonatomic, assign) NSInteger VOCMax;

//0x08:CO2
@property (nonatomic, assign) NSInteger CO2Scale;
@property (nonatomic, assign) NSInteger CO2Min;
@property (nonatomic, assign) NSInteger CO2Max;

//0x09:AQI
@property (nonatomic, assign) NSInteger AQIScale;
@property (nonatomic, assign) NSInteger AQIMin;
@property (nonatomic, assign) NSInteger AQIMax;

//0x0A:报警功能
@property (nonatomic, assign) BOOL alertSupport;

//0x0B:音量
@property (nonatomic, assign) NSInteger volumeMax;

//0x0C:报警时长
@property (nonatomic, assign) NSInteger alertDurationMax;

//0x0D:报警铃声
@property (nonatomic, assign) NSInteger alertRingCount;

//0x0E:设备故障
@property (nonatomic, assign) BOOL deviceErrorSupport;

//0x0F:设备自检
@property (nonatomic, assign) BOOL deviceSelfTestSupport;

//0x10:TVOC
@property (nonatomic, assign) NSInteger TVOCScale;
@property (nonatomic, assign) NSInteger TVOCMin;
@property (nonatomic, assign) NSInteger TVOCMax;

//0x15:CO(一氧化碳)
@property (nonatomic, assign) NSInteger COScale;
@property (nonatomic, assign) NSInteger COMin;
@property (nonatomic, assign) NSInteger COMax;

//0x16:闹钟功能声明
@property (nonatomic, assign) BOOL alarmAllSupport;
@property (nonatomic, assign) NSInteger alarmCount;
@property (nonatomic, assign) NSInteger alarmMode;

//0x17:恢复出厂设置声明
@property (nonatomic, assign) BOOL restoreFactorySupport;

//0x18:参数校准声明
@property (nonatomic, strong) NSArray<NSNumber *> *_Nullable calibrationSupportArray;

//0x19:时间格式声明
@property (nonatomic, assign) BOOL timeFormat12HSupport;
@property (nonatomic, assign) BOOL timeFormat24HSupport;

//0x1A:设备亮度声明
@property (nonatomic, assign) BOOL deviceBrightnessAuto;
@property (nonatomic, assign) BOOL deviceBrightnessManual;
@property (nonatomic, assign) BOOL deviceBrightnessGearMode;
@property (nonatomic, assign) BOOL deviceBrightnessGearMax;

//0x1B:按键音效声明
@property (nonatomic, assign) BOOL keySoundSupport;

//0x1C:报警音效声明
@property (nonatomic, assign) BOOL alertSoundSupport;

//0x1D:图标显示声明
@property (nonatomic, assign) BOOL iconDisplaySupport;

//0x1E:监控显示数据声明
@property (nonatomic, assign) BOOL monitoringDisplayDataSupport;

//0x1F:数据显示模式声明
@property (nonatomic, assign) NSInteger dataDisplayModeCount;


@end

NS_ASSUME_NONNULL_END
