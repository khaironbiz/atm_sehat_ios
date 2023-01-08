//
//  UIButton+WZAdd.h
//  常用UI控件封装
//
//  Created by iot_iMac on 2018/6/21.
//  Copyright © 2018年 iot_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WZAdd)


/*
 * 注意：如果needRoundCorner=YES，则必须设置frame的height值，否则无法实现圆角
 */
+ (UIButton *)createWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor font:(UIFont *)font norTitle:(NSString *)norTitle norTitleColor:(UIColor *)norTitleColor norImage:(UIImage *)norImage borderColor:(UIColor *)borderColor needRoundCorner:(BOOL)needRoundCorner target:(id)target action:(SEL)action;

@end
