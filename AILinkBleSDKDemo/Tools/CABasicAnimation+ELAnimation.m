//
//  CABasicAnimation+ELAnimation.m
//  Elink
//
//  Created by iot_user on 2019/1/23.
//  Copyright © 2019年 iot_iMac. All rights reserved.
//

#import "CABasicAnimation+ELAnimation.h"
#import <UIKit/UIKit.h>

@implementation CABasicAnimation (ELAnimation)
//
+(CABasicAnimation *)scaleShowAnimationWithDuration:(CGFloat)duration{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithInteger:0.0];
    animation.toValue = [NSNumber numberWithInteger:1.0];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)scaleHideAnimationWithDuration:(CGFloat)duration{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithInteger:1.0];
    animation.toValue = [NSNumber numberWithInteger:0.0];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}
+(CABasicAnimation *)positionAnimationWithBeginPoint:(CGPoint)beginPoint withEndPoint:(CGPoint)endPoint{
    CABasicAnimation * position =[CABasicAnimation animationWithKeyPath:@"position"];
    position.fromValue = [NSValue valueWithCGPoint:beginPoint];
    position.toValue = [NSValue valueWithCGPoint:endPoint];
    position.duration = ELAnimationDuration;
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    position.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return position;
}

+(CABasicAnimation *)rotationAnimationWithBeginValue:(CGFloat)beginValue endValue:(CGFloat)endValue{
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    aniamtion.fromValue = [NSNumber numberWithFloat:beginValue];
    aniamtion.toValue = [NSNumber numberWithFloat:endValue];
    aniamtion.duration = ELAnimationDuration;
    aniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    aniamtion.repeatCount = 1;
    aniamtion.fillMode = kCAFillModeForwards;
    aniamtion.removedOnCompletion = NO;
    return aniamtion;
}
+(CABasicAnimation *)alphaAnimation{
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"opacity"];
    aniamtion.fromValue = @1;
    aniamtion.toValue = @0.3;
    aniamtion.duration = ELAnimationDuration;
    aniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    aniamtion.fillMode = kCAFillModeForwards;
    aniamtion.repeatCount = INFINITY;
    aniamtion.removedOnCompletion = YES;
    return aniamtion;
}
+(CABasicAnimation *)heightAnimation{
    CABasicAnimation *aniamtion = [CABasicAnimation animationWithKeyPath:@"scale.y"];
    aniamtion.fromValue = @0;
    aniamtion.toValue = @1;
    aniamtion.duration = ELAnimationDuration;
    aniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    aniamtion.fillMode = kCAFillModeForwards;
    aniamtion.removedOnCompletion = NO;
    return aniamtion;
}
@end
