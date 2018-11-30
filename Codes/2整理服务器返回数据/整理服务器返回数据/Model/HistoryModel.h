//
//  HistoryModel.h
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
/**姓名*/
@property(nonatomic, copy) NSString *username;
/**开锁状态*/
@property(nonatomic, copy) NSString *lockstate;
/**开锁时间*/
@property(nonatomic, copy) NSString *openlock_time;

/**KVC方式转model*/
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)provinceWithDic:(NSDictionary *)dic;


/**runtime方式转model*/
//+ (instancetype)rbModelWithDic:(NSDictionary *)dic;


@end
