//
//  RMBaseViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMBaseViewController.h"

@interface RMBaseViewController ()

@end

@implementation RMBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = translation;
            break;
        case UIGestureRecognizerStateEnded:
            self.panStartPoint = translation;
            if (self.panStartPoint.x - self.panEndPoint.x  < -60.0f) {
                if ([self respondsToSelector:@selector(toNextPage)]) {
                    [self performSelector:@selector(toNextPage)];
                }
            }   else if (60.0f < self.panStartPoint.x - self.panEndPoint.x) {
                if ([self respondsToSelector:@selector(toPreviousPage)]) {
                    [self performSelector:@selector(toPreviousPage)];
                }
            }
            break;
        default:
            break;
    }
}

- (void)toNextPage
{
    
}

- (void)toPreviousPage
{
    
}

@end