//
//  UIButton+Addition.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/7.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)
+ (instancetype)rb_BtnWithFrame:(CGRect)frame target:(id)target action:(SEL)action  title:(NSString *)title{

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = frame;
    
    // 添加点击事件
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    
    CGFloat randomNum1 = arc4random() % 256 / 255.0;
    CGFloat randomNum2 = arc4random() % 256 / 255.0;
    CGFloat randomNum3 = arc4random() % 256 / 255.0;

    // 设置随机背景色
    btn.backgroundColor = [UIColor colorWithRed:randomNum1 green:randomNum2 blue:randomNum3 alpha:0.7];
    
    return btn;
}
@end
