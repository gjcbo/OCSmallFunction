//
//  HistoryModel.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
// KVC防崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    NSLog(@"key:%@",key);
}

/**KVC赋值*/
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)provinceWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}



#pragma mark - 参考资料
//iOS字典转模型的几种常见方式 https://www.jianshu.com/p/531ac1661c90


@end
