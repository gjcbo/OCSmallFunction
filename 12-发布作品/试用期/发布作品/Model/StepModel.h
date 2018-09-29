//
//  StepModel.h
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepModel : NSObject
@property (nonatomic, copy) NSString *name; //步骤1、2、3 ......
@property (nonatomic, copy) NSString *imgUrl; //图片、图片url。
@property (nonatomic, copy) NSString *desc; //步骤的描述

@end
