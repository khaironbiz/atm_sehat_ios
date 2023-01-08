//
//  SubBleManager.h
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import <AILinkBleSDK/ELBluetoothManager.h>

@protocol SubBleManagerDelegate <NSObject>

//蓝牙连接状态
-(void)subBluetoothUpdateState:(ELBluetoothState)state;
//扫描到的设备
-(void)subBluetoothScanPeripherals:(NSArray *)peripherals;
@end


NS_ASSUME_NONNULL_BEGIN

@interface SubBleManager : ELBluetoothManager
//
@property (nonatomic, weak) id<SubBleManagerDelegate> subDelegate;

+(instancetype)shareManager;


/// 发送数据给mcu
/// @param data 协议对应数据
-(void)subBleSendA6Data:(NSData *)data;

/// 发送数据给蓝牙
/// @param payload 协议的payload部分数据
-(void)subBleSendA7Data:(NSData *)payload;
@end

NS_ASSUME_NONNULL_END
