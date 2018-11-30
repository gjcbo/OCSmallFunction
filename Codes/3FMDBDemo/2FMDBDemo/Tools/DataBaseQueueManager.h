//
//  DataBaseQueueManager.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookModel.h"

@interface DataBaseQueueManager : NSObject
+ (instancetype)shareDataBaseQueueManager;

/**添加一本书*/
- (void)addBook:(BookModel *)model;

/**删除一本书*/
- (void)deleteBook:(BookModel *)model;

/**查询所有的书*/
- (NSMutableArray *)queryAllBook;



@end
