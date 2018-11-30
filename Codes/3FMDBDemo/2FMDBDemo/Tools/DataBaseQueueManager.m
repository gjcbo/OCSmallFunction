//
//  DataBaseQueueManager.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "DataBaseQueueManager.h"
#import <FMDB.h>
#define kDataBase2 @"DB2.sqlite"
#define kBookTable  @"bookTable"

@interface DataBaseQueueManager()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation DataBaseQueueManager

+ (instancetype)shareDataBaseQueueManager {
    static DataBaseQueueManager *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[DataBaseQueueManager alloc] init];
        
        
    });
    return manger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [dir stringByAppendingPathComponent:kDataBase2];
        
        //创建dataBaseQueue 对象 并创建数据库
        self.dbQueue = [[FMDatabaseQueue alloc] initWithPath:path];
        
        //创建表
        [self createBookTable];
    }
    return self;
}


- (void)createBookTable {
//    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('bookId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' TEXT , 'author' TEXT)", kBookTable];
    
//    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID TEXT, name TEXT, author TEXT)" ,kBookTable];

    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (bookId TEXT, name TEXT , author TEXT)", kBookTable];

    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sqlStr]) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }];
}

#pragma mark - 接口
- (void)addBook:(BookModel *)model {
   
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (bookId, name, author) values(?,?,?)",kBookTable];
    
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {

        BOOL isSuccess = [db executeUpdate:sqlStr,model.bookId,model.name,model.author];
        if (isSuccess) {
            NSLog(@"插入成功");
        }else {
            NSLog(@"插入失败");
        }
    }];
}

- (void)deleteBook:(BookModel *)model {
    NSString *deleteSqlStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE ID = %@",kBookTable, model.bookId];
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL isDeleteSuccess = [db executeUpdate:deleteSqlStr];
        if (isDeleteSuccess) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }];
}

- (NSMutableArray *)queryAllBook {
    
    
    NSMutableArray *resultArrM = [NSMutableArray array];
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@",kBookTable];
        
        FMResultSet *res =  [db executeQuery:sqlStr];
        
        while ([res next]) {
            
            BookModel *model = [[BookModel alloc] init];
            model.bookId = [res stringForColumn:@"ID"];
            model.name = [res stringForColumn:@"name"];
            model.author = [res stringForColumn:@"author"];
            
            [resultArrM addObject:model];
        }
    }];
    
    return resultArrM;
}

@end
