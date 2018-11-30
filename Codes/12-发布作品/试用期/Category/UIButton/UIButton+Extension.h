//
//  UIButton+Extension.h
//  CustomBtn
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  修改UIButton 文字、图片的位置 https://blog.csdn.net/www9500net_/article/details/53067816

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
/**左边文字，右边图片 ，margin:间距
 备注: 按钮文字发生变化时，请手动调用此方法，否者会导致文字和图片挤在一起的bug
 */
- (void)leftTextRightImageWithMargin:(NSInteger)margin;

- (void)buttonWithTextImg;
@end
