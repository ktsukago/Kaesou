//
//  UIScreen+rect.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/02.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "UIScreen+rect.h"

@implementation UIScreen (rect)

+ (CGFloat)width
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return  screenRect.size.width;
}

+ (CGFloat)height
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return  screenRect.size.height;
}

@end
