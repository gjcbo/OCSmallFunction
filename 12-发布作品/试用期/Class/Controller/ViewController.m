//
//  ViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ViewController.h"
#import "ReleaseProductController.h"
#import "SecondViewController.h"
#import "FourViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 300)];
//    [self.view addSubview:textView];
//    textView.font = [UIFont systemFontOfSize:18.0];
//    textView.zw_placeHolder = @"对这个作品有什么想介绍或补充的吗?";
//    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    textView.layer.borderWidth = 1;
//    textView.zw_limitCount = 500;
    NSLog(@"屏幕宽:%f--屏幕高:%f",kScreen_W,kScreen_H);
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(10, 100, 200, 30);
    [btn setImage:[UIImage imageNamed:@"上下.png"] forState:(UIControlStateNormal)];
    
    [self.view addSubview:btn];
}



//垂直slider
- (void)testVerticalUISlider {
    
    //垂直的slider
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 300, 300, 10)];
    slider.thumbTintColor = [UIColor redColor];
    //需求:绕着某一个点进行旋转 , layer层的anchroPoint + postion
    slider.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
    slider.layer.position = CGPointMake(10, 300);
    //旋转方向:?? 绕着(10,300) 这个点向上旋转
    slider.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
    [self.view addSubview:slider];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(10, 300, 300, 10)];
    [self.view addSubview:slider2];
}

- (IBAction)releaseProductAction:(UIButton *)sender {
    NSLog(@"发布产品");
    
//    ReleaseProductController *releaseVC = [[ReleaseProductController alloc] init];
//    [self.navigationController pushViewController:releaseVC animated:YES];
    
    SecondViewController *releaseVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:releaseVC animated:YES];
}

- (IBAction)testAction:(UIButton *)sender {
    NSLog(@"%s--%d",__FUNCTION__,__LINE__);
    
    FourViewController *fourVC = [[FourViewController alloc] init];
    
    [self presentViewController:fourVC animated:YES completion:nil];
}


- (IBAction)testScaleViewAction:(UIButton *)sender {
        ReleaseProductController *releaseVC = [[ReleaseProductController alloc] init];
        [self.navigationController pushViewController:releaseVC animated:YES];
}


@end
