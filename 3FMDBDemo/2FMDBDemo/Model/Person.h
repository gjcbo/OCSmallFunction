//
//  Person.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/**ID*/
@property(nonatomic, strong) NSNumber *ID;
/**姓名*/
@property(nonatomic, copy) NSString *name;
/**年龄*/
@property(nonatomic, assign) NSInteger age;
/**编号*/
@property(nonatomic, assign) NSInteger number;

/**一个人可以有多辆车*/
@property(nonatomic, strong) NSMutableArray *carArray;
@end
