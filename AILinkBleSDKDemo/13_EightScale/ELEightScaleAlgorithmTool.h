//
//  ELEightScaleAlgorithmTool.h
//  Elink
//
//  Created by iot_user on 2020/6/18.
//  Copyright © 2020 iot_iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELEightScaleRecordModel;
@class ELEightScaleBleDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ELEightScaleAlgorithmTool : NSObject


/// 根据秤测量的阻抗数据调用算法解析出其他体脂数据
/// @param dataModel 八电极秤测量的数据
/// @param sex  女性传0，男性传1
/// @param height 身高，单位cm
/// @param age  年龄
+(ELEightScaleRecordModel *)getRecordModelWithBleDataModel:(ELEightScaleBleDataModel *)dataModel withUserSex:(NSInteger)sex height:(NSInteger)height age:(NSInteger)age;

//新算法
+(ELEightScaleRecordModel *)getNewRecordModelWithBleDataModel:(ELEightScaleBleDataModel *)dataModel withUserSex:(NSInteger)sex height:(NSInteger)height age:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
