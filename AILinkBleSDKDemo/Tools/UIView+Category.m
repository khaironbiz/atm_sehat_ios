//
//  UIView+Category.m
//  GoodNutrition
//
//  Created by iot_user on 2018/10/23.
//  Copyright © 2018年 Percyyang. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame=frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y{
    return  self.frame.origin.y;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{
    return self.frame.size.width;
    
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
    return self.frame.size;
}

- (void)setViewLayerCornerRadius:(CGFloat)cornerRadius shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}

-(void)setCornerRadii:(CGSize)cornerRadii withCorner:(UIRectCorner)corner{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:cornerRadii];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}
@end
