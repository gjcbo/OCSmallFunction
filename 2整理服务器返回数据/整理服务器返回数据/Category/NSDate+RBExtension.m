//
//  NSDate+RBExtension.m
//  KISSLOCK
//
//  Created by RaoBo on 2017/12/12.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import "NSDate+RBExtension.h"

@implementation NSDate (RBExtension)

#pragma mark - usetInterFace
+ (NSString *)rb_currentDateStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // 手机上显示的是北京时间，模拟器显示的美国时间，被北京时间少8个小时
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zn_CH"];

    NSLog(@"系统时间:%@",nowDate);
    
   return [fmt stringFromDate:nowDate];
}

+ (NSString *)rb_stringFromDate:(NSDate *)date
{
    if (date == nil) {
        return nil;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:date];
}

+ (NSDate *)rb_dateFromString:(NSString *)str
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    return [fmt dateFromString:str];
}

+ (BOOL)rb_isEqualDateStr1:(NSString *)dateStr1 dateStr2:(NSString *)dateStr2
{
    NSDate *date1 = [self rb_dateFromString:dateStr1];
    NSDate *date2 = [self rb_dateFromString:dateStr2];

    if (date1==NULL || date2 == NULL) {
        return NO;
    }
    
    NSDateComponents *component = [self rb_componentFromDate:date1 toDate:date2];
    
    NSLog(@"日期比较对象:%@",component);

    return component.year == 0 &&
    component.month == 0 &&
    component.day == 0 &&
    component.hour == 0 &&
    component.minute == 0;
//    && component.second == 0;
}

+ (BOOL)rb_isBigDateStr1:(NSString *)dateStr1 dateStr2:(NSString *)dateStr2
{
    NSDate *fromDate = [self rb_dateFromString:dateStr1];
    NSDate *toDate = [self rb_dateFromString:dateStr2];
    
   NSDateComponents *component = [self rb_componentFromDate:fromDate toDate:toDate];
    
    return component.year <0  ||
    component.month < 0 ||
    component.day < 0 ||
    component.hour <0 ||
    component.minute < 0 ||
    component.minute <0;
}
#pragma mark - private
+ (NSDateComponents *)rb_componentFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMinute;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *component = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    
    return component;
}


@end
