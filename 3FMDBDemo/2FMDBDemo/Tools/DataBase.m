//
//  DataBase.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/5.
//  Copyright © 2018年 关键词. All rights reserved.
//
// FMDB的使用demo https://www.jianshu.com/p/54e74ce87404
// iOS SQLite http://blog.csdn.net/tcthek/article/details/42675369
// 遇见你不容易，错过了会很可惜。
#import "DataBase.h"
#import "Person.h"
#import "Car.h"

#import <FMDB.h>

// 数据库名
#define kModelDataBase @"personCar.sqlite"

static DataBase *_dbCtl = nil;

@interface DataBase()
{
    FMDatabase *_db;
}
@end

@implementation DataBase


+ (instancetype)shareDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbCtl = [[DataBase alloc] init];
        
        [_dbCtl initWithDataBase];
    });
    
    return _dbCtl;
}

#pragma mark - 一 数据库相关
- (void)initWithDataBase
{
    // 获取Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:kModelDataBase];
    
    // 实例化FMDatabase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL openResult =  [_db open];
    if (openResult) { // 只有数据库打开成功，在初始化下面语句
        // 初始化数据表
        NSString *personSql = @"CREATE TABLE IF NOT EXISTS 'person' ('person_id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number' VARCHAR(255))";
        
        NSString *carSql = @"CREATE TABLE 'car' ('car_id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'own_id' VARCHAR(255), 'car_brand' VARCHAR(255), 'car_price' VARCHAR(255))";
        
        [_db executeUpdate:personSql];
        [_db executeUpdate:carSql];
    }
    
    // 关闭数据库
    [_db close];
}

#pragma mark - 二 Person
- (void)addPerson:(Person *)person
{
    BOOL openResult = [_db open];
    if (!openResult) { // 打开数据库失败直接返回
        return;
    }
    
    NSNumber *maxId = @(0);
    // 获取数据库中最大的person_id
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    while ([res next]) {
        NSString *nextPersonId = [res stringForColumn:@"person_id"];
        
        if ([maxId integerValue] < [nextPersonId integerValue]) {
            maxId = @([nextPersonId integerValue]);
        }
    }
    maxId = @([maxId integerValue] + 1);
    
    //执行插入语句
    BOOL updateResult = [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)   VALUES(?,?,?,?)",maxId,person.name,@(person.age),@(person.number)];
    
    if (updateResult) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    [_db close];
}

- (void)deletePerson:(Person *)person {
    BOOL openResult = [_db open];
    if (!openResult) {
        return;
    }
    
    // 删除person,删除也使用update
 BOOL deleteRestlt = [_db executeUpdate:@"DELETE FROM person WHERE person_id=?",person.ID];
    
    if (deleteRestlt) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    [_db close];
}

//- (void)updatePerson:(Person *)person{
//    BOOL openResult = [_db open];
//    if (!openResult) {
//        return;
//    }
//
//    [_db executeUpdate:@"UPDATE 'person' SET person_name = ? WHERE person_id = ?",person.name,person.ID];
//    [_db executeUpdate:@"UPDATE 'person' SET person_age WHERE person_id = ?",@(person.age),person.ID];
//    [_db executeUpdate:@"UPDATE 'person' SET person_number WHERE person_id = ?",@(person.number + 1),person.ID];
//
//    [_db close];
//}

- (NSMutableArray *)getAllPerson
{
    [_db open];
    
    // 准备容器
    NSMutableArray *personArr = [NSMutableArray array];
    
    // 查询person表中的所有数据
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    while ([res next]) {
        Person *p = [[Person alloc] init];
        
        p.ID =  @([[res stringForColumn:@"person_id"] integerValue]);
        p.name = [res stringForColumn:@"person_name"];
        p.age = [[res stringForColumn:@"person_age"] intValue];
        p.number = [[res stringForColumn:@"person_number"] integerValue];
        
        [personArr addObject:p];
    }
    
    // 关闭数据库
    [_db close];

    return personArr;
}

#pragma mark - 三 Car
- (void)addCar:(Car *)car toPerson:(Person *)person{
    // 打开数据库
    BOOL isOpen = [_db open];
    if (!isOpen) {
        return;
    }
    
    // 根据Person是否有car来添加car_id
    NSNumber *maxCarID = @(0);
    
    //一 根据person.ID查询这个人所有用的car
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM car WHERE own_id = %@",person.ID];
    
    // 如果该人有car， 在次添加的的carId就从所查询出的最大的carid开始
    while ([res next]) {
        // 从查询结果中获取car_id
        NSString *car_id = [res stringForColumn:@"car_id"];
        
        if ([maxCarID integerValue] < [car_id integerValue]) {
            
            maxCarID = @([car_id integerValue]);
        }
    }
    
    // maxCarID 自增
    maxCarID = @([maxCarID integerValue] +1);
    
    // 二 将车car 添加到 car表中，应为car_own_id和人的person.ID一致所以可以很方便的查询某人的cars
    
    BOOL isInsert = [_db executeUpdate:@"INSERT INTO car(car_id,own_id,car_brand,car_price) VALUES(?,?,?,?)",car.car_id,car.own_id,car.brand,@(car.price)]; // 这里必须是对象类型
    
    if (isInsert) {
        NSLog(@"插入car表中 成功");
    }else{
        NSLog(@"插入car表中 失败");
    }
    
    // 关闭数据库
    [_db close];
}

/**删除某人的某辆车*/
- (void)deleteCar:(Car *)car fromPerson:(Person *)person{
    BOOL isOpen = [_db open];
    if (!isOpen) {
        return;
    }
    
    // 谁的车？哪一辆车？
    BOOL isDelete = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM car WHERE own_id = %@ AND car_id=%@ ",person.ID,car.car_id]];
    
    if (isDelete) {
        NSLog(@"根据car_id删除车成功");
    }else{
        NSLog(@"根据car_id删除车失败");
    }
    
    // 关闭数据库
    [_db close];
}

- (NSMutableArray *)getlAllCarFromPerson:(Person *)person{
    BOOL isOpen = [_db open];
    
    if (!isOpen) {
        NSLog(@"打开数据库失败，返回结果为nil");
        return nil;
    }
    
    // 准备容器装car
    NSMutableArray *carArr = [NSMutableArray array];
    
//    FMResultSet *res = [_db executeQuery:@"SELECT * FROM car WHERE own_id = %@",person.ID]; // 有问题的写法，自己给自己挖坑。

    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car WHERE own_id = %@",person.ID]];

    while ([res next]) {
        Car *car = [[Car alloc] init];
        car.own_id = @([[res stringForColumn:@"own_id"] integerValue]);
        car.car_id = @([[res stringForColumn:@"car_id"] integerValue]);
        car.brand = [res stringForColumn:@"car_brand"];
        car.price = [[res stringForColumn:@"car_price"] integerValue];
        
        [carArr addObject:car];
    }
    
    // 关闭数据
    [_db close];
    
//    NSLog(@"某人的car信息:%@",carArr);
    return carArr;
}

- (void)deleteAllCarFromPerson:(Person *)person
{
    BOOL isOpen = [_db open];
    if (!isOpen) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    NSString *deleteSqlStr = [NSString stringWithFormat:@"DELETE from car WHERE own_id = %@",person.ID];
    
    BOOL isDelete = [_db executeUpdate:deleteSqlStr];
    if (isDelete) {
        NSLog(@"删除该人的所有车成功");
    }else{
        NSLog(@"删除该人的所有车失败");
    }
    
    // 关闭数据库
    [_db close];
}


#pragma mark - 四 基础的SQL语句
// 创建表
/**
 CREATE TABLE IF NOT EXISTS 表名(字段1 约束1 约束2, 字段2 约束1)
 eg:
 NSString *personSql = @"CREATE TABLE IF NOT EXISTS 'person' ('person_id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number' VARCHAR(255))";
 */

// 添加
/**
 INSERT INTO 表名(字段1,字段2,字段3,...) VALUES(字段1值,字段2值,字段3值,...)
 eg:
 BOOL updateResult = [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)   VALUES(?,?,?,?)",maxId,person.name,@(person.age),@(person.number)];
 */

// 删除
/**
 DELETE FROM 表名 WHERE 条件
 eg1:[_db executeUpdate:@"DELETE FROM person WHERE person_id=?",person.ID];
 
 eg2:[_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM car WHERE own_id = %@ AND car_id=%@ ",person.ID,car.car_id]];
 */

// 查询
/**
 SELECT 要查找的字段 FROM 表名 WHERE 条件;
 
 eg: [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car WHERE own_id = %@",person.ID]];
 */





@end
