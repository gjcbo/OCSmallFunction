//
//  RBProxyNSObject.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBProxyNSObject.h"

@implementation RBProxyNSObject
+ (instancetype)proxyWithTarget:(id)target {
    RBProxyNSObject *proxy = [[RBProxyNSObject alloc] init];
    
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}


@end
