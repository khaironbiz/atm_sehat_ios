//
//  CABasicAnimation+ELAnimation.h
//  Elink
//
//  Created by iot_user on 2019/1/23.
//  Copyright © 2019年 iot_iMac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#define ELAnimationDuration   0.2
NS_ASSUME_NONNULL_BEGIN

@interface CABasicAnimation (ELAnimation)
//缩放动画show
+(CABasicAnimation *)scaleShowAnimationWithDuration:(CGFloat)duration;
//缩放动画hide
+(CABasicAnimation *)scaleHideAnimationWithDuration:(CGFloat)duration;
//平移动画
+(CABasicAnimation *)positionAnimationWithBeginPoint:(CGPoint)beginPoint withEndPoint:(CGPoint)endPoint;
//旋转旋转动画
+(CABasicAnimation *)rotationAnimationWithBeginValue:(CGFloat)beginValue endValue:(CGFloat)endValue;

+(CABasicAnimation *)alphaAnimation;

+(CABasicAnimation *)heightAnimation;
@end

NS_ASSUME_NONNULL_END
