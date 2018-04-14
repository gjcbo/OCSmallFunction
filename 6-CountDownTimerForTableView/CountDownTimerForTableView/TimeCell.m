//
//  TimeCell.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "TimeCell.h"
#import "TimeModel.h"
#import "CommonMacro.h"

@interface TimeCell()
/**背景view*/
@property(nonatomic, strong) UIView *m_backgroundView;
/**标题lb*/
@property(nonatomic, strong) UILabel *m_titleLabel;
/**时间lb*/
@property(nonatomic, strong) UILabel *m_timeLabel;
/**数据*/
@property(nonatomic, strong) id m_data;
/**下标*/
@property(nonatomic, strong) NSIndexPath *m_tmpIndexPath;

@end

@implementation TimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写父类方法
- (void)defaultConfig {
    [self registerNotificationCenter]; // 注册通知
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor grayColor];
                            
//    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
}

- (void)buildViews {
    // 背景view
    self.m_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 99.5)];
    _m_backgroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_m_backgroundView];
    
    // 标题
    self.m_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, Width-20, 30)];
    self.m_titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20];
    [self.m_backgroundView addSubview:self.m_titleLabel];

    // 倒计时
    self.m_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, Width-20, 40)];
    self.m_timeLabel.textColor = [UIColor redColor];
    self.m_timeLabel.textAlignment = NSTextAlignmentCenter;
    self.m_timeLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:30];
    [self.m_backgroundView addSubview:self.m_timeLabel];
}

- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath
{
    if ([data isMemberOfClass:[TimeModel class]]) {
        [self storeWeakValueWithData:data indexPath:indexPath];
        
        TimeModel *model = (TimeModel *)data;
        
        _m_titleLabel.text = model.m_titleStr;
        _m_timeLabel.text = [NSString stringWithFormat:@"%@",[model currentTimeString]];
    }
}

#pragma mark - 工具方法
// 给data 和 indexPath成员变量赋值
- (void)storeWeakValueWithData:(id)data indexPath:(NSIndexPath *)indexPath {
    self.m_data = data;
    self.m_indexPath = indexPath;
}

- (void)dealloc {
    [self removeNotificationCenter];
}

#pragma mark - 通知中心
- (void)registerNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent:) name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)removeNotificationCenter {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)notificationCenterEvent:(NSNotification *)notif {
    if (self.m_isDisplay) {
        [self loadData:self.m_data indexPath:self.m_indexPath];
    }
}


@end
