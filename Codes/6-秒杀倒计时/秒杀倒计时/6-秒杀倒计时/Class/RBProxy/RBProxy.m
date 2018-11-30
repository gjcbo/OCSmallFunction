//
//  RBProxy.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//
/**
 NSProxy 专门用来做消息转发的。
 1.唯一一个不继承自NSObject的对象。
 */

#import "RBProxy.h"
@interface RBProxy()
/**弱引用 目标对象。解决定时器循环引用问题。*/
@property (nonatomic, weak) id target;

@end

@implementation RBProxy

+ (instancetype)rbProxyWithTarget:(id)target {
    //创建NSProxy对象,不需要调用init方法，本身也没有这个方法
    RBProxy *proxy = [RBProxy alloc];
    
    proxy.target = target;
    
    return proxy;
}

//NSProxy

#pragma mark - 实现一下方法进行消息转发。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    [invocation invokeWithTarget:self.target];
}


@end
