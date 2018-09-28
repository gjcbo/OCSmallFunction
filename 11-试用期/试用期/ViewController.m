//
//  ViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ViewController.h"
#import "ReleaseProductController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
//    [self testVerticalUISlider];
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
    
    ReleaseProductController *releaseVC = [[ReleaseProductController alloc] init];
    
    [self.navigationController pushViewController:releaseVC animated:YES];
}
@end
