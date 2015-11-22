//
//  RMRentalAnimationController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/29.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMRentalAnimationController.h"
#import "RMViewController.h"
#import "RMRentalViewController.h"

@interface RMRentalAnimationController()

@end

@implementation RMRentalAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    NSLog(@"reverse");
    UIView *containerView = [transitionContext containerView];
    
    UIImage *fromImage = [UIImage captureScreen];
    UIImageView *fromBlurImageView = (self.isLight) ?
        [[UIImageView alloc] initWithImage:[fromImage applyLightEffect]] :
        [[UIImageView alloc] initWithImage:[fromImage applyDarkEffect]];
    fromBlurImageView.alpha = 0.0f;
    
    toVC.view.alpha = 0.0f;
    
    [containerView addSubview:fromBlurImageView];
    [containerView addSubview:toVC.view];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        fromBlurImageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            toVC.view.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [containerView addSubview:toVC.view];
            [fromVC.view removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }]; 
}

@end
