//
//  RMMoveUpAnimation.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/01.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMMoveUpAnimation.h"

@implementation RMMoveUpAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    
    CGFloat toVCStartOffset = (self.isReverse) ? -screenWidth : screenWidth;
    CGFloat fromVCEndOffset = (self.isReverse) ? screenWidth : -screenWidth;
    
    toVC.view.layer.transform = CATransform3DMakeTranslation(toVCStartOffset, 0.0f, 0.0f);
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.layer.transform = CATransform3DMakeTranslation(fromVCEndOffset, 0.0f, 0.0f);
        toVC.view.layer.transform = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
