//
//  UIButton+Extension.m
//  CustomBtn
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)leftTextRightImageWithMargin:(NSInteger)margin {
    CGFloat imageW = self.imageView.bounds.size.width;
    CGFloat labelW = self.titleLabel.bounds.size.width;
    
    //声明全局的 UIEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //修改间距
    imageEdgeInsets = UIEdgeInsetsMake(0,labelW + margin*0.5 , 0, -labelW-margin*0.5);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageW - margin*0.5, 0, imageW + margin * 0.5);
    
    //重新赋值
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = labelEdgeInsets;
}

- (void)buttonWithTextImg {
    
    CGFloat margin = 15; //间距
    
    
    CGFloat imageW = self.imageView.bounds.size.width;
 
    CGFloat labelW = self.titleLabel.bounds.size.width;
 
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    imageEdgeInsets = UIEdgeInsetsMake(0, labelW + margin*0.5, 0, -labelW - margin*0.5);
    labelEdgeInsets = UIEdgeInsetsMake(0, -imageW - margin*0.5, 0, imageW + margin * 0.5);
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;

    
    
    
//case ImgTextBtnStyleRight:
//    {
//        imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+margin/2.0, 0, -labelWidth-margin/2.0);
//        labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-margin/2.0, 0, imageWith+margin/2.0);
//    }
    
}
@end
