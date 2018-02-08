//
//  NSDate+RBExtension.h
//  KISSLOCK
//
//  Created by RaoBo on 2017/12/12.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RBExtension)
/**返回当前时间*/
+ (NSString *)rb_currentDateStr;
/**将NSDate 转 NSString*/
+ (NSString *)rb_stringFromDate:(NSDate *)date;
/**NSString 转 NSDate*/
+ (NSDate *)rb_dateFromString:(NSString *)str;

/**比较两个日期是否相等*/
+ (BOOL)rb_isEqualDateStr1:(NSString *)dateStr1 dateStr2:(NSString *)dateStr2;

/**比较第一个日期和最后一个日期的大小，date1 > date2 YES ,*/
+ (BOOL)rb_isBigDateStr1:(NSString *)dateStr1 dateStr2:(NSString *)dateStr2;

@end
