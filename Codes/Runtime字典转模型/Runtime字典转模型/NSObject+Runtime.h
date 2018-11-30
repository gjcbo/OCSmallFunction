//
//  NSObject+Runtime.h
//  Runtime字典转模型
//
//  Created by RaoBo on 2018/5/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)


/**
 传入一个字典 ,创建一个self对应的对象

 @param dic 字典
 @return 对象
 */
+ (instancetype)rb_objWithDic:(NSDictionary *)dic;

/**
 获取对象的属性数组

 @return 数组
 */
+ (NSArray *)rb_objPropeties;

@end
