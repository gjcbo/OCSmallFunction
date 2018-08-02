//
//  UIView+Extension.m
//  Budejie
//
//  Created by 华杨科技 on 2017/9/19.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/*
- (CGFloat)rb_width {
    return self.frame.size.width;
}
- (void)setRb_width:(CGFloat)rb_width {
    CGRect frame = self.frame;
    frame.size.width = rb_width;
    self.frame = frame;
}

- (CGFloat)rb_height {
    return self.frame.size.height;
}
- (void)setRb_height:(CGFloat)rb_height {
    CGRect frame = self.frame;
    frame.size.height = rb_height;
    self.frame = frame;
}

- (CGFloat)rb_x {
    return self.frame.origin.x;
}
- (void)setRb_x:(CGFloat)rb_x {
    CGRect frame = self.frame;
    frame.origin.x = rb_x;
    self.frame = frame;
}

- (CGFloat)rb_y {
    return self.frame.origin.y;
}
- (void)setRb_y:(CGFloat)rb_y {
    CGRect frame = self.frame;
    frame.origin.y = rb_y;
    self.frame = frame;
}

- (CGFloat)rb_center_x {
    return self.center.x;
}
- (void)setRb_center_x:(CGFloat)rb_center_x {
    CGPoint center = self.center;
    center.x = rb_center_x;
    self.center = center;
}

- (CGFloat)rb_center_y {
    return self.center.y;
}
- (void)setRb_center_y:(CGFloat)rb_center_y {
    CGPoint center = self.center;
    center.y = rb_center_y;
    self.center = center;
}

- (CGFloat)rb_right {
//    return self.rb_x + self.rb_width;
    return CGRectGetMaxX(self.frame);
}
- (void)setRb_right:(CGFloat)rb_right {
    self.rb_x = rb_right - self.rb_width;
}

- (CGFloat)rb_button {
//    return self.rb_y + self.rb_height;
    return CGRectGetMaxY(self.frame);
}
- (void)setRb_button:(CGFloat)rb_button {
    self.rb_y = rb_button - self.rb_height;
}
*/

- (CGFloat)rb_width 
{
    return self.frame.size.width;
}
- (void)setRb_width:(CGFloat)rb_width
{
    CGRect temFrame = self.frame;
    temFrame.size.width = rb_width;
    self.frame = temFrame;
}

- (CGFloat)rb_height 
{
    return self.frame.size.height;
}
- (void)setRb_height:(CGFloat)rb_height
{
    CGRect temFrame = self.frame;
    temFrame.size.height = rb_height;
    self.frame = temFrame;
}

- (CGFloat)rb_x 
{
    return self.frame.origin.x;
}
- (void)setRb_x:(CGFloat)rb_x 
{
    CGRect temFrame = self.frame;
    temFrame.origin.x = rb_x;
    self.frame = temFrame;
}

- (CGFloat)rb_y
{
    return self.frame.origin.y;
}
- (void)setRb_y:(CGFloat)rb_y
{
    CGRect temFrame = self.frame;
    temFrame.origin.y = rb_y;
    self.frame = temFrame;
}

- (CGFloat)rb_center_x
{
    return self.center.x;
}
- (void)setRb_center_x:(CGFloat)rb_center_x
{
    CGPoint center = self.center;
    center.x = rb_center_x;
    self.center = center;
}

- (CGFloat)rb_center_y
{
    return self.center.y;    
}
- (void)setRb_center_y:(CGFloat)rb_center_y
{
    CGPoint center = self.center;
    center.y = rb_center_y;
    self.center = center;
}


- (CGFloat)rb_right
{
//    return self.rb_x + self.rb_width; // 右边👉，就是x轴的距离
    return CGRectGetMaxX(self.frame);
}
- (void)setRb_right:(CGFloat)rb_right
{
    self.rb_x = rb_right-self.rb_width;    
}

- (CGFloat)rb_bottom
{
//    return self.rb_y + self.rb_height;
    return CGRectGetMaxY(self.frame);
}
- (void)setRb_bottom:(CGFloat)rb_bottom
{
    self.rb_y = rb_bottom - self.rb_height;
}

@end
