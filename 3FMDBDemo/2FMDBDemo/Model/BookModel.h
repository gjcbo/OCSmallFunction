//
//  BookModel.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject
@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *author;

- (instancetype)initWithName:(NSString *)name bookId:(NSString *)bookId author:(NSString *)author;

+ (instancetype)bookModelWithName:(NSString *)name bookId:(NSString *)bookId author:(NSString *)author;

@end
