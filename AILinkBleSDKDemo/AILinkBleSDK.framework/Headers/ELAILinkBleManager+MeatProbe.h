//
//  ELAILinkBleManager+MeatProbe.h
//  AILinkBleSDK
//
//  Created by LarryZhang on 2022/11/22.
//

#import "ELAILinkBleManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELAILinkBleManager (MeatProbe)


//MeatProbe 设置设备信息 0x35
- (void)meatProbeSendCustomData:(NSData *_Nonnull)customData;

//MeatProbe 设置设备信息 0x35 请求
- (void)meatProbeRequestCustomData;

//切换温度单位 A7
- (void)meatProbeSwitchUint:(ELDeviceTemperatureUnit)unit;


//关闭自动关机指令 A7 **调试阶段使用
- (void)meatProbeCloseAutoOff;


@end

NS_ASSUME_NONNULL_END
