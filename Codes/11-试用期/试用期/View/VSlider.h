//
//  VSlider.h
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.

#import <UIKit/UIKit.h>

@interface VSlider : UIView
@property (nonatomic, copy) void(^vSliderBlock)(UISlider *vSlider);
@property (nonatomic, strong) UILabel *vLb; //垂直方向的文字

@end
