//
//  MethodViewController2.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "MethodViewController2.h"
#import "RBProxyNSObject.h"

@interface MethodViewController2 ()
@property (nonatomic, strong) NSTimer * timer2;

@end

@implementation MethodViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)timeBtnAction:(UIButton *)btn {
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[RBProxyNSObject proxyWithTarget:self] selector:@selector(timer2Test) userInfo:nil repeats:YES];
    
    
    
    
    
    //会导致循环引用 控制器无法销毁。定时器也无法销毁。
    //    self.timer2 = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timer2Test) userInfo:nil repeats:YES];
    //    //使用timerWithTimeInterval的方式必须将定时器添加到Runloop中，定时器才会工作。
    //    [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSDefaultRunLoopMode];
    
    //会导致循环引用。控制器无法销毁。定时器也会无法销毁。
    //    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer2Test) userInfo:nil repeats:YES];
}



- (void)timer2Test {
    NSLog(@"timer2Test");
}

- (void)dealloc {
    NSLog(@"%s--%d",__func__,__LINE__);
    [self.timer2 invalidate];
    self.timer2 = nil;
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
