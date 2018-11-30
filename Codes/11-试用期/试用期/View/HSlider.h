//
//  HSlider.h
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  水平方向的滑块

#import <UIKit/UIKit.h>

@interface HSlider : UIView
@property (nonatomic, copy)void(^hSliderBlock)(UISlider *slider);
@property (nonatomic, strong) UILabel *hLb;//水平方向的lb

@end
