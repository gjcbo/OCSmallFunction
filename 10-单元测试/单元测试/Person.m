//
//  Person.m
//  单元测试
//
//  Created by RaoBo on 2018/9/9.
//  Copyright © 2018年 RB. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithDic:(NSDictionary *)dic {
    //1.为什么用id：使用KVC赋值时不需要考虑类型
    //2.为什么用： self  方便子类继承。
    Person * obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dic];
    
    //单元测试测出来的问题：年龄超限 --->修改内部的代码逻辑：如果年龄超限就 设置为 0 。
    if (obj.age <=0 || obj.age >= 130) {
        obj.age = 0;
    }

    
    return obj;
}

//KVC 防崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


+ (void)loadPersonAsync:(void (^)(Person *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1.0];
        
        Person *person = [Person personWithDic:@{@"name":@"关键词",@"age":@18}];
        
        //主队类回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                completion(person);
            }
        });
    });    
}
@end















