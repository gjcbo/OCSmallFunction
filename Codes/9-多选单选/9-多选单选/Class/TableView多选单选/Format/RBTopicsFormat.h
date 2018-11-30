//
//  RBTopicsFormat.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RBTopicsFormatDelegate <NSObject>

@required
/**1.成功请求到数据的回调*/
- (void)requestTopicsDataSuccessWithArray:(NSArray *)array;

/**2.需要刷新的时候的回调*/
- (void)topicsFormatReloadDataWhenNeed;

@optional
/**3.批量删除的回调*/
- (void)topicsFormatWillDeleteSelectedArr:(NSArray *)array;

/**4.判断是否处于全选状态。*/
- (void)topicsIsAllSelected:(BOOL)isAll;
@end

@interface RBTopicsFormat : NSObject

/**RBTopicsFormatDelegate*/
@property (nonatomic, weak) id <RBTopicsFormatDelegate> delegate;

//发送网络请求
- (void)requestTopicsData;

/**选中、取消选中某个帖子*/
- (void)selectTopicsAtIndexPath:(NSIndexPath *)indexPath state:(BOOL)state;

/**全选、取消全选*/
- (void)selectAllTopicsWithState:(BOOL)state;

/**批量删除*/
- (void)beginDeleteSelectedTpoics;

/**将选中的帖子删除*/
- (void)deleteSelectTopicsWithSelectedArr:(NSArray *)selectedArr;
@end
