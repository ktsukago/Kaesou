//
//  RMMoveUpSegue.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/01.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMMoveUpSegue.h"
#import "RMMoveUpAnimation.h"

@interface RMMoveUpSegue() <UIViewControllerTransitioningDelegate>

@end

@implementation RMMoveUpSegue

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
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 600.0f;
    animation.isReverse = YES;
    return animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 600.0f;
    animation.isReverse = NO;
    return animation;
}


@end
