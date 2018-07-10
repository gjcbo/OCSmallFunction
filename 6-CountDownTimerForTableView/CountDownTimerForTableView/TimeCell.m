//
//  TimeCell.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "TimeCell.h"
#import "CommonMacro.h"

@interface TimeCell()
/**背景view*/
@property(nonatomic, strong) UIView *m_backgroundView;
/**标题lb*/
@property(nonatomic, strong) UILabel *m_titleLabel;
/**时间lb*/
@property(nonatomic, strong) UILabel *m_timeLabel;

/**1.临时存一下 外面传进来的model*/
@property(nonatomic, strong) id m_data;

/**.2.临时存一下 外面传进来的 indexPath*/
@property(nonatomic, strong) NSIndexPath *m_indexPath;

@end

@implementation TimeCell

#pragma mark - 一 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self defaultConfig];
        
        [self buildViews];
    }
    return self;
}


- (void)defaultConfig {
    [self registerNotificationCenter]; // 注册通知
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor grayColor];
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

#pragma mark - 二 赋值
- (void)configureTimeCellWithModel:(TimeModel *)model indexPath:(NSIndexPath *)indexPath {
    //备个份
    self.m_data = model;
    self.m_indexPath = indexPath;
    
    _m_titleLabel.text = model.m_titleStr;
    _m_timeLabel.text = [NSString stringWithFormat:@"%@",[model currentTimeString]];
}

#pragma mark - 三 通知中心
- (void)registerNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent:) name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)removeNotificationCenter {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TIME_CELL object:nil];
}

- (void)notificationCenterEvent:(NSNotification *)notif {
    //不停的给cell赋值。每过1秒计时器时间-1
    [self configureTimeCellWithModel:self.m_data indexPath:self.m_indexPath];
}

#pragma mark -  五 生命周期
- (void)dealloc {
    
    NSLog(@"TimeCell 被销毁");
    [self removeNotificationCenter];
}
@end
