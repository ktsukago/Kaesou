//
//  RMMoveUpAnimation.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/01.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMMoveUpAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat moveDistance;
@property (nonatomic, assign) BOOL isReverse;

@end
