//
//  RBSecKillModel.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBSecKillModel.h"

@interface RBSecKillModel()
{
    NSInteger _cntNum; //全局变量，记录当前系统时间和结束时间到差。方便自减
}
@end
@implementation RBSecKillModel


#pragma mark - 一 接口
- (void)seckillCountDownTime {
    _cntNum = [self theInteverBetweenCurrentTimeAndEndTime];
    _cntNum --;
}

- (NSString *)seckillCurrentTimeString {
    if (_cntNum <= 0) {
        return @"00:00:00";
    }else {
        NSInteger h = _cntNum/3600;
        NSInteger m = _cntNum%3600/60;
        NSInteger s = _cntNum%60;
        
        NSString *ctStr = [NSString stringWithFormat:@"  %02ld:%02ld:%02ld后结束", h, m, s];
        return ctStr;
    }
}



#pragma mark - 二 Private mehtod

/**结束时间 - 系统时间的时间差*/
- (NSInteger)theInteverBetweenCurrentTimeAndEndTime {
    
    NSInteger c = [self currentTimeStamp];
    
    NSInteger e = [self.end_time integerValue];
    
    //再将时间转换为秒
    return (e-c) / 1000;
}

/**系统当前时间的时间戳*/
- (NSInteger)currentTimeStamp {
    
    NSInteger timeStamp = [[NSDate date] timeIntervalSince1970];
    
    //Java 的 时间戳单位好像是毫秒。这里保持单位一致
    return timeStamp *1000;
}



@end
