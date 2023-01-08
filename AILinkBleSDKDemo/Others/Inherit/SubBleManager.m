//
//  SubBleManager.m
//  AILinkBleSDKSourceCode
//
//  Created by iot_user on 2020/4/7.
//  Copyright © 2020 IOT. All rights reserved.
//

#import "SubBleManager.h"

@implementation SubBleManager
+(instancetype)shareManager{
    static SubBleManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });

    return manager;
}
#pragma mark ============ 实现父类的方法 ==============
-(void)bluetoothUpdateState:(ELBluetoothState)state{
    if ([self.subDelegate respondsToSelector:@selector(subBluetoothUpdateState:)]) {
        [self.subDelegate subBluetoothUpdateState:state];
    }

}

-(void)bluetoothScanPeripherals:(NSArray *)peripherals{
    //筛选单种设备
    //这里以体脂秤为例
    NSArray *device = [ELPeripheralModel getDevicesWithPeripherals:peripherals supportDeviceType:(ELSupportDeviceTypeBodyFatScale)];
//    NSArray *device = [ELPeripheralModel getDevicesWithPeripherals:peripherals supportDeviceTypes:@[@(ELSupportDeviceTypeBodyFatScale),@(ELSupportDeviceTypeBLE_WIFIScale)]];
    if ([self.subDelegate respondsToSelector:@selector(subBluetoothScanPeripherals:)]) {
        [self.subDelegate subBluetoothScanPeripherals:device];
    }

}


/**
Callback decrypted A7 transparent data (payload part), type device type( 回调解密后的A7透传数据(payload部分),type设备类型)
 */
-(void)bluetoothReceiveData:(NSData *)playload deviceType:(ELSupportDeviceType)type{
    if (type == ELSupportDeviceTypeBodyFatScale /*|| type == ELSupportDeviceTypeBLE_WIFIScale*/) {
        //根据体脂秤协议解析playload部分
        
    }
}

/**
 The special A6 data will only be received by the supported devices, and the complete A6 data (A6 is not encrypted) is passed to the subclass resolution.
 特殊的A6数据，只有支持的设备才会收到，将完整A6数据(A6不加密)传给子类解析
 ELSupportDeviceType support：
 ELSupportDeviceTypeBodyFatScale
 ELSupportDeviceTypeSmartLock
 */
-(void)bluetoothBackA6Data:(NSData *)data withClassId:(ELSupportDeviceType)type{
    if (type == ELSupportDeviceTypeBodyFatScale /*|| type == ELSupportDeviceTypeBLE_WIFIScale*/) {
        //根据体脂秤协议解析data部分
        
    }
}

/**
 Callback to scan special devices that can be bound, such as door locks（回调扫描到的可以绑定的特殊设备，如门锁）
 */
-(void)bluetoothScanCanBindSpecialPeripherals:(NSArray *)peripherals{
    //特殊数据：这个方法目前只有门锁会用到
}

/**
 Callback device basic information（回调设备基本信息）

 @param data Device basic information payload data (length is 16 bytes)（设备基本信息pabyload数据（长度为16个byte））
 */
-(void)bluetoothReceiveBasicInfoPayloadData:(NSData *)data{
    //特殊数据：门锁和胎压监测会用到,需根据具体协议解析
}

///Callback transparent transmission data(回调透传数据)
/// @param data Transparent data(透传数据)
-(void)bluetoothReceivePassData:(NSData *)data{
    //Parsing transparent transmission data(解析透传数据)
}
#pragma mark ============ 发送数据给蓝牙 ==============
-(void)subBleSendA6Data:(NSData *)data{
    [self sendCmdToMCUWithA6PayloadData:data];
}
-(void)subBleSendA7Data:(NSData *)payload{
    [self sendCmdToMCUWithA7PayloadData:payload deviceType:(ELSupportDeviceTypeBodyFatScale)];
}
@end
