//
//  ScaleView.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
// 子控件相对来说有点多. 封装

#import "ScaleView.h"
@interface ScaleView ()
@property (nonatomic, strong) UISlider *vSlider; //垂直滑块
@property (nonatomic, strong) UILabel *vLb; //垂直方向的文字

@property (nonatomic, strong) UISlider *hSlider;//水平滑块
@property (nonatomic, strong) UILabel *hLb; //水平方向的文字

@property (nonatomic, strong) UIView *rectView;

@end

@implementation ScaleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



@end
