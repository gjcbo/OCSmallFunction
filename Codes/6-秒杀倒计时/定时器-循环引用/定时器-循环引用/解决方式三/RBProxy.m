//
//  RBProxy.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//
/**
 NSProxy、
 @interface NSProxy <NSObject> {
 Class isa;
 }
 
 @interface NSObject <NSObject> {
 Class isa ;
 }
 
 1.都是基类。(后面都么有 :   ,比如： Person : NSObject， 表示Person对象继承 NSObject对象)
 2.NSProxy是一个特殊的类，唯一一个不继承自NSObject的对象
 3.专门用来做消息转发的，效率高,直接进入  --->消息转发
 相对创建一个继承自 NSObject的 RBProxyNSObject对象先走消息发送-->动态方法解析--->消息转发。
 
 如果不实现消息转发方法，崩溃信息如下。
 -[NSProxy methodSignatureForSelector:]

 4.创建NSProxy的实例对象时,不需要 调用init方法。本来也没有。
 */


#import "RBProxy.h"

//NSProxy
@implementation RBProxy

+ (instancetype)rbProxyWithTarget:(id)target {
    
//    NSProxy 创建NSProxy对象,不需要使用 init方法。它本身也是也没有。
    RBProxy *proxy = [RBProxy alloc];
    
    proxy.target = target;
    return proxy;
}

#pragma mark - 实现如下方法：进行消息转发。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
