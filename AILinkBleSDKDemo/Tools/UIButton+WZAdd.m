//
//  UIButton+WZAdd.m
//  常用UI控件封装
//
//  Created by iot_iMac on 2018/6/21.
//  Copyright © 2018年 iot_iMac. All rights reserved.
//

#import "UIButton+WZAdd.h"

@implementation UIButton (WZAdd)


/*
 * 注意：如果needRoundCorner=YES，则必须设置frame的height值，否则无法实现圆角
 */
+ (UIButton *)createWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor font:(UIFont *)font norTitle:(NSString *)norTitle norTitleColor:(UIColor *)norTitleColor norImage:(UIImage *)norImage borderColor:(UIColor *)borderColor needRoundCorner:(BOOL)needRoundCorner target:(id)target action:(SEL)action {
    
    //这3项必须有值
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //以下各项均可为nil
    if (font) {
        btn.titleLabel.font = font;
    }
    
    if (bgColor) {
        [btn setBackgroundColor:bgColor];
    }
    
    if (norTitle) {
        [btn setTitle:norTitle forState:UIControlStateNormal];
    }

    if (norTitleColor) {
        [btn setTitleColor:norTitleColor forState:(UIControlStateNormal)];
    }
    
    if (norImage) {
        [btn setImage:norImage forState:UIControlStateNormal];
    }
    
    if (borderColor) {
        btn.layer.borderColor = borderColor.CGColor;
        btn.layer.borderWidth = 1;
    }
    
    if (needRoundCorner) {
        btn.layer.cornerRadius = btn.bounds.size.height/2;
        btn.layer.masksToBounds = YES; //防止设置了图片，不能显示圆角问题
    }
    
    if (action) { //target可为nil，action不可为nil
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }

    
    return btn;
}

@end
