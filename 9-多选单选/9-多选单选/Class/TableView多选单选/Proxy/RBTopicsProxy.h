//
//  RBTopicsProxy.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

//通过block将相关点击事件参数传递出去(indexPath, isSelected)
typedef void(^RBTopicsProxyDidSelectCellBlock)(NSIndexPath *indexPath , BOOL isSelected);

@interface RBTopicsProxy : NSObject <UITableViewDelegate,UITableViewDataSource>

/**1.数据源:外界传进来的数组,用于显示界面*/
@property(nonatomic, strong) NSMutableArray *topicsArr;

/**2.在控制器中赋值 , 控制cell的编辑状态*/
@property(nonatomic, assign) BOOL isEditing;

/**3.block回调*/
@property (nonatomic, copy) RBTopicsProxyDidSelectCellBlock topicsProxyDidSelectCellBlock;


@end
