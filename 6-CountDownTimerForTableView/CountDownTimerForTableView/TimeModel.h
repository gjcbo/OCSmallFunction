//
//  TimeModel.h
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject
/**标题字符串*/
@property(nonatomic, copy) NSString *m_titleStr;
/**倒计时 时间*/
@property(nonatomic, assign) NSInteger m_countNum;


/**指定初始化方法*/
- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time;

/**
 便利构造器

 @param title 标题
 @param time 倒计时时间
 @return 实例对象
 */
+ (instancetype)timeModelWithTitle:(NSString *)title time:(NSInteger)time;

/**
 计数减一(countdownTime - 1)
 */
- (void)countDown;

/**
 将当前的countdownTime信息转换成字符串
 */
- (NSString *)currentTimeString;
@end
