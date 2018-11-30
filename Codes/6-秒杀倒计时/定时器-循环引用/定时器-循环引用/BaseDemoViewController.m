//
//  BaseDemoViewController.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "BaseDemoViewController.h"

@interface BaseDemoViewController ()

@end

@implementation BaseDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat kw = [UIScreen mainScreen].bounds.size.width;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //提示label
    UILabel *tipsLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, kw-20, 100)];
    tipsLb.numberOfLines = 0;
    tipsLb.text = @"1.点击开启定时器按钮开启定时器\n 2.点击左边上角返回按钮\n 3.查看控制台打印信息：定时器是否停止，控制器是否被销毁。";
    tipsLb.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tipsLb];
    
    
    //开启定时器按钮
    UIButton *startTimerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    startTimerBtn.backgroundColor = [UIColor greenColor];
    [startTimerBtn setTitle:@"开启定时器" forState:(UIControlStateNormal)];
    [startTimerBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [startTimerBtn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    [startTimerBtn addTarget:self action:@selector(timeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    startTimerBtn.frame = CGRectMake(20, 250, kw - 40, 50);
    [self.view addSubview:startTimerBtn];
}

- (void)timeBtnAction:(UIButton *)btn {

    
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
