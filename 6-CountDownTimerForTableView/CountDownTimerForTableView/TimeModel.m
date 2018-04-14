//
//  TimeModel.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

- (instancetype)initWithTitle:(NSString *)title time:(NSInteger)time
{
    if (self = [super init]) {
        self.m_titleStr = title;
        self.m_countNum = time;
    }
    
    return self;
}

+ (instancetype)timeModelWithTitle:(NSString *)title time:(NSInteger)time {
    
    return [[TimeModel alloc] initWithTitle:title time:time];
}

- (void)countDown {
    _m_countNum -= 1;
}

- (NSString *)currentTimeString {
    if (_m_countNum <= 0) {
        return @"00:00:00";
    } else {
        NSString *ctStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",_m_countNum/3600,_m_countNum%3600/60,_m_countNum%60];
        return ctStr;
    }
}
@end
