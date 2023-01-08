//
//  BhBodyCompositionEnum.h
//  BH_BIA4Twolegs_IOS_Ver
//
//  Created by 陈挺 on 2020/5/9.
//  Copyright © 2020 BaoLei. All rights reserved.
//

#ifndef BhBodyCompositionEnum_h
#define BhBodyCompositionEnum_h

#import <Foundation/Foundation.h>

/*!
 @enum BHSexType
 @abstract 性别枚举
 @constant FEMALE 男性
 @constant MALE 女性
 */
typedef NS_ENUM(NSInteger, BhSexType){
    BH_SEX_TYPE_FEMALE,
    BH_SEX_TYPE_MALE
};

/*！
 @enum BHPeopleType
 @abstract 人员类型枚举
 @constant BH_PEOPLE_TYPE_NORMAL 普通人
 @constant BH_PEOPLE_TYPE_ATHLETE 运动员
 */
typedef NS_ENUM(NSInteger, BhPeopleType){
    BH_PEOPLE_TYPE_NORMAL,
    BH_PEOPLE_TYPE_ATHLETE
};

/*！
 @enum BHErrorType
 @abstract 算法返回错误类型枚举
 @constant BH_ERROR_TYPE_NONE 无错误,此時可以讀取所有參數結果
 @constant BH_ERROR_TYPE_IMPEDANCE 阻抗有误 200~1200
 @constant BH_ERROR_TYPE_AGE 年龄有误 6  ~ 99
 @constant BH_ERROR_TYPE_HEIGHT 身高有误 90 ~ 220cm
 @constant BH_ERROR_TYPE_WEIGHT 体重有误 10 ~ 200kg
 @constant BH_ERROR_TYPE_SEX 性別有误 0  ~ 1
 @constant BH_ERROR_TYPE_PEOPLE_TYPE 人員有误 0  ~ 1
 */
typedef NS_ENUM(NSInteger, BhErrorType) {
    BH_ERROR_TYPE_NONE = 0x00,
    BH_ERROR_TYPE_AGE = 0x01,
    BH_ERROR_TYPE_HEIGHT = 0x02,
    BH_ERROR_TYPE_WEIGHT = 0x03,
    BH_ERROR_TYPE_SEX = 0x04,
    BH_ERROR_TYPE_PEOPLE_TYPE = 0x05,
    BH_ERROR_TYPE_IMPEDANCE_TWO_LEGS = 0x06,
    BH_ERROR_TYPE_IMPEDANCE_TWO_ARMS = 0x07,
    BH_ERROR_TYPE_IMPEDANCE_LEFT_BODY = 0x08,
    BH_ERROR_TYPE_IMPEDANCE_LEFT_ARM = 0x09,
    BH_ERROR_TYPE_IMPEDANCE_RIGHT_ARM = 0x0A,
    BH_ERROR_TYPE_IMPEDANCE_LEFT_LEG = 0x0B,
    BH_ERROR_TYPE_IMPEDANCE_RIGHT_LEG = 0x0C,
    BH_ERROR_TYPE_IMPEDANCE_TRUNK = 0x0D,
};

/*！
 @enum BHBodyType
 @abstract 身體類型
 @constant BH_BODY_TYPE_THIN            偏瘦型
 @constant BH_BODY_TYPE_THIN_MUSCLE     偏瘦肌肉型
 @constant BH_BODY_TYPE_MUSCULAR        肌肉发达型
 @constant BH_BODY_TYPE_OBESE_FAT       浮肿肥胖型
 @constant BH_BODY_TYPE_FAT_MUSCLE      偏胖肌肉型
 @constant BH_BODY_TYPE_MUSCLE_FAT      肌肉型偏胖
 @constant BH_BODY_TYPE_LACK_EXERCISE   缺乏运动型
 @constant BH_BODY_TYPE_STANDARD        标准型
 @constant BH_BODY_TYPE_STANDARD_MUSCLE 标准肌肉型
 */
typedef NS_ENUM(NSInteger, BhBodyType) {
    BH_BODY_TYPE_THIN = 1,
    BH_BODY_TYPE_THIN_MUSCLE = 2,
    BH_BODY_TYPE_MUSCULAR = 3,
    BH_BODY_TYPE_OBESE_FAT = 4,
    BH_BODY_TYPE_FAT_MUSCLE =5,
    BH_BODY_TYPE_MUSCLE_FAT = 6,
    BH_BODY_TYPE_LACK_EXERCISE =7,
    BH_BODY_TYPE_STANDARD = 8,
    BH_BODY_TYPE_STANDARD_MUSCLE =9
};

#endif /* BhBodyCompositionEnum_h */
