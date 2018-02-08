//
//  UIColor+Hex.h
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 将16进制颜色转为RGBcolor

 @param hexValue 十六进制颜色
 @return RGBColor
 */
+ (instancetype)rb_convertToRGBColorWithHexValue:(uint32_t)hexValue;

@end
