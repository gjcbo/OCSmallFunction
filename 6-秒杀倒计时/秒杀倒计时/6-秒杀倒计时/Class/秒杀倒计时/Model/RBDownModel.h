//
//  RBDownModel.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBDownModel : NSObject
/**标题*/
@property (nonatomic, copy) NSString *titleStr;
/**倒计时 时间*/
@property (nonatomic, assign) NSInteger countNum;

/**指定本初始化方法*/
- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time;
/**便利构造器方法*/
+ (instancetype)rbDownModelWithTitle:(NSString *)title time:(NSInteger)time;


/**时间自减  countNum - 1*/
- (void)countDownTime;

/**将时间转成字符串   */
- (NSString *)currentTimeString;

@end
