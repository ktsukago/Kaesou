//
//  NSDate+dateString.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/02.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "NSDate+dateString.h"

@implementation NSDate (dateString)

+ (NSDate *)dateAfterHour:(NSInteger)hour
{
    return [NSDate dateWithTimeIntervalSinceNow:hour*60*60];
}

+ (NSString *)timeStringAt:(NSDate *)targetDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:targetDate];
}

+ (NSString *)dateStringAt:(NSDate *)targetDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M月d日"];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:targetDate];
    NSInteger weekday = [weekdayComponents weekday];
    NSArray *weekString = @[@"", @"日", @"月", @"火", @"水", @"木", @"金", @"土"];
    NSString *dateString = [NSString stringWithFormat:@"%@ (%@)", [formatter stringFromDate:targetDate], weekString[weekday]];
    
    return dateString;
}

+ (NSString *)backDateStringAt:(NSDate *)targetDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M月d日"];
    
    
    NSString *dateString = [NSString stringWithFormat:@"%@に返す予定", [NSDate dateStringAt:targetDate]];
    
    return dateString;
}

+ (NSDate *)nextDay
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:today];
    
    [nowComponents setDay:[nowComponents day] + 1]; //Monday
    [nowComponents setHour:12]; //8a.m.
    [nowComponents setMinute:0];
    [nowComponents setSecond:0];
    
    NSDate *nextDay = [gregorian dateFromComponents:nowComponents];
    return nextDay;
}

+ (NSDate *)nextMonday
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:today];
    
    [nowComponents setWeekday:2]; //Monday
    [nowComponents setWeek: [nowComponents week] + 1]; //Next week
    [nowComponents setHour:12]; //8a.m.
    [nowComponents setMinute:0];
    [nowComponents setSecond:0];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
    return beginningOfWeek;
}

+ (NSDate *)nextMonth
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:today];
    
    [nowComponents setMonth:[nowComponents month] + 1];
    [nowComponents setHour:12]; //8a.m.
    [nowComponents setMinute:0];
    [nowComponents setSecond:0];
    
    NSDate *nextMonth = [gregorian dateFromComponents:nowComponents];
    return nextMonth;
}

/*
- (void)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMMdd" options:0 locale:[NSLocale currentLocale]];
    dateFormatter.dateFormat = formatString;
    NSLog(@"%@", formatString);
    
    NSDate *date = [NSDate date];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@", formattedDateString);
}
 */


@end
