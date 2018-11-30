//
//  MethodViewController4.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "MethodViewController4.h"

@interface MethodViewController4 ()
@property (nonatomic, strong) NSTimer *timer4;
@end

@implementation MethodViewController4

#pragma mark - 一 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//解决定时器循环引用方式4:
/**
 在控制器将要消失的方法中提前销毁定时器。
 感觉这种方式比较不太好。就想使用block+ __weak 的方式解决定时器循环引用类似。如果没有控制器？没有提供 block的API岂不是要无能为力了。
 使用方式三 ： NSProxy 进行消息转发，具有通用性。 
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer4 invalidate];
    self.timer4 = nil;
}


#pragma mark - 开启定时器。
- (void)timeBtnAction:(UIButton *)btn {
    self.timer4 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer4Test) userInfo:nil repeats:YES];
}

- (void)timer4Test {
    NSLog(@"timer4Test -- %d",__LINE__);
}

- (void)dealloc {
    NSLog(@"%s---%d",__func__,__LINE__);
    
    //本例中这两行代码其实是没用了。
//    [self.timer4 invalidate];
//    self.timer4 = nil;
}



@end
