//
//  ELEightScaleAlgorithmTool.m
//  Elink
//
//  Created by iot_user on 2020/6/18.
//  Copyright © 2020 iot_iMac. All rights reserved.
//

#import "ELEightScaleAlgorithmTool.h"
#import "ELEightScaleRecordModel.h"
#import <AILinkBleSDK/ELEightScaleBleDataModel.h>
#import <AILinkBleSDK/ELEightScaleSDKHeader.h>
#import "HTBodyfat_SDK.h"
#import <AILinkBleSDK/ELHeightAlgorithmusModel.h>
#import <AILinkBleSDK/ELWeightAlgorithmusModel.h>
#import <AILinkBleSDK/ELBodyIndexAlgorithmModel.h>
#import "BhBodyCompositionAllBody50KHz.h"

@implementation ELEightScaleAlgorithmTool

//新算法
/// 根据秤测量的阻抗数据调用算法解析出其他体脂数据
/// @param dataModel 八电极秤测量的数据
/// @param sex  女性传0，男性传1
/// @param height 身高，单位cm
/// @param age  年龄
+ (ELEightScaleRecordModel *)getNewRecordModelWithBleDataModel:(ELEightScaleBleDataModel *)dataModel withUserSex:(NSInteger)sex height:(NSInteger)height age:(NSInteger)age {
    CGFloat kgWeight = [ELWeightAlgorithmusModel getKgWithWeightShowStr:dataModel.weight weightUnit:dataModel.weightUnit weightPoint:dataModel.weightPoint].floatValue;

    HTBodyBasicInfo *bodyBasicInfo = [[HTBodyBasicInfo alloc] initWithSex:sex height:height weight:kgWeight age:age];
    bodyBasicInfo.htZAllBodyImpedance = dataModel.RWholeBodyAdc;
    bodyBasicInfo.htZLeftLegImpedance = dataModel.leftFootAdc;
    bodyBasicInfo.htZRightLegImpedance = dataModel.rightFootAdc;
    bodyBasicInfo.htZLeftArmImpedance = dataModel.leftHandAdc;
    bodyBasicInfo.htZRightArmImpedance = dataModel.rightHandAdc;
    bodyBasicInfo.htTwoArmsImpedance = dataModel.handsAdc;
    bodyBasicInfo.htTwoLegsImpedance = dataModel.feetAdc;
    //计算体脂参数
    HTBodyResultAllBody *bodyResultTwoLegs = [[HTBodyResultAllBody alloc] init];
    HTBodyfatErrorType errorType = [bodyResultTwoLegs getBodyfatWithBasicInfo:bodyBasicInfo];
    NSLog(@"HTBodyfatErrorType = %lu",errorType);
    if(errorType != HTBodyfatErrorTypeNone){
        NSMutableString *errorStr = [[NSMutableString alloc]initWithString:@""];
        if((errorType & HTBodyfatErrorTypeAge) == HTBodyfatErrorTypeAge){
            [errorStr appendString:@"年龄 "];
        }
        if((errorType & HTBodyfatErrorTypeWeight) == HTBodyfatErrorTypeWeight){
            [errorStr appendString:@"体重 "];
        }
        if((errorType & HTBodyfatErrorTypeHeight) == HTBodyfatErrorTypeHeight){
            [errorStr appendString:@"身高 "];
        }
        if((errorType & HTBodyfatErrorTypeSex) == HTBodyfatErrorTypeSex){
            [errorStr appendString:@"性别 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedance) == HTBodyfatErrorTypeImpedance){
            [errorStr appendString:@"阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceLeftLeg) == HTBodyfatErrorTypeImpedanceLeftLeg){
            [errorStr appendString:@"左脚阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceRightLeg) == HTBodyfatErrorTypeImpedanceRightLeg){
            [errorStr appendString:@"右脚阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceLeftArm) == HTBodyfatErrorTypeImpedanceLeftArm){
            [errorStr appendString:@"左手阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceRightArm) == HTBodyfatErrorTypeImpedanceRightArm){
            [errorStr appendString:@"右手阻抗 "];
        }
        [errorStr appendString:@"参数有误！"];
        
        NSLog(@"errorType = %@",errorStr);
    }
    
    
    ELEightScaleRecordModel *recordModel = [[ELEightScaleRecordModel alloc] init];
    recordModel.bmi = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBMI];
    recordModel.bfr = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBodyfatPercentage];
    recordModel.sfr = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBodyfatSubcut];
    recordModel.uvi = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htVFAL];
    recordModel.rom = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htMusclePercentage];
    recordModel.bmr = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htBMR];
    recordModel.vwc = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htWaterPercentage];
    recordModel.bodyAge = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htBodyAge];
    recordModel.pp = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htProteinPercentage];
    recordModel.adc = [NSString stringWithFormat:@"%d",dataModel.trunkAdc];//记录躯干adc
    recordModel.heartRate = dataModel.heartRate>0?[NSString stringWithFormat:@"%d",dataModel.heartRate]:@"";
    recordModel.createTime = dataModel.createTime;
    recordModel.deviceAlgorithm = [NSString stringWithFormat:@"%d",dataModel.algorithmID];
    
    //新算法
    [self new_algorithmOfHTWithDataModel:dataModel sex:sex height:height kgWeight:kgWeight age:age updateRecordModel:recordModel];
    return recordModel;
}


/// 根据秤测量的阻抗数据调用算法解析出其他体脂数据
/// @param dataModel 八电极秤测量的数据
/// @param sex  女性传0，男性传1
/// @param height 身高，单位cm
/// @param age  年龄
+ (ELEightScaleRecordModel *)getRecordModelWithBleDataModel:(ELEightScaleBleDataModel *)dataModel withUserSex:(NSInteger)sex height:(NSInteger)height age:(NSInteger)age {
    CGFloat kgWeight = [ELWeightAlgorithmusModel getKgWithWeightShowStr:dataModel.weight weightUnit:dataModel.weightUnit weightPoint:dataModel.weightPoint].floatValue;

    HTBodyBasicInfo *bodyBasicInfo = [[HTBodyBasicInfo alloc] initWithSex:sex height:height weight:kgWeight age:age];
    bodyBasicInfo.htZAllBodyImpedance = dataModel.RWholeBodyAdc;
    bodyBasicInfo.htZLeftLegImpedance = dataModel.leftFootAdc;
    bodyBasicInfo.htZRightLegImpedance = dataModel.rightFootAdc;
    bodyBasicInfo.htZLeftArmImpedance = dataModel.leftHandAdc;
    bodyBasicInfo.htZRightArmImpedance = dataModel.rightHandAdc;
    bodyBasicInfo.htTwoArmsImpedance = dataModel.handsAdc;
    bodyBasicInfo.htTwoLegsImpedance = dataModel.feetAdc;
    //计算体脂参数
    HTBodyResultAllBody *bodyResultTwoLegs = [[HTBodyResultAllBody alloc] init];
    HTBodyfatErrorType errorType = [bodyResultTwoLegs getBodyfatWithBasicInfo:bodyBasicInfo];
    NSLog(@"HTBodyfatErrorType = %lu",errorType);
    if(errorType != HTBodyfatErrorTypeNone){
        NSMutableString *errorStr = [[NSMutableString alloc]initWithString:@""];
        if((errorType & HTBodyfatErrorTypeAge) == HTBodyfatErrorTypeAge){
            [errorStr appendString:@"年龄 "];
        }
        if((errorType & HTBodyfatErrorTypeWeight) == HTBodyfatErrorTypeWeight){
            [errorStr appendString:@"体重 "];
        }
        if((errorType & HTBodyfatErrorTypeHeight) == HTBodyfatErrorTypeHeight){
            [errorStr appendString:@"身高 "];
        }
        if((errorType & HTBodyfatErrorTypeSex) == HTBodyfatErrorTypeSex){
            [errorStr appendString:@"性别 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedance) == HTBodyfatErrorTypeImpedance){
            [errorStr appendString:@"阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceLeftLeg) == HTBodyfatErrorTypeImpedanceLeftLeg){
            [errorStr appendString:@"左脚阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceRightLeg) == HTBodyfatErrorTypeImpedanceRightLeg){
            [errorStr appendString:@"右脚阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceLeftArm) == HTBodyfatErrorTypeImpedanceLeftArm){
            [errorStr appendString:@"左手阻抗 "];
        }
        if((errorType & HTBodyfatErrorTypeImpedanceRightArm) == HTBodyfatErrorTypeImpedanceRightArm){
            [errorStr appendString:@"右手阻抗 "];
        }
        [errorStr appendString:@"参数有误！"];
        
        NSLog(@"errorType = %@",errorStr);
    }
    
    
    ELEightScaleRecordModel *recordModel = [[ELEightScaleRecordModel alloc] init];
    recordModel.bmi = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBMI];
    recordModel.bfr = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBodyfatPercentage];
    recordModel.sfr = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htBodyfatSubcut];
    recordModel.uvi = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htVFAL];
    recordModel.rom = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htMusclePercentage];
    recordModel.bmr = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htBMR];
    recordModel.vwc = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htWaterPercentage];
    recordModel.bodyAge = [NSString stringWithFormat:@"%ld",bodyResultTwoLegs.htBodyAge];
    recordModel.pp = [NSString stringWithFormat:@"%.1f",bodyResultTwoLegs.htProteinPercentage];
    recordModel.adc = [NSString stringWithFormat:@"%d",dataModel.trunkAdc];//记录躯干adc
    recordModel.heartRate = dataModel.heartRate>0?[NSString stringWithFormat:@"%d",dataModel.heartRate]:@"";
    recordModel.createTime = dataModel.createTime;
    recordModel.deviceAlgorithm = [NSString stringWithFormat:@"%d",dataModel.algorithmID];

    //骨量
    if (bodyResultTwoLegs.htBoneKg>0) {
        NSUInteger boneMass = roundf(bodyResultTwoLegs.htBoneKg*pow(10, dataModel.weightPoint));
        recordModel.bm = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:boneMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.bm = @"";
    }

    
    //标准体重
    if (bodyResultTwoLegs.htIdealWeightKg >0) {
        //说明有值
        NSUInteger standard = roundf(bodyResultTwoLegs.htIdealWeightKg*pow(10, dataModel.weightPoint));
        recordModel.standardWeight = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:standard bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
        //体重控制量
        CGFloat weightControl = kgWeight - bodyResultTwoLegs.htIdealWeightKg;
        NSUInteger weightContrlABS = roundf(fabs(weightControl*pow(10, dataModel.weightPoint)));
        NSString *weightContrlStr = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:weightContrlABS bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
        if (weightControl<0) {
            recordModel.weightControl = [NSString stringWithFormat:@"-%@",weightContrlStr];
        }else{
            recordModel.weightControl = weightContrlStr;
        }
        recordModel.fatLevel =  [NSString stringWithFormat:@"%lu",(unsigned long)[ELBodyIndexAlgorithmModel getfatLevelWithweight:kgWeight andStandardWeight:bodyResultTwoLegs.htIdealWeightKg]];
    }else{
        recordModel.standardWeight = @"";
        recordModel.weightControl = @"";
        recordModel.fatLevel = @"";
    }
    //脂肪量
    if (bodyResultTwoLegs.htBodyfatKg>0) {
        NSUInteger fatMass = roundf(bodyResultTwoLegs.htBodyfatKg*pow(10, dataModel.weightPoint));
        recordModel.fatMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:fatMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMass = @"";
    }
    //去脂体重
    if (bodyResultTwoLegs.htBodyfatFreeMass>0) {
        NSUInteger withoutFatW = roundf(bodyResultTwoLegs.htBodyfatFreeMass*pow(10, dataModel.weightPoint));
        recordModel.weightWithoutFat = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:withoutFatW bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.weightWithoutFat = @"";
    }
    //肌肉量
    if (bodyResultTwoLegs.htMuscleKg>0) {
        NSInteger musleMass = round(bodyResultTwoLegs.htMuscleKg*pow(10, dataModel.weightPoint));
        recordModel.musleMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:musleMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMass = @"";
    }
    //蛋白量
    if (bodyResultTwoLegs.htProteinPercentage>0) {
        NSUInteger proteinMassInt = roundf((bodyResultTwoLegs.htProteinPercentage/100.0)*kgWeight* pow(10, dataModel.weightPoint));
        recordModel.proteinMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:proteinMassInt bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.proteinMass = @"";
    }
    //体脂-右手
    if (bodyResultTwoLegs.htBodyfatKgRightArm >0) {
        NSUInteger rightHand = roundf(bodyResultTwoLegs.htBodyfatKgRightArm*pow(10, dataModel.weightPoint));
        recordModel.fatMassRightTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassRightTop = @"";
    }
    //体脂-右脚
    if (bodyResultTwoLegs.htBodyfatKgRightLeg >0) {
        NSUInteger rightFoot = roundf(bodyResultTwoLegs.htBodyfatKgRightLeg*pow(10, dataModel.weightPoint));
        recordModel.fatMassRightBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassRightBottom = @"";
    }
    //体脂-左手
    if (bodyResultTwoLegs.htBodyfatKgLeftArm >0) {
        NSUInteger leftHand = roundf(bodyResultTwoLegs.htBodyfatKgLeftArm*pow(10, dataModel.weightPoint));
        recordModel.fatMassLeftTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassLeftTop = @"";
    }
    //体脂-左脚
    if (bodyResultTwoLegs.htBodyfatKgLeftLeg >0) {
        NSUInteger leftFoot = roundf(bodyResultTwoLegs.htBodyfatKgLeftLeg*pow(10, dataModel.weightPoint));
        recordModel.fatMassLeftBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassLeftBottom = @"";
    }
    //体脂-躯干
    if (bodyResultTwoLegs.htBodyfatKgTrunk >0) {
        NSUInteger fatMassBody = roundf(bodyResultTwoLegs.htBodyfatKgTrunk*pow(10, dataModel.weightPoint));
        recordModel.fatMassBody = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:fatMassBody bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassBody = @"";
    }
    //肌肉-右手
    if (bodyResultTwoLegs.htMuscleKgRightArm >0) {
        NSUInteger rightHand = roundf(bodyResultTwoLegs.htMuscleKgRightArm*pow(10, dataModel.weightPoint));
        recordModel.musleMassRightTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassRightTop = @"";
    }
    //肌肉-右脚
    if (bodyResultTwoLegs.htMuscleKgRightLeg >0) {
        NSUInteger rightFoot = roundf(bodyResultTwoLegs.htMuscleKgRightLeg*pow(10, dataModel.weightPoint));
        recordModel.musleMassRightBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassRightBottom = @"";
    }
    //肌肉-左手
    if (bodyResultTwoLegs.htMuscleKgLeftArm >0) {
        NSUInteger leftHand = roundf(bodyResultTwoLegs.htMuscleKgLeftArm*pow(10, dataModel.weightPoint));
        recordModel.musleMassLeftTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassLeftTop = @"";
    }
    //肌肉-左脚
    if (bodyResultTwoLegs.htMuscleKgeLeftLeg >0) {
        NSUInteger leftFoot = roundf(bodyResultTwoLegs.htMuscleKgeLeftLeg*pow(10, dataModel.weightPoint));
        recordModel.musleMassLeftBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassLeftBottom = @"";
    }
    //肌肉-躯干
    if (bodyResultTwoLegs.htMuscleKgTrunk >0) {
        NSUInteger muscleMassBody = roundf(bodyResultTwoLegs.htMuscleKgTrunk*pow(10, dataModel.weightPoint));
        recordModel.musleMassBody = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:muscleMassBody bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassBody = @"";
    }
    //四肢肌肉指数 = 四肢肌肉量(kg)/身高的平方(m)
    CGFloat heightM = (height/100.0);
    CGFloat index = (bodyResultTwoLegs.htMuscleKgLeftArm+bodyResultTwoLegs.htMuscleKgeLeftLeg+bodyResultTwoLegs.htMuscleKgRightArm+bodyResultTwoLegs.htMuscleKgRightLeg)/(heightM*heightM);
    recordModel.musleMassLimbs = [NSString stringWithFormat:@"%.1f",index];
    
    return recordModel;
}

#pragma mark - 新算法

+(void)new_algorithmOfHTWithDataModel:(ELEightScaleBleDataModel *)dataModel sex:(BhSexType)sex height:(CGFloat)height kgWeight:(CGFloat)kgWeight age:(NSInteger)age updateRecordModel:(ELEightScaleRecordModel *)recordModel {
    
#if TARGET_IPHONE_SIMULATOR == 0
    //HT算法
    BhSexType htSex = sex;
    BhBodyCompositionAllBody50KHz *bodyCompositon = [[BhBodyCompositionAllBody50KHz alloc] init];
    bodyCompositon.bhSex = htSex;
    bodyCompositon.bhPeopleType = BH_PEOPLE_TYPE_NORMAL;
    bodyCompositon.bhHeightCm = height;
    bodyCompositon.bhWeightKg = kgWeight;
    bodyCompositon.bhAge = (int)age;
    bodyCompositon.bhZLeftArmEnCode = dataModel.leftHandAdc;
    bodyCompositon.bhZRightArmEnCode = dataModel.rightHandAdc;
    bodyCompositon.bhZLeftLegEnCode = dataModel.leftFootAdc;
    bodyCompositon.bhZRightLegEnCode = dataModel.rightFootAdc;
    bodyCompositon.bhZLeftBodyEnCode = dataModel.RWholeBodyAdc;
    BhErrorType errType = [bodyCompositon getBhBodyCompositionAllBody50KHz];
    NSLog(@"errType(不为0就有问题) = %zd",errType);
    
    //显示体脂参数
    
    recordModel.bmi = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhBMI];
    recordModel.bfr = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhBodyFatRate];
    recordModel.sfr = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhBodyFatSubCutRate];
    recordModel.uvi = [NSString stringWithFormat:@"%u",bodyCompositon.bhVFAL];
    recordModel.rom = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhMuscleRate];
    recordModel.bmr = [NSString stringWithFormat:@"%u",bodyCompositon.bhBMR];
    recordModel.vwc = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhWaterRate];
    recordModel.bodyAge = [NSString stringWithFormat:@"%u",bodyCompositon.bhBodyAge];
    recordModel.pp = [NSString stringWithFormat:@"%.1f",bodyCompositon.bhProteinRate];
    recordModel.adc = [NSString stringWithFormat:@"%d",dataModel.trunkAdc];//记录躯干adc
    recordModel.heartRate = dataModel.heartRate>0?[NSString stringWithFormat:@"%d",dataModel.heartRate]:@"";
    recordModel.createTime = dataModel.createTime;
    recordModel.deviceAlgorithm = [NSString stringWithFormat:@"%d",dataModel.algorithmID];
    //骨量
    if (bodyCompositon.bhBoneKg>0) {
        NSUInteger boneMass = roundf(bodyCompositon.bhBoneKg*pow(10, dataModel.weightPoint));
        recordModel.bm = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:boneMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.bm = @"";
    }

    
    //标准体重
    if (bodyCompositon.bhIdealWeightKg >0) {
        //说明有值
        NSUInteger standard = roundf(bodyCompositon.bhIdealWeightKg*pow(10, dataModel.weightPoint));
        recordModel.standardWeight = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:standard bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
        //体重控制量
        CGFloat weightControl = kgWeight - bodyCompositon.bhIdealWeightKg;
        NSUInteger weightContrlABS = roundf(fabs(weightControl*pow(10, dataModel.weightPoint)));
        NSString *weightContrlStr = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:weightContrlABS bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
        if (weightControl<0) {
            recordModel.weightControl = [NSString stringWithFormat:@"-%@",weightContrlStr];
        }else{
            recordModel.weightControl = weightContrlStr;
        }
        recordModel.fatLevel =  [NSString stringWithFormat:@"%lu",(unsigned long)[ELBodyIndexAlgorithmModel getfatLevelWithweight:kgWeight andStandardWeight:bodyCompositon.bhIdealWeightKg]];
    }else{
        recordModel.standardWeight = @"";
        recordModel.weightControl = @"";
        recordModel.fatLevel = @"";
    }
    //脂肪量
    if (bodyCompositon.bhBodyFatKg>0) {
        NSLog(@"---和泰脂肪量:%f",bodyCompositon.bhBodyFatKg);
        NSUInteger fatMass = roundf(bodyCompositon.bhBodyFatKg*pow(10, dataModel.weightPoint));
        recordModel.fatMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:fatMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMass = @"";
    }
    //去脂体重
    if (bodyCompositon.bhBodyFatFreeMassKg>0) {
        NSUInteger withoutFatW = roundf(bodyCompositon.bhBodyFatFreeMassKg*pow(10, dataModel.weightPoint));
        recordModel.weightWithoutFat = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:withoutFatW bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.weightWithoutFat = @"";
    }
    //肌肉量
    if (bodyCompositon.bhMuscleKg>0) {
        NSLog(@"---和泰脂肪量:%f",bodyCompositon.bhMuscleKg);
        NSInteger musleMass = round(bodyCompositon.bhMuscleKg*pow(10, dataModel.weightPoint));
        recordModel.musleMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:musleMass bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMass = @"";
    }
    //蛋白量
    if (bodyCompositon.bhProteinRate>0) {
        NSUInteger proteinMassInt = roundf((bodyCompositon.bhProteinRate/100.0)*kgWeight* pow(10, dataModel.weightPoint));
        recordModel.proteinMass = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:proteinMassInt bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.proteinMass = @"";
    }
    //体脂-右手
    if (bodyCompositon.bhBodyFatKgRightArm >0) {
        NSUInteger rightHand = roundf(bodyCompositon.bhBodyFatKgRightArm*pow(10, dataModel.weightPoint));
        recordModel.fatMassRightTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassRightTop = @"";
    }
    //体脂-右脚
    if (bodyCompositon.bhBodyFatKgRightLeg >0) {
        NSUInteger rightFoot = roundf(bodyCompositon.bhBodyFatKgRightLeg*pow(10, dataModel.weightPoint));
        recordModel.fatMassRightBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassRightBottom = @"";
    }
    //体脂-左手
    if (bodyCompositon.bhBodyFatKgLeftArm >0) {
        NSUInteger leftHand = roundf(bodyCompositon.bhBodyFatKgLeftArm*pow(10, dataModel.weightPoint));
        recordModel.fatMassLeftTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassLeftTop = @"";
    }
    //体脂-左脚
    if (bodyCompositon.bhBodyFatKgLeftLeg >0) {
        NSUInteger leftFoot = roundf(bodyCompositon.bhBodyFatKgLeftLeg*pow(10, dataModel.weightPoint));
        recordModel.fatMassLeftBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassLeftBottom = @"";
    }
    //体脂-躯干
    if (bodyCompositon.bhBodyFatKgTrunk >0) {
        NSUInteger fatMassBody = roundf(bodyCompositon.bhBodyFatKgTrunk*pow(10, dataModel.weightPoint));
        recordModel.fatMassBody = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:fatMassBody bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.fatMassBody = @"";
    }
    //肌肉-右手
    if (bodyCompositon.bhMuscleKgRightArm >0) {
        NSUInteger rightHand = roundf(bodyCompositon.bhMuscleKgRightArm*pow(10, dataModel.weightPoint));
        recordModel.musleMassRightTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassRightTop = @"";
    }
    //肌肉-右脚
    if (bodyCompositon.bhMuscleKgRightLeg >0) {
        NSUInteger rightFoot = roundf(bodyCompositon.bhMuscleKgRightLeg*pow(10, dataModel.weightPoint));
        recordModel.musleMassRightBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:rightFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassRightBottom = @"";
    }
    //肌肉-左手
    if (bodyCompositon.bhMuscleKgLeftArm >0) {
        NSUInteger leftHand = roundf(bodyCompositon.bhMuscleKgLeftArm*pow(10, dataModel.weightPoint));
        recordModel.musleMassLeftTop = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftHand bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassLeftTop = @"";
    }
    //肌肉-左脚
    if (bodyCompositon.bhMuscleKgLeftLeg >0) {
        NSUInteger leftFoot = roundf(bodyCompositon.bhMuscleKgLeftLeg*pow(10, dataModel.weightPoint));
        recordModel.musleMassLeftBottom = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:leftFoot bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassLeftBottom = @"";
    }
    //肌肉-躯干
    if (bodyCompositon.bhMuscleKgTrunk >0) {
        NSUInteger muscleMassBody = roundf(bodyCompositon.bhMuscleKgTrunk*pow(10, dataModel.weightPoint));
        recordModel.musleMassBody = [ELWeightAlgorithmusModel getWeightShowStrWithTargetUnit:dataModel.weightUnit bleWeightInt:muscleMassBody bleWeightUnit:(ELDeviceWeightUnit_KG) bleWeightPoint:dataModel.weightPoint];
    }else{
        recordModel.musleMassBody = @"";
    }
    //四肢肌肉指数 = 四肢肌肉量(kg)/身高的平方(m)
    CGFloat heightM = (height/100.0);
    CGFloat index = (bodyCompositon.bhMuscleKgLeftArm+bodyCompositon.bhMuscleKgLeftLeg+bodyCompositon.bhMuscleKgRightArm+bodyCompositon.bhMuscleKgRightLeg)/(heightM*heightM);
    recordModel.musleMassLimbs = [NSString stringWithFormat:@"%.1f",index];
    NSLog(@"八电极体脂：\n%@",recordModel);
#endif
    
}

@end
