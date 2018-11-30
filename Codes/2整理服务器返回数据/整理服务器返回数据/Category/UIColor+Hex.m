//
//  UIColor+Hex.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (instancetype)rb_convertToRGBColorWithHexValue:(uint32_t)hexValue
{
//    0x3d8dfc
    CGFloat red = (hexValue & 0xFF000) >> 16;
    CGFloat green = (hexValue & 0x00FF00) >> 8;
    CGFloat blue = (hexValue & 0x0000FF);
    
    return [UIColor colorWithRed:red / 255.0 green:green /255.0 blue:blue / 255.0 alpha:1.0];
}
@end
