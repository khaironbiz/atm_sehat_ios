//
//  UIView+Category.h
//  GoodNutrition
//
//  Created by iot_user on 2018/10/23.
//  Copyright © 2018年 Percyyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;


/**
 给View 添加圆角
 
 @param cornerRadii cornerRadii
 @param corner cornerRadii
 */
-(void)setCornerRadii:(CGSize)cornerRadii withCorner:(UIRectCorner)corner;
//
- (void)setViewLayerCornerRadius:(CGFloat)cornerRadius shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor;
@end

NS_ASSUME_NONNULL_END
