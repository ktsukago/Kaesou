//
//  UIImage+capture.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/01.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (capture)

+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImage *)captureScreen;

@end
