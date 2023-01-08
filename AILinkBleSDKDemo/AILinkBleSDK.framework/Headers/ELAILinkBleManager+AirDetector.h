//
//  ELAILinkBleManager+AirDetector.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/12/12.
//

#import "ELAILinkBleManager.h"
#import "ELAirDetectorBleHeader.h"
#import "ELTLVModel.h"
#import "ELAirDetectorBleParser.h"

//typedef NS_ENUM(NSUInteger, ELAirDetectorTLVType);
//typedef NS_ENUM(NSUInteger, ELAirDetectorBleCMD);

NS_ASSUME_NONNULL_BEGIN

@interface ELAILinkBleManager (AirDetector)

//APP获取设备功能列表 //0x01    CMD：获取设备支持的功能列表
- (void)airDetectorRequestDeviceFunctions;

//APP获取设备状态 //0x03    CMD：获取设备状态
- (void)airDetectorRequestDeviceStatus;

//APP设置/获取参数 //0x05    CMD：设置/获取参数功能
- (void)airDetectorRequestDeviceSettings;
- (void)airDetectorSendDeviceSettings:(NSArray<ELTLVModel *> *)tlvs;

//APP与模块心跳 //0x07    CMD：定时心跳包
- (void)airDetectorSendHeartbeat;


@end

@interface ELAILinkBleManager (tlv)

//0x01:甲醛
+ (ELTLVModel *)tlvHCHOAlarmOn:(BOOL)on value:(NSInteger)value;

//0x02:温度 //参数: scale(标度) 表示小数点位数
+ (ELTLVModel *)tlvTemperatureMinValue:(NSInteger)minValue maxValue:(NSInteger)maxValue uint:(ELDeviceTemperatureUnit)unit scale:(NSInteger)scale;

//0x03:湿度
+ (ELTLVModel *)tlvHumidityMinValue:(NSInteger)minValue maxValue:(NSInteger)maxValue;

//0x04:PM2.5
+ (ELTLVModel *)tlvPM2_5AlarmOn:(BOOL)on value:(NSInteger)value;

//0x05:PM1.0
+ (ELTLVModel *)tlvPM1AlarmOn:(BOOL)on value:(NSInteger)value;

//0x06:PM10
+ (ELTLVModel *)tlvPM10AlarmOn:(BOOL)on value:(NSInteger)value;

//0x07:VOC
+ (ELTLVModel *)tlvVOCAlarmOn:(BOOL)on value:(NSInteger)value;

//0x08:CO2
+ (ELTLVModel *)tlvCO2AlarmOn:(BOOL)on value:(NSInteger)value;

//0x09:AQI
+ (ELTLVModel *)tlvAQIAlarmOn:(BOOL)on value:(NSInteger)value;

//0x0B:音量状态
+ (ELTLVModel *)tlvVolumeOn:(BOOL)on value:(NSInteger)value;

//0x0C:报警时长
+ (ELTLVModel *)tlvAlertDuration:(NSInteger)duration;

//0x0D:报警铃声
+ (ELTLVModel *)tlvAlertRing:(NSInteger)ringValue;

//0x0F:设备自检 ??
+ (ELTLVModel *)tlvSelf:(NSInteger)ringValue;

//0x10:TVOC
+ (ELTLVModel *)tlvTVOCAlarmOn:(BOOL)on value:(NSInteger)value;

//0x11:单位切换
+ (ELTLVModel *)tlvTemperatureUint:(ELDeviceTemperatureUnit)unit;

//0x13:设备绑定
+ (ELTLVModel *)tlvBindDeviceRequest;
+ (ELTLVModel *)tlvBindDeviceCancel;

//0x15:CO
+ (ELTLVModel *)tlvCOAlarmOn:(BOOL)on value:(NSInteger)value;

//0x16:闹钟设置
+ (ELTLVModel *)tlvSetupAlarms:(NSArray *)alarms;

//0x17:恢复出厂设置
+ (ELTLVModel *)tlvRestoreFactory;

//0x18:参数校准设置
+ (ELTLVModel *)tlvCalibrationUp:(ELAirDetectorTLVType)type;
+ (ELTLVModel *)tlvCalibrationDown:(ELAirDetectorTLVType)type;
+ (ELTLVModel *)tlvCalibrationReset:(ELAirDetectorTLVType)type;

//0x19:时间格式设置
+ (ELTLVModel *)tlvTimeFormat12H;
+ (ELTLVModel *)tlvTimeFormat24H;

//0x1A:设备亮度设置
+ (ELTLVModel *)tlvDeviceBrightnessOn:(BOOL)on value:(NSInteger)value;

//0x1B:按键音效设置
+ (ELTLVModel *)tlvKeySoundOn;
+ (ELTLVModel *)tlvKeySoundOff;

//0x1C:报警音效设置
+ (ELTLVModel *)tlvAlertSoundOn;
+ (ELTLVModel *)tlvAlertSoundOff;

//0x1D:图标显示设置
+ (ELTLVModel *)tlvIconDisplayOn;
+ (ELTLVModel *)tlvIconDisplayOff;

//0x1E:监控显示数据
+ (ELTLVModel *)tlvMonitoringDisplayDataOn;
+ (ELTLVModel *)tlvMonitoringDisplayDataOff;

//0x1F:数据显示模式设置
+ (ELTLVModel *)tlvDataDisplayMode:(NSInteger)mode;


@end

NS_ASSUME_NONNULL_END

