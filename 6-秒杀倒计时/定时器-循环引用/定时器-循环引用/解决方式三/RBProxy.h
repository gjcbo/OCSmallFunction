//
//  RBProxy.h
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBProxy : NSProxy
+ (instancetype)rbProxyWithTarget:(id)target;

/**对目标对象使用弱引用，解决循环引用问题*/
@property (nonatomic, weak) id target;

@end
