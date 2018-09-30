//
//  ThirdViewController.h
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
@property (nonatomic, strong) UIImage *img;

/**9-30 回传添加滤镜后的图片*/
@property (nonatomic, copy) void(^thirdVCFilteredBlock)(UIImage *filteredImg);

@end
