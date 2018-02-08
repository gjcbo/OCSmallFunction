//
//  ViewController.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/7.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Addition.h"
#import "RBReadPlist.h"
#import "OriginViewController.h"
#import "SortedViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton rb_BtnWithFrame:CGRectMake(30, 100, 150, 50) target:self action:@selector(clickBtnAction1:) title:@"处理前一维数组"];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton rb_BtnWithFrame:CGRectMake(30, 200, 150, 50) target:self action:@selector(clickBtnAction2:) title:@"处理后二维数组"];
    [self.view addSubview:btn2];
}

- (void)clickBtnAction1:(UIButton *)btn1{
    NSLog(@"处理前");
    [RBReadPlist rbReadPlist];
    
    
    OriginViewController *originVC = [[OriginViewController alloc] init];
    
    [self.navigationController pushViewController:originVC animated:YES];
}

- (void)clickBtnAction2:(UIButton *)btn2{
    NSLog(@"处理后");
    
    SortedViewController *sortedVC = [[SortedViewController alloc] init];
    [self.navigationController pushViewController:sortedVC animated:YES];
    
    [self hexzhuahuanDemo];
}

- (void)hexzhuahuanDemo
{
    uint32_t hexValue = 0x3d8dfc;
    
    // 0x3d8dfc
    CGFloat red = (hexValue & 0xFF0000) >> 16;
    CGFloat green = (hexValue & 0xFF0000);
    CGFloat blue = (0x3d0000 & 0xFF0000) >> 16;
    
    NSLog(@"red:%.f",red);
    NSLog(@"green:%.f",green);
    NSLog(@"blue:%.f",blue);

}
@end
