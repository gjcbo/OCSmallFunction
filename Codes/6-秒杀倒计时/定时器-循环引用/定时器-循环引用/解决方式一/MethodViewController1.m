//
//  MethodViewController1.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "MethodViewController1.h"

@interface MethodViewController1 ()
@property (nonatomic, strong) NSTimer *timer1;

@end

@implementation MethodViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)timeBtnAction:(UIButton *)btn {
    //    NSTimer的循环引用问题:
    //    第一种方式：使用 __weak 修饰。如果block内部是通过weak弱引用的方式访问，对外部的变量就会进行弱引用。如果是__strong 强引用修饰，对外面的对象。就会进行强引用
    __weak typeof(self) weakSelf = self;
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [weakSelf timerTest];
    }];
}

- (void)timerTest {
    NSLog(@"%s",__func__);
}

- (void)dealloc {
    NSLog(@"%s--%d",__func__,__LINE__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
