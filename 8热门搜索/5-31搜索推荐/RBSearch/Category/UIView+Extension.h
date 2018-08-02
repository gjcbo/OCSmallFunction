//
//  UIView+Extension.h
//  Budejie
//
//  Created by 华杨科技 on 2017/9/19.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 宽度
 */
@property (nonatomic, assign) CGFloat rb_width;

/**
 高度
 */
@property (nonatomic, assign) CGFloat rb_height;

/**
 x轴坐标
 */
@property (nonatomic, assign) CGFloat rb_x;

/**
 y轴坐标
 */
@property (nonatomic, assign) CGFloat rb_y;

/**
 中心点x轴坐标
 */
@property (nonatomic, assign) CGFloat rb_center_x;

/**
 中心点y轴坐标
 */
@property (nonatomic, assign) CGFloat rb_center_y;

/**
 右边的位置
 */
@property (nonatomic, assign) CGFloat rb_right;

/**
 底部的位置
 */
@property (nonatomic, assign) CGFloat rb_bottom;


@end
