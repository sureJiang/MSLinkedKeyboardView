
//
//  UIView+SpringAnimation.m
//  DEMo
//
//  Created by 姜自佳 on 2017/5/13.
//  Copyright © 2017年 JZJ. All rights reserved.
//

#import "UIView+SpringAnimation.h"

@implementation UIView (SpringAnimation)

- (void)spingAnimation{
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction|UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.10 animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1  relativeDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2  relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    } completion:nil];
}
@end
