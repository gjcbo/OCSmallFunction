//
//  RBProxy.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBProxy : NSProxy
+ (instancetype)rbProxyWithTarget:(id)target;

@end
