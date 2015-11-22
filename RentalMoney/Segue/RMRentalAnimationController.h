//
//  RMRentalAnimationController.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/29.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMRentalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isReverse;
@property (nonatomic, assign) BOOL isLight;

@end
