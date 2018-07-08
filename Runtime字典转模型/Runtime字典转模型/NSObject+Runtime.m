//
//  NSObject+Runtime.m
//  Runtime字典转模型
//
//  Created by RaoBo on 2018/5/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (instancetype)rb_objWithDic:(NSDictionary *)dic {
    
    // 实例化对象
    id object = [[self alloc] init];
    
    // 1>获取对象属性数组
    NSArray *propertyArr = [self rb_objPropeties];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 2>判断数组中是否包含对应的key
        if ([propertyArr containsObject:key]) {
            // 3> kvc设置数值
            [object setValue:obj forKey:key];
        }
    }];
    
    return object;
}

const char *kPropertListKey = "kPropertListKey";
+ (NSArray *)rb_objPropeties {
    
    // ---1.使用`关联对象`动态获取属性 ,如果有值,就直接返回
    /**
     参数:
     1.对象 self
     2.动态属性的 key
     
     返回值:
     id 类型
     这里关联的是一个数组,∴ 用一个数组接收
     */
    NSArray *ptyArr = objc_getAssociatedObject(self, kPropertListKey);
    //这种判断方式有问题:数组元素个数为空你怎么处理。
//    if (ptyArr != nil) {
//        return ptyArr;
//    }

    if (ptyArr.count) {
        return ptyArr;
    }
    
    /**
     运行时获取对象那个属性列表
     参数:
     1.要获取的类
     2.类属性的个数指针
     
     返回值:
     所有属性的`数组` ,C 数组的名字 就是指向第一个元素地址
     
     C语言中看到retain/create/copy 需要release。最要option+click查看。
     */
    unsigned int count = 0;
    objc_property_t *proList =  class_copyPropertyList([self class], &count);
    // 创建数组
    NSMutableArray *arrM = [NSMutableArray array];
    
    // 遍历所有属性
    for (unsigned int i =0 ; i<count; i++) {
        
        // 1.从数组中取得属性
        // OC中调用C的结构体指针,通常不需要 `*`
        objc_property_t pty = proList[i];
        
        // 2.从pty中获取属性的名称
        const char * cName =  property_getName(pty);
        //        NSLog(@"%s",cName);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        [arrM addObject:name];
    }
    
    // 内存:释放属性数组
    free(proList);
    
    
    // -----2 到此为止 属性数组已经获取完毕,使用关联对象动态的添加属性
    /**
     参数:
     1. 对象 self
     2. 动态添加的属性的key , 获取值的时候使用 objc_getAssociatedObject
     3. 动态添加的属性的 值
     4. 关联策略
     */
    objc_setAssociatedObject(self, kPropertListKey, arrM.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return arrM.copy;
}
@end
