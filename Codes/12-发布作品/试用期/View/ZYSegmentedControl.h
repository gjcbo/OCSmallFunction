//
//  ZYSegmentedControl.h
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYSegmentedControl : UISegmentedControl
/**
 创建segment

 @param items item数组
 @param target 目标
 @param sel 方法
 @return 返回一个ZYSegmentedControl 实例
 */
- (instancetype)initWithItems:(NSArray *)items target:(id)target sel:(SEL)sel;


/**
 添加segmentItem
 @param titleArr item数组

 @param index 选中下表,不传默认选中第一个
 */
- (void)insertItemWithTitleArr:(NSArray <NSString *>*)titleArr selectedIndex:(NSInteger)index;
@end
