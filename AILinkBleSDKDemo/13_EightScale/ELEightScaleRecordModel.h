//
//  ELEightScaleRecordModel.h
//  Elink
//
//  Created by iot_user on 2020/6/9.
//  Copyright © 2020 iot_iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELEightScaleRecordModel : NSObject

///bmi
@property (nonatomic, copy) NSString *bmi;
///体脂率
@property (nonatomic, copy) NSString *bfr;
///皮下脂肪率
@property (nonatomic, copy) NSString *sfr;
///内脏脂肪指数
@property (nonatomic, copy) NSString *uvi;
///肌肉率
@property (nonatomic, copy) NSString *rom;
///基础代谢率
@property (nonatomic, copy) NSString *bmr;
///骨骼质量 //特别注意：所有重量单位只有骨量在服务器上永远存储kg，其他重量属性都存储的是转换后的显示值；并且无论秤返回的weight数值是何种单位，但秤返回或Algorithm算法算出的骨量都是kg单位
@property (nonatomic, copy) NSString *bm;
///水含量
@property (nonatomic, copy) NSString *vwc;
///身体年龄
@property (nonatomic, assign) NSString *bodyAge;
///蛋白率
@property (nonatomic, copy) NSString *pp;
///躯干阻抗
@property (nonatomic, copy) NSString *adc;
///心率
@property (nonatomic, copy) NSString *heartRate;
///创建时间
@property (nonatomic, assign) long long createTime;
///秤的算法id
@property (nonatomic, copy) NSString *deviceAlgorithm;
///
@property (nonatomic, copy) NSString *standardWeight;
///
@property (nonatomic, copy) NSString *weightControl;
///
@property (nonatomic, copy) NSString *fatMass;
///
@property (nonatomic, copy) NSString *weightWithoutFat;
///
@property (nonatomic, copy) NSString *musleMass;
///
@property (nonatomic, copy) NSString *proteinMass;
///肥胖等级
@property (nonatomic, copy) NSString *fatLevel;



//体脂-右上
@property (nonatomic, copy) NSString *fatMassRightTop;
//体脂-右下
@property (nonatomic, copy) NSString *fatMassRightBottom;
//体脂-左上
@property (nonatomic, copy) NSString *fatMassLeftTop;
//体脂-左下
@property (nonatomic, copy) NSString *fatMassLeftBottom;
//体脂-躯干
@property (nonatomic, copy) NSString *fatMassBody;
//肌肉-右上
@property (nonatomic, copy) NSString *musleMassRightTop;
//肌肉-右下
@property (nonatomic, copy) NSString *musleMassRightBottom;
//肌肉-左上
@property (nonatomic, copy) NSString *musleMassLeftTop;
//肌肉-左下
@property (nonatomic, copy) NSString *musleMassLeftBottom;
//肌肉-躯干
@property (nonatomic, copy) NSString *musleMassBody;
//四肢肌肉指数
@property (nonatomic, copy) NSString *musleMassLimbs;


@end

NS_ASSUME_NONNULL_END
