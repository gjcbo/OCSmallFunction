//
//  RBHotView3.h
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBHotView3 : UIView
@property(nonatomic, strong) NSArray *dataArray;

/**点击tagLb的回调*/
@property (nonatomic, copy) void(^hotView3ClickTagLbBlock)(NSString *str) ;

@end
