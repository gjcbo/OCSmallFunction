//
//  MethodViewController3.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "MethodViewController3.h"
#import "RBProxy.h"

@interface MethodViewController3 ()
@property (nonatomic, strong) NSTimer *timer3;

@end

@implementation MethodViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[RBProxy rbProxyWithTarget:self] selector:@selector(timer3Test) userInfo:nil repeats:YES];
    
}


- (void)timer3Test {
    NSLog(@"timer3Test==%d",__LINE__);
}

- (void)dealloc {
    NSLog(@"%s==%d",__func__,__LINE__);
    
    [self.timer3 invalidate];
    self.timer3 = nil;
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
