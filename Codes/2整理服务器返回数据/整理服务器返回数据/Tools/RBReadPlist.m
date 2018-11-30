//
//  RBReadPlist.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/7.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBReadPlist.h"

@implementation RBReadPlist
+ (NSMutableArray *)rbReadPlist{
    //文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"plist"];

    NSMutableArray *mArr = [NSMutableArray arrayWithContentsOfFile:path];
    
    return mArr;
}
@end
