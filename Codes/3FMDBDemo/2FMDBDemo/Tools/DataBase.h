//
//  DataBase.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;
@class Car;

@interface DataBase : NSObject
+ (instancetype)shareDataBase;

#pragma mark - Person

/**添加人*/
- (void)addPerson:(Person *)person;
/**删除人*/
- (void)deletePerson:(Person *)person;
/**更新person*/
//- (void)updatePerson:(Person *)person;

/**获取所有数据*/
- (NSMutableArray *)getAllPerson;

#pragma mark - Car
/**给人添加车*/
- (void)addCar:(Car *)car toPerson:(Person *)person;

/**给Person删除车辆*/
- (void)deleteCar:(Car *)car fromPerson:(Person *)person;

/**获取某人的所有车*/
- (NSMutableArray *)getlAllCarFromPerson:(Person *)person;

/**删除某人的所有car*/
- (void)deleteAllCarFromPerson:(Person *)person;




@end
