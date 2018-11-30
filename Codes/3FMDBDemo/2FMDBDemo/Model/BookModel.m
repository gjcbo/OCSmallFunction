//
//  BookModel.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

- (instancetype)initWithName:(NSString *)name bookId:(NSString *)bookId author:(NSString *)author {
    if (self = [super init]) {
        self.name = name;
        self.bookId = bookId;
        self.author = author;
    }
    return self;
}

+ (instancetype)bookModelWithName:(NSString *)name bookId:(NSString *)bookId author:(NSString *)author {
    return [[BookModel alloc] initWithName:name bookId:bookId author:author];
}


@end
