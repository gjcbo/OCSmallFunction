//
//  ViewController.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//  tableView cell单元格加载倒计时重用问题解决方法。

#import "ViewController.h"
#import "CommonMacro.h"
#import "TimeCell.h"
#import "TimeModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/**1.tableView*/
@property(nonatomic, strong) UITableView *m_tableView;
/**2.数据源数组*/
@property(nonatomic, copy) NSArray *m_dataArray;
/**3.定时器*/
@property(nonatomic, strong) NSTimer *m_timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.m_dataArray = [self simulateData];
    
    [self initTableView];
    
    [self createTimer];
}

// 获取模拟数据
- (NSArray *)simulateData {
    
    TimeModel *m1 = [TimeModel timeModelWithTitle:@"Aaron" time:31];
    TimeModel *m2 = [TimeModel timeModelWithTitle:@"Nicholas" time:1003];
    TimeModel *m3 = [TimeModel timeModelWithTitle:@"Nathaniel" time:8089];
    TimeModel *m4 = [TimeModel timeModelWithTitle:@"Quentin" time:394];
    TimeModel *m5 = [TimeModel timeModelWithTitle:@"Samirah" time:345345];
    TimeModel *m6 = [TimeModel timeModelWithTitle:@"Serafina" time:233];
   TimeModel *m7 = [TimeModel timeModelWithTitle:@"Shanon"    time:4649];
    TimeModel *m8 = [TimeModel timeModelWithTitle:@"Sophie"    time:3454];
    TimeModel *m9 = [TimeModel timeModelWithTitle:@"Steven"    time:54524];
    TimeModel *m10 = [TimeModel timeModelWithTitle:@"Saadiya"   time:235];
    
    return @[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10];
}

//创建定时器
- (void)createTimer {
    

    // 使用 schedule 和 timer 两种方式创建的定时器有什么区别。
    /**
     scheduleXXXX Creates a timer and schedules it on the current run loop in the default mode. 默认的mode添加到当前runLoop中 问题1:拖动tableView的时候 时间卡主不动了。
     
     timerWithXXXX  Initializes a timer object with the specified object and selector. 这种方式创建的定时器需要调用 addTimer: forMode:添加到一个指定的runLoop中. 不写定时器就不会走。
     
     
     */
//    self.m_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.m_timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerEvent {
    
    // 在定时器中让 每一个model的所有时间都自减
    for (int count = 0; count < self.m_dataArray.count; count++) {
        TimeModel *model = self.m_dataArray[count];
        [model countDown]; // 时间自减
    }
    
    // 发通知到 TimeCell中
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIME_CELL object:nil];
}

#pragma mark - 创建TableView
- (void)initTableView {
    self.m_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:_m_tableView];
    
    _m_tableView.delegate = self;
    _m_tableView.dataSource = self;
    _m_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 注册cell
    [_m_tableView registerClass:[TimeCell class] forCellReuseIdentifier:TIME_CELL];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.m_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:TIME_CELL];
    
    TimeModel *model = self.m_dataArray[indexPath.row];
    
    [cell loadData:model indexPath:indexPath];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeCell *tmpCell = (TimeCell *)cell;
    tmpCell.m_isDisplay = YES;
    
    TimeModel *model = self.m_dataArray[indexPath.row];
    
    [tmpCell loadData:model indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeCell *tmpCell = (TimeCell *)cell;
    
    tmpCell.m_isDisplay = NO;
}

@end
