//
//  UILabel+WZAdd.m
//  常用UI控件封装
//
//  Created by iot_iMac on 2018/6/21.
//  Copyright © 2018年 iot_iMac. All rights reserved.
//

#import "UILabel+WZAdd.h"

@implementation UILabel (WZAdd)

+ (UILabel *)createWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font align:(NSTextAlignment)align {
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.textAlignment = align;

    if (text) {
        lbl.text = text;
    }

    if (textColor) {
        lbl.textColor = textColor;
    }

    if (bgColor) {
        lbl.backgroundColor = bgColor;
    }
    
    if (font) {
        lbl.font = font;
    }

    return lbl;
}

@end
