//
//  BaseTableViewCell.h
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
/**1.获取tableView 的 cell 的 indexPath*/
@property(nonatomic, strong) NSIndexPath *m_indexPath;
/**2.是否显示*/
@property(nonatomic, assign) BOOL m_isDisplay;


/**
 配置cell 子类可重写
 */
- (void)defaultConfig;


/**
 布局cell子views  子类可重写
 */
- (void)buildViews;


/**
 加载数据 子类可重写

 @param data 数据
 @param indexPath 数据编号
 */
- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath;


@end
