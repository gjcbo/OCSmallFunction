//
//  TimeCell.h
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "TimeCell.h"
#import "TimeModel.h"

#define TIME_CELL               @"TimeCell"
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface TimeCell : UITableViewCell
/**2.是否显示*/
@property(nonatomic, assign) BOOL m_isDisplay;

/**给cell赋值*/
- (void)configureTimeCellWithModel:(TimeModel *)model indexPath:(NSIndexPath *)indexPath;

@end
