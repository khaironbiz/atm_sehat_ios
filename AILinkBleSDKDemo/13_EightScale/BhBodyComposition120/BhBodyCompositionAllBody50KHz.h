/*!
 @header BhBodyCompositionAllBody50KHz.h
 @abstract 悠健体成分算法库-应用于单频50KHz八电极体成分分析
 @author 悠健-陈挺
 @copyright Best Health Electronics INC.
 @date 2020/05/09
 */
#ifndef BhBodyCompositionAllBody50KHz_h
#define BhBodyCompositionAllBody50KHz_h

#import <Foundation/Foundation.h>
#include "BhBodyCompositionEnum.h"

#pragma mark - BhBodyCompositionAllBody50KHz
/*!
   @class 人體成分
   @abstract 人体成分类
   @discussion 人体的各项人体成分参数
*/
@interface BhBodyCompositionAllBody50KHz : NSObject
// 输入参数
@property (nonatomic,assign) BhSexType            bhSex;         //!< 性别
@property (nonatomic,assign) BhPeopleType         bhPeopleType;  //!< 人员类型，普通 or 运动员
@property (nonatomic,assign) unsigned int         bhHeightCm;    //!< 身高(cm) 90 ~ 220cm
@property (nonatomic,assign) float                bhWeightKg;    //!< 体重(kg) 10  ~ 200kg
@property (nonatomic,assign) unsigned int         bhAge;         //!< 年龄(岁)  6 ~ 99岁
@property (nonatomic,assign) unsigned long        bhZLeftArmEnCode;    //!< 左手阻抗加密值(下位机上传值) 范围0 ~ 0xFFFFFF
@property (nonatomic,assign) unsigned long        bhZRightArmEnCode;  //!< 右手阻抗加密值(下位机上传值) 范围0 ~ 0xFFFFFF
@property (nonatomic,assign) unsigned long        bhZLeftLegEnCode;    //!< 左脚阻抗加密值(下位机上传值) 范围0 ~ 0xFFFFFF
@property (nonatomic,assign) unsigned long        bhZRightLegEnCode;   //!< 右脚阻抗加密值(下位机上传值) 范围0 ~ 0xFFFFFF
@property (nonatomic,assign) unsigned long        bhZLeftBodyEnCode;   //!< 左侧全身阻抗加密值(下位机上传值) 范围0 ~ 0xFFFFFF
// 输出参数
@property (nonatomic,readonly,copy) NSString        *bhVersionTime;    //!< 版权客户日期版本，比如@BestHealth_xxx_20200428_V1.22";
@property (nonatomic,readonly,assign) float         bhZLeftArmDeCode;    //!< 左手阻抗值(Ω)  200 ~ 1200 for debug 通常不显示
@property (nonatomic,readonly,assign) float         bhZRightArmDeCode;    //!< 右手阻抗值(Ω)  200 ~ 1200 for debug 通常不显示
@property (nonatomic,readonly,assign) float         bhZLeftLegDeCode;    //!< 左脚阻抗值(Ω)  200 ~ 1200 for debug 通常不显示
@property (nonatomic,readonly,assign) float         bhZRightLegDeCode;    //!< 右脚阻抗值(Ω)  200 ~ 1200 for debug 通常不显示
@property (nonatomic,readonly,assign) float         bhZLeftBodyDeCode;    //!< 左侧全身阻抗值(Ω)  200 ~ 1200 for debug 通常不显示

@property (nonatomic,readonly,assign) unsigned int  bhBodyAge;            //!< 身体年龄 6~99
@property (nonatomic,readonly,assign) unsigned int  bhBodyScore;          //!< 身体得分 50~100
@property (nonatomic,readonly,assign) BhBodyType    bhHTBodyType;         //!< 身體類型
@property (nonatomic,readonly,assign) float         bhIdealWeightKg;      //!< 理想体重(kg)

@property (nonatomic,readonly,assign) float         bhBMI;                //!< 人体质量指数 10~90
@property (nonatomic,readonly,assign) int           bhBMILevel;           //!< BMI標準: 當前值 Level(0-瘦 1-标准 2-偏胖 3-肥胖)
@property (nonatomic,readonly,copy) NSDictionary*   bhBMIList;            //!< BMI健康标准字典,"瘦/普通"“普通/偏胖”“偏胖/肥胖”

@property (nonatomic,readonly,assign) unsigned int  bhBMR;                //!< 基础代谢量Kcal/day 500 ~ 5000
@property (nonatomic,readonly,assign) int           bhBMRLevel;           //!< 基础代谢量標準: 當前值 Level(0-偏低 1-达标)
@property (nonatomic,readonly,copy) NSDictionary*   bhBMRList;            //!< 基础代谢健康标准字典:"偏低/达标"

@property (nonatomic,readonly,assign) unsigned int  bhVFAL;               //!< 内脏脂肪等级 1 ~ 50
@property (nonatomic,readonly,assign) int           bhVFALLevel;          //!< 内脏脂肪等级標準: 當前值 Level(0-标准 1-警惕 2-危险)
@property (nonatomic,readonly,copy) NSDictionary*   bhVFALList;           //!< 内脏脂肪等级标准字典,"标准/警惕""警惕/危险"

@property (nonatomic,readonly,assign) float         bhBoneKg;             //!< 骨量(kg) 0.5kg ~ 8.0kg
@property (nonatomic,readonly,assign) int           bhBoneKgLevel;        //!< 骨量標準: 當前值 Level(0-不足 1-标准 2-优秀)
@property (nonatomic,readonly,copy) NSDictionary*   bhBoneKgList;         //!< 骨量等级标准字典,"不足/标准"“标准/优秀”

@property (nonatomic,readonly,assign) float         bhBodyFatRate;        //!< 脂肪率(%) 5.0% ~ 75.0%
@property (nonatomic,readonly,assign) int           bhBodyFatRateLevel;   //!< 脂肪率標準: 當前值 Level(0-偏瘦 1-标准 2-警惕 3-偏胖 4-肥胖)
@property (nonatomic,readonly,copy) NSDictionary*   bhBodyFatRateList;    //!< 脂肪率健康标准字典"瘦/标准－"“标准－/标准＋”“标准＋/偏胖”“偏胖/肥胖”
@property (nonatomic,readonly,assign) float         bhBodyFatKg;          //!< 脂肪量(kg)
@property (nonatomic,readonly,assign) float         bhBodyFatFreeMassKg;  //!< 去脂体重(kg)

@property (nonatomic,readonly,assign) float         bhWaterRate;          //!< 水分率(%) 35.0% ~ 75.0%
@property (nonatomic,readonly,assign) int           bhWaterRateLevel;     //!< 水分率標準: 當前值 Level(0-不足 1-标准 2-优秀)
@property (nonatomic,readonly,copy) NSDictionary*   bhWaterRateList;      //!< 水分率健康标准 "不足/标准"“标准/优秀”

@property (nonatomic,readonly,assign) float         bhMuscleKg;             //!< 肌肉量(kg) 10.0kg ~120.0kg
@property (nonatomic,readonly,assign) int           bhMuscleKgLevel;        //!< 肌肉量標準: 當前值 Level(0-不足 1-标准 2-优秀)
@property (nonatomic,readonly,copy) NSDictionary*   bhMuscleKgList;         //!< 肌肉量健康标准 "不足/标准"“标准/优秀”
@property (nonatomic,readonly,assign) float         bhMuscleRate;           //!< 肌肉率(%)

@property (nonatomic,readonly,assign) float         bhProteinRate;          //!< 蛋白质率(%) 2.0% ~ 30.0%
@property (nonatomic,readonly,assign) int           bhProteinRateLevel;     //!< 蛋白质率標準: 當前值 Level(0-不足 1-标准 2-优秀)
@property (nonatomic,readonly,copy) NSDictionary*   bhProteinRateList;      //!< 蛋白质健康标准 "不足/标准"“标准/优秀”

@property (nonatomic,readonly,assign) float         bhSkeletalMuscleKg;     //!< 骨骼肌量(Kg) 8.0Kg ~ 100.0Kg
@property (nonatomic,readonly,assign) int           bhSkeletalMuscleKgLevel;//!< 骨骼肌量標準: 當前值 Level(0-不足 1-標準 2-優秀)
@property (nonatomic,readonly,copy) NSDictionary*   bhSkeletalMuscleKgList; //!< 骨骼肌量健康标准 "不足/标准"“标准/优秀”

@property (nonatomic,readonly,assign) float         bhBodyFatSubCutRate;    //!< 皮下脂肪率(%) 0.1% ~ 60.0%
@property (nonatomic,readonly,assign) int           bhBodyFatSubCutRateLevel;//!< 皮下脂肪率標準: 當前值 Level(0-低 1-标准 2-高)
@property (nonatomic,readonly,copy) NSDictionary*   bhBodyFatSubCutRateList;//!< 皮下脂肪率健康标准 "不足/标准"“标准/优秀”
@property (nonatomic,readonly,assign) float         bhBodyFatSubCutKg;      //!< 皮下脂肪量(kg)

// 运动消耗
@property(nonatomic,readonly, assign) unsigned int bhWalking;          //!< 步行
@property(nonatomic,readonly, assign) unsigned int bhGolf;             //!< 高爾夫
@property(nonatomic,readonly, assign) unsigned int bhGateBall;         //!< 門球
@property(nonatomic,readonly, assign) unsigned int bhTennis;           //!< 網球
@property(nonatomic,readonly, assign) unsigned int bhBicycle;          //!< 自行車
@property(nonatomic,readonly, assign) unsigned int bhBasketball;       //!< 籃球
@property(nonatomic,readonly, assign) unsigned int bhSquash;           //!< 壁球
@property(nonatomic,readonly, assign) unsigned int bhRacketball;       //!< 彈力球
@property(nonatomic,readonly, assign) unsigned int bhTaekwondo;        //!< 跆拳道
@property(nonatomic,readonly, assign) unsigned int bhOrientalFencing;  //!< 擊劍
@property(nonatomic,readonly, assign) unsigned int bhMountainClimbing; //!< 爬山
@property(nonatomic,readonly, assign) unsigned int bhSwim;             //!< 游泳
@property(nonatomic,readonly, assign) unsigned int bhAerobic;          //!< 有氧操
@property(nonatomic,readonly, assign) unsigned int bhJogging;          //!< 慢跑
@property(nonatomic,readonly, assign) unsigned int bhFootball;         //!< 足球
@property(nonatomic,readonly, assign) unsigned int bhRopeJumping;      //!< 跳繩
@property(nonatomic,readonly, assign) unsigned int bhBadminton;        //!< 羽毛球
@property(nonatomic,readonly, assign) unsigned int bhTableTennis;      //!< 乒乓球


@property (nonatomic,readonly,assign) float   bhMuscleRateTrunk;        //!< 躯干肌肉率(%), 分辨率0.1, 范围5.0% ~ 90.0%
@property (nonatomic,readonly,assign) float   bhMuscleRateLeftLeg;      //!< 左脚肌肉率(%), 分辨率0.1, 范围5.0% ~ 90.0%
@property (nonatomic,readonly,assign) float   bhMuscleRateRightLeg;     //!< 右脚肌肉率(%), 分辨率0.1, 范围5.0% ~ 90.0%
@property (nonatomic,readonly,assign) float   bhMuscleRateLeftArm;      //!< 左手肌肉率(%), 分辨率0.1, 范围5.0% ~ 90.0%
@property (nonatomic,readonly,assign) float   bhMuscleRateRightArm;     //!< 右手肌肉率(%), 分辨率0.1, 范围5.0% ~ 90.0%

@property (nonatomic,readonly,assign) float   bhBodyFatRateTrunk;       //!< 躯干脂肪率(%), 分辨率0.1, 范围5.0% ~ 75.0%
@property (nonatomic,readonly,assign) float   bhBodyFatRateLeftLeg;     //!< 左脚脂肪率(%), 分辨率0.1, 范围5.0% ~ 75.0%
@property (nonatomic,readonly,assign) float   bhBodyFatRateRightLeg;    //!< 右脚脂肪率(%), 分辨率0.1, 范围5.0% ~ 75.0%
@property (nonatomic,readonly,assign) float   bhBodyFatRateLeftArm;     //!< 左手脂肪率(%), 分辨率0.1, 范围5.0% ~ 75.0%
@property (nonatomic,readonly,assign) float   bhBodyFatRateRightArm;    //!< 右手脂肪率(%), 分辨率0.1, 范围5.0% ~ 75.0%

@property (nonatomic,readonly,assign) float   bhMuscleKgTrunk;          //!< 躯干肌肉量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhMuscleKgLeftLeg;        //!< 左脚肌肉量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhMuscleKgRightLeg;       //!< 右脚肌肉量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhMuscleKgLeftArm;        //!< 左手肌肉量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhMuscleKgRightArm;       //!< 右手肌肉量(kg), 分辨率0.1, 范围0.0 ~ 200kg

@property (nonatomic,readonly,assign) float   bhBodyFatKgTrunk;         //!< 躯干脂肪量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhBodyFatKgLeftLeg;       //!< 左脚脂肪量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhBodyFatKgRightLeg;      //!< 右脚脂肪量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhBodyFatKgLeftArm;       //!< 左手脂肪量(kg), 分辨率0.1, 范围0.0 ~ 200kg
@property (nonatomic,readonly,assign) float   bhBodyFatKgRightArm;      //!< 右手脂肪量(kg), 分辨率0.1, 范围0.0 ~ 200kg


- (BhErrorType)getBhBodyCompositionAllBody50KHz;

// 字典使用说明如下:
// 1.以BMI为例
// 小于"瘦/普通"为瘦,小于“普通/偏胖”为普通，小于"偏胖/肥胖"为偏胖，其它肥胖





@end


#endif /* BhBodyCompositionAllBody50KHz_h */
