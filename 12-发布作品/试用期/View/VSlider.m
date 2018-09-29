//
//  VSlider.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  水平方向的滑块

#import "VSlider.h"
@interface VSlider ()
@property (nonatomic, strong) UISlider *vSlider;//水平方向的文字
@end

@implementation VSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
    }
    return self;
}

#pragma mark - 添加view
- (void)setupView {
//    NSLog(@"%@",NSStringFromCGRect(self.frame));

    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    //添加到视图上
    self.vLb.frame = CGRectMake(0, 0, w, 30);
    [self addSubview:self.vLb];
    
    //滑块垂直
    self.vSlider.frame = CGRectMake(10, h-10, h-10-30, 10);
    self.vSlider.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
    self.vSlider.layer.position = CGPointMake(10, h-10);
    self.vSlider.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
    
    [self addSubview:self.vSlider];
}

#pragma mark - getter
- (UILabel *)vLb {
    if (!_vLb) {
        _vLb = [[UILabel alloc] init];
        _vLb.backgroundColor = [UIColor lightGrayColor];
        _vLb.text = @"50厘米";
        _vLb.font = [UIFont systemFontOfSize:12.0];
    }
    return _vLb;
}
- (UISlider *)vSlider {
    if (!_vSlider) {
        _vSlider = [[UISlider alloc] init];
        [_vSlider addTarget:self action:@selector(vSliderAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _vSlider;
}

- (void)vSliderAction:(UISlider *)slider {
    if (self.vSliderBlock) {
        self.vSliderBlock(slider);
    }
}

@end
