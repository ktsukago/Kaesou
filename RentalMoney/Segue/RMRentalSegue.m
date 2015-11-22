//
//  RMRentalSegue.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/29.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMRentalSegue.h"
#import "RMRentalAnimationController.h"

@interface RMRentalSegue() <UIViewControllerTransitioningDelegate>

@end

@implementation RMRentalSegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    return [super initWithIdentifier:identifier source:source destination:destination];
}


- (void)perform {
    UIViewController *sourceViewController = (UIViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *)self.destinationViewController;
    
    destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    destinationViewController.transitioningDelegate = self;
    [sourceViewController presentViewController:destinationViewController animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    RMRentalAnimationController *animation = [[RMRentalAnimationController alloc] init];
    animation.isReverse = YES;
    animation.isLight = YES;
    return animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    RMRentalAnimationController *animation = [[RMRentalAnimationController alloc] init];
    animation.isReverse = NO;
    animation.isLight = YES;
    return animation;
}

@end
