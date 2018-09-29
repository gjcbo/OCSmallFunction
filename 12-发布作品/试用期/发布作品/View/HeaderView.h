//
//  HeaderView.h
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
/**点击图片将 iv回调出去*/
@property(nonatomic, copy) void(^headerViewBlock)(UIImageView *iv);
@end
