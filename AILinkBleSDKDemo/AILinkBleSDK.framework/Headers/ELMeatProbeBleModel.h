//
//  ELMeatProbeBleModel.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/11/22.
//

#import <Foundation/Foundation.h>
#import "ELMeatProbeBleTool.h"

NS_ASSUME_NONNULL_BEGIN

///
@interface ELMeatProbeBleModel : NSObject

@property (nonatomic, assign, readonly) UInt8 ver; //数据版本 (当前版本 0x01) //数据总长度: modelSize()

@property (nonatomic, assign) UInt32 cookingId; //烧烤id (选择食物的时间戳)

@property (nonatomic, assign) UInt8 foodType; //食物类型
@property (nonatomic, assign) UInt8 foodRawness; //食物熟度
@property (nonatomic, assign) UInt16 targetRawTemperature; //食物目标温度 Bit15: 单位（0：℃ 。 1：℉） Bit14：正负（0：温度为正值。1：温度为负值） Bit13-Bit0：温度值。
@property (nonatomic, assign, readonly) NSInteger targetTemperature;
@property (nonatomic, assign, readonly) ELDeviceTemperatureUnit targetTemperatureUnit;

@property (nonatomic, assign) UInt16 ambientMinRawTemperature; //炉温目标下限 Bit15: 单位（0：℃ 。 1：℉） Bit14：正负（0：温度为正值。1：温度为负值） Bit13-Bit0：温度值。
@property (nonatomic, assign, readonly) NSInteger ambientMinTemperature;
@property (nonatomic, assign, readonly) ELDeviceTemperatureUnit ambientMinTemperatureUnit;
@property (nonatomic, assign) UInt16 ambientMaxRawTemperature; //炉温目标上限 Bit15: 单位（0：℃ 。 1：℉） Bit14：正负（0：温度为正值。1：温度为负值）Bit13-Bit0：温度值。
@property (nonatomic, assign, readonly) NSInteger ambientMaxTemperature;
@property (nonatomic, assign, readonly) ELDeviceTemperatureUnit ambientMaxTemperatureUnit;

@property (nonatomic, assign) UInt32 timerStart;//计时开始时间戳
@property (nonatomic, assign) UInt32 timerEnd;//计时结束时间戳

@property (nonatomic, assign) ELDeviceTemperatureUnit currentUnit; //当前温度单位


- (instancetype)initWithData:(NSData *)data;
+ (ELMeatProbeBleModel *)modelWithData:(NSData *)data;

- (NSData *)dataValue;

@end

NS_ASSUME_NONNULL_END
