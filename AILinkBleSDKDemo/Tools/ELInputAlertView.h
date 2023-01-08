//
//  ELInputAlertView.h
//  自定义tabbar
//
//  Created by iot_user on 2019/1/19.
//  Copyright © 2019年 IOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELInputAlertView : UIView

@property (nonatomic, strong) UIColor *topBtnBackColor;


//自动隐藏
@property (nonatomic, assign) BOOL leftAutoHide;//default:YES
@property (nonatomic, assign) BOOL rightAutoHide;//default:NO
@property (nonatomic, assign) BOOL first;//

//
@property (nonatomic, copy) void(^leftBlock)(NSString * text);
@property (nonatomic, copy) void(^rightBlock)(NSString * text);

@property (nonatomic, copy) BOOL(^leftHideBlock)(NSString * text, UIView *view);
@property (nonatomic, copy) BOOL(^rightHideBlock)(NSString * text, UIView *view);

-(instancetype)initWithTittle:(NSString *)title withText:(NSString *)text withMessage:(NSString *)placeholder withLeftButton:(NSString *)leftTitle withRightButton:(NSString *)rightTitle;

-(void)show;

@end

NS_ASSUME_NONNULL_END
