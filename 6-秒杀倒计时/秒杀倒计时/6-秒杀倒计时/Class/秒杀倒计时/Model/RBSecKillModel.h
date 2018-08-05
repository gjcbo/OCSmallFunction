//
//  RBSecKillModel.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBSecKillModel : NSObject
/**1.图片*/
@property (nonatomic, copy) NSString *cover;
/**2.名字*/
@property (nonatomic, copy) NSString *name;
/**3..原价*/
@property (nonatomic, copy) NSString *market_price;
/**4.折扣价*/
@property (nonatomic, copy) NSString *price;
/**5.结束时间，时间戳*/
@property (nonatomic, strong) NSNumber *end_time;


//让时间自减
- (void)seckillCountDownTime;
/**将时间转换为字符串并返回*/
- (NSString  *)seckillCurrentTimeString;
@end

#pragma mark - 备注
/**
 关于时间戳问题:
 
 */

