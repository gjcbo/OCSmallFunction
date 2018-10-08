//
//  ByMuJuView.h
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  按模具
// iOS 的 事件机制

#import <UIKit/UIKit.h>

@interface ByMuJuView : UIView
/**1、点击方形模具*/
@property (nonatomic, copy) void(^byMuJuViewClickRectBlock)(void);
/**2、点击圆形模具*/
@property (nonatomic, copy) void(^byMuJuViewClickCircleBlock)(void);
/**3、点击空心圆模具*/
@property (nonatomic, copy) void(^byMuJuViewClickHollowCircleBlock)(void);
@end
