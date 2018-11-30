//
//  Person.h
//  单元测试
//
//  Created by RaoBo on 2018/9/9.
//  Copyright © 2018年 RB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithDic:(NSDictionary *)dic;

/**异步加载person*/
+ (void)loadPersonAsync:(void(^)(Person *person))completion;

@end
