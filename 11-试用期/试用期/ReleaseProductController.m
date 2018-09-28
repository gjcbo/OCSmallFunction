//
//  ReleaseProductController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ReleaseProductController.h"

@interface ReleaseProductController ()
@property (nonatomic, strong) UIView *rectView;
@end

@implementation ReleaseProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布产品";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testScaleBrownView];
}
//测试缩放view
- (void)testScaleBrownView {
    
    //创建一个棕色的矩形
    self.rectView.frame = CGRectMake(50, 190, 100, 100);
    [self.view addSubview:self.rectView];
    
    //垂直滑块
    UISlider *verticalSlide = [[UISlider alloc] initWithFrame:CGRectMake(10, 300, 200, 10)];
    //绕着某一个点旋转:锚点 操作layer层属性
    verticalSlide.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
    verticalSlide.layer.position = CGPointMake(10, 300);
    //旋转:??顺时针/逆时针
    verticalSlide.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
    [verticalSlide addTarget:self action:@selector(verticalSliderAction:) forControlEvents:(UIControlEventValueChanged)];
    verticalSlide.value = 0.001;
    [self.view addSubview:verticalSlide];
    
    //水平滑块
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 310, 200, 10)];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:(UIControlEventValueChanged)];
    slider.value = 0.001;
    [self.view addSubview:slider];
}

#pragma mark - 缩放view
//高度
- (void)verticalSliderAction:(UISlider *)slider {
    CGFloat tempH = self.rectView.frame.size.height;
    CGRect tempFrame = self.rectView.frame;
    CGFloat scale = slider.value;
    
    if (scale < 0.1) {
        scale = 0.1;
    }
    if (tempH < 10) {
        tempH = 10;
    }else {
        tempH = 100;
    }
    
    NSLog(@"h:%f----系数:%f",tempH, scale);
    CGFloat h = tempH * scale;
    
    tempFrame.size.height = h;
    self.rectView.frame = tempFrame;
}


//宽度
- (void)sliderAction:(UISlider *)slider {
    CGFloat tempW = self.rectView.frame.size.width;
    CGRect tempFrame = self.rectView.frame;
    CGFloat scale = slider.value;
    
    //处理边界情况
    if (scale < 0.1) {
        scale = 0.1;
    }
    if (tempW < 10) {
        tempW = 10;
    }else {
        tempW = 100;
    }
    
    NSLog(@"h:%f----系数:%f",tempW, scale);
    CGFloat w = tempW * scale;
    tempFrame.size.width = w;
    self.rectView.frame =tempFrame;
}


#pragma mark - lazy
- (UIView *)rectView {
    if (!_rectView) {
        _rectView = [[UIView alloc] init];
        _rectView.backgroundColor = [UIColor brownColor];
        _rectView.layer.masksToBounds = YES;
        _rectView.layer.cornerRadius = 10;
        _rectView.layer.borderColor = [UIColor blackColor].CGColor;
        _rectView.layer.borderWidth = 1.0;
    }
    return _rectView;
}
@end
