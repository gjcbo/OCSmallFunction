//
//  RBDownModel.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBDownModel.h"

@implementation RBDownModel

#pragma mark - 一 初始化

- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time {

    if (self = [super init]) {
        self.titleStr = title;
        self.countNum = time;
    }
    return self;
}

/**便利构造器方法*/
+ (instancetype)rbDownModelWithTitle:(NSString *)title time:(NSInteger)time {
    
    return [[RBDownModel alloc] initWithTitle:title time:time];
}



#pragma mark - 二 其他


- (void)countDownTime {
    _countNum -= 1;
}

- (NSString *)currentTimeString {
    if (_countNum <=0 ) {
        return @"00:00:00";
    }else {
        //时、分、秒
        NSInteger h = _countNum/3600;
        NSInteger m = _countNum%3600/60;
        NSInteger s = _countNum%60;
        NSString *str = [NSString stringWithFormat:@"%02ld:%02ld:%02ld后结束",(long)h,m,s];
        
        return str;
    }
}
@end
