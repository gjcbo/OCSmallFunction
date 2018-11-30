//
//  Person.m
//  Runtime字典转模型
//
//  Created by RaoBo on 2018/5/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "Person.h"
#import "NSObject+Runtime.h"

@implementation Person
- (NSString *)description
{
   NSArray *ptyArr = [Person rb_objPropeties];
    
    //  dictionaryWithValuesForKeys 模型转字典
    return [self dictionaryWithValuesForKeys:ptyArr].description;
}
@end
