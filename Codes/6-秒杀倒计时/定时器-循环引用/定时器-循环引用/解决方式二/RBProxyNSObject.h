//
//  RBProxyNSObject.h
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBProxyNSObject : NSObject
+ (instancetype)proxyWithTarget:(id)target;

/**弱引用 目标对象以解决循环引用问题*/
@property (nonatomic, weak) id target;

@end
