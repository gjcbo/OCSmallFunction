//
//  HSlider.h
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  水平方向的滑块

#import <UIKit/UIKit.h>

@protocol HSliderDelegate <NSObject>
- (void)hSliderDidChangeValue:(CGFloat)value;
@end

@interface HSlider : UIView
@property (nonatomic, copy)void(^hSliderBlock)(UISlider *slider);
@property (nonatomic, strong) UILabel *hLb;//水平方向的lb

//单位和长度拼接出 vLb的值
/**单位*/
@property (nonatomic, copy) NSString *unitStr;
/**长度*/
@property (nonatomic, assign) CGFloat length;

@property (nonatomic, weak) id <HSliderDelegate>delegate;
@end
