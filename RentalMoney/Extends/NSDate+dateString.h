//
//  NSDate+dateString.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/02.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (dateString)

+ (NSDate *)dateAfterHour:(NSInteger)hour;
+ (NSString *)timeStringAt:(NSDate *)targetDate;
+ (NSString *)dateStringAt:(NSDate *)targetDate;
+ (NSString *)backDateStringAt:(NSDate *)targetDate;

+ (NSDate *)nextMonday;
+ (NSDate *)nextMonth;
+ (NSDate *)nextDay;

@end
