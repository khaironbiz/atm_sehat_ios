//
//  ELAILinkBleManager.h
//
//  Created by LarryZhang on 2022/8/13.
//  Copyright © 2022 iot_iMac. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "NELBleManagerHeader.h"
#import "ELSDKHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class ELAILinkPeripheral;

@protocol ELAILinkBleManagerDelegate <NSObject>

@optional

//扫描
- (void)managerDidUpdateState:(CBCentralManager *)central;

- (void)managerScanState:(BOOL)scanning;

- (void)managerDidDiscoverPeripheral:(ELAILinkPeripheral *)peripheral;

- (void)managerDidDiscoverMorePeripheral:(NSDictionary<NSUUID *, ELAILinkPeripheral *> *)peripherals;

//连接
- (void)managerDidConnectPeripheral:(CBPeripheral *)peripheral;

- (void)managerDidFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

- (void)managerDidDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

- (void)managerDidUpdateConnect:(NELBleManagerConnectState)state;

//服务 & 特征
- (void)peripheralDidDiscoverServices:(NSArray<CBService *> *)services;

- (void)peripheralDidDiscoverCharacteristicsForService:(NSArray<CBCharacteristic *> *)characteristics;

- (void)peripheralDidUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic;

- (void)peripheralDidUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;

- (void)didWriteValueForCharacteristic:(CBCharacteristic *)characteristic;

- (void)peripheralDidReadRSSI:(nonnull NSNumber *)RSSI;


@optional

//A7数据 payload
- (void)aiLinkBleReceiveA7Data:(NSData *)payload;

//A6数据 packet
- (void)aiLinkBleReceiveA6Data:(NSData *)packet;


@end

@interface ELAILinkBleManager : NSObject

@property(nonatomic, assign, readonly, getter=isScanning) BOOL scanning;

@property(nonatomic, assign, readonly) CBCentralManager *central;

@property (nonatomic, weak) id<ELAILinkBleManagerDelegate> delegate DEPRECATED_MSG_ATTRIBUTE("use 'ailinkDelegate' only");

//不是必须使用单例
+ (instancetype)sharedManager;


@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, weak) id<ELAILinkBleManagerDelegate> ailinkDelegate;

//模块版本号
@property (nonatomic, copy) NSString *bmVersion;
@property (nonatomic, copy) NSString *bmVersionPro;
//电池状态
@property (nonatomic, assign) struct ELBatteryStruct battery;
//单位列表
@property (nonatomic, strong) NSArray<NSNumber *> *weightArray;
@property (nonatomic, strong) NSArray<NSNumber *> *heightArray;
@property (nonatomic, strong) NSArray<NSNumber *> *temperatureArray;
@property (nonatomic, strong) NSArray<NSNumber *> *bloodPressureArray;
@property (nonatomic, strong) NSArray<NSNumber *> *pressureArray;
@property (nonatomic, strong) NSArray<NSNumber *> *bloodSugarUnitArray;
@property (nonatomic, strong) NSArray<NSNumber *> *volumeUnitArray;

@end

@interface ELAILinkBleManager (scan)

- (void)scanAll;
- (void)scanFilterWithCidArray:(NSArray<NSNumber *> *_Nonnull)cidArray;
- (void)scanFilterWithMacArray:(NSArray<NSString *> *_Nonnull)macArray;
- (void)scanFilterWithCidArray:(NSArray<NSNumber *> *_Nonnull)cidArray macArray:(NSArray<NSString *> *_Nonnull)macArray;

// 获取当前连接到系统的 peripheral 设备的列表(如被其它程序连接着)
- (NSArray<CBPeripheral *> *)retrieveConnectedPeripherals;

//NELBleManager
- (void)stopScan;


@end

@interface ELAILinkBleManager (connect)

- (void)connectPeripheral:(CBPeripheral *)peripheral;

- (void)disconnectPeripheral;


- (void)connectAILinkPeripheral:(ELAILinkPeripheral * _Nonnull)ailinkPeripheral;

- (ELAILinkPeripheral * _Nullable)currentAILinkPeripheral;

@end



@interface ELAILinkBleManager (send)

- (void)sendA7Payload:(NSData *)payload;
- (void)sendA6Payload:(NSData *)payload;

//base method of 'sendA7Payload' & 'sendA6Payload'
- (void)sendCmd:(NSData *)cmdData;

////最大发送payload长度
//- (NSUInteger)maximumWritePayloadLength;
////OTA最大发送payload长度
//- (NSUInteger)maximumWriteOTAPayloadLength;

//发送队列发送周期
- (void)configWriteDataQueueInterval:(CGFloat)interval;

@end

@interface ELAILinkBleManager (A6Method)

/**
 Sync the current time of phone to BLE(设置手机本地时间给蓝牙模块，只在蓝牙体脂秤等需要蓝牙模块保存历史记录时才调用)
 @param enable
 NO: In addition to the ability to turn off the time function, you can save part of the current (default)(除能，关闭时间功能，可省部分电流（默认）)
 YES:Enable, turn on the timer function timer(使能，开启计时功能定时器)
 */
- (void)syncBleNowDate:(BOOL)enable;

///仅WIFI秤调用，同步世界时间(0时区)到wifi-ble模块
- (void)syncBleGMTNowDate:(BOOL)enable;

///同步手机本地时间给mcu，每次连接成功后会自动调用
- (void)syncMCUNowDate;

@end




#pragma mark - ELAILinkPeripheral

@interface ELAILinkPeripheral : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSDictionary *advertisementData;

@property (nonatomic, strong) NSNumber *RSSI;

@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, copy) NSString *macAddressString;
@property (nonatomic, strong) NSData *macData;

@property (nonatomic, assign) UInt16 cid;

@property (nonatomic, assign) UInt16 vid;

@property (nonatomic, assign) UInt16 pid;


@property (nonatomic, strong) NSUUID *identifier;

@end


NS_ASSUME_NONNULL_END
