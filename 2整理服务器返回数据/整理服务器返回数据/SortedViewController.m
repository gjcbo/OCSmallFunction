//
//  SortedViewController.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/7.
//  Copyright © 2018年 关键词. All rights reserved.
//  归类后的数据VC

#import "SortedViewController.h"
#import "OriginCell.h"
#import "RBReadPlist.h"
#import "HistoryModel.h"
#import "SectionHeaderView.h" // 自定义区头


#define kNYRStr @"nyrStr"
#define kNYRArr @"nyrArr"
#define kScreen_W [UIScreen mainScreen].bounds.size.width
#define kSection_H 44

@interface SortedViewController ()<UITableViewDataSource,UITableViewDelegate>
/**tableView*/
@property(nonatomic, strong) UITableView *tableView;
/**归类后数据源数组 arrange:1.把某某系统的分类, 2.整理, 3.改编*/
@property(nonatomic, strong) NSMutableArray *arrangeArray;

@end

@implementation SortedViewController
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource= self;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"排序后的数据";
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"OriginCell" bundle:nil] forCellReuseIdentifier:@"OriginCell"];
    
    // 数据
    self.arrangeArray = [self rbSortedOutArray];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrangeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
/**
 [
 {nyrStr:"2018-1-4"
  nyrArr:[数组1]
 },
 {nyrStr:"2017-12-30"
 nyrArr:[数组2]
 },
 ......
    ]
 */
    NSDictionary *secDic = self.arrangeArray[section];
    NSArray *rowArr = secDic[kNYRArr];
    
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OriginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OriginCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    // 外层字典
    NSDictionary *outerDic = self.arrangeArray[indexPath.section];
    // 内层数组
    NSArray *inlayerArr = outerDic[kNYRArr];
    HistoryModel *model = inlayerArr[indexPath.row];
    
    // 时分秒字符串
    NSString *hourMinuteSecondsStr = [self sfmStrFromNYRSFMTimeStr:model.openlock_time];
    
    [cell rbSetName:model.username timeStr:hourMinuteSecondsStr];
    return cell;
}

// 自定义SectionHeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *sectionReuseIdentifier = @"sectionReuseIdentifier";
    
    SectionHeaderView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionReuseIdentifier];
    
    if (sectionView == nil) {
        sectionView = [[SectionHeaderView alloc] initWithReuseIdentifier:sectionReuseIdentifier];
    }
    
    NSDictionary *secDic = self.arrangeArray[section];
    NSString *dateStr = secDic[kNYRStr];
    NSArray *nyrArr = secDic[kNYRArr];
    NSString *timesStr = [NSString stringWithFormat:@"%ld次数",(long)nyrArr.count];
    
    // 赋值
    [sectionView rbSetDateStr:dateStr timesStr:timesStr];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSection_H;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSection_H;
}


#pragma mark - 对服务器返回数据进行归类
/**1. 读取plist数据,转Model后返回*/
- (NSMutableArray *)rbModelArray{
    // 读取plist文件，其实就是从服务器获取数据，数据不满足需要，需要重新归类转换为自己想要的数据。
    NSArray *historyArr = [RBReadPlist rbReadPlist];
    
    // 将Dic转Model
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (NSDictionary *aDic in historyArr) {
        HistoryModel *aModel = [HistoryModel provinceWithDic:aDic];
        [modelArr addObject:aModel];
    }
    return modelArr;
}

/**原始数据格式: 一维数组
 [
 {},
 {},
 ......
 ]
 */
/**转换后的数据格式: 二维数组
 [
 {
 "nyrStr":"2017-12-15",
 "nyrArr":[数组],
 },
 {
 "nyrStr":"2017-11-11",
 "nyrArr":[数组],
 },
 {},
 .....
 ]
 */

- (NSMutableArray *)rbSortedOutArray{
    NSMutableArray *modelArr = [self rbModelArray];
    
    // 根据dic的key唯一性，去除重复的key,将同一天的开锁记录归为同一类
    NSMutableDictionary *noRepeatDic = [NSMutableDictionary dictionary];
    for (HistoryModel *model in modelArr) {
        // 年月日时间
        NSString *nyrTimeStr =  [self nyrTimeFromNYRSFMTimeStr:model.openlock_time];
        
        // 直接将"年月日"时间作为key
        [noRepeatDic setValue:nyrTimeStr forKey:nyrTimeStr];
    }
    
    // 最外层大容器,容器结构：[{小字典1},{小字典2}]
    NSMutableArray *categoryArr = [NSMutableArray array];
    
    // 取出所有的日期
    NSArray *allkeyTimeArr = [noRepeatDic allKeys];
    for (NSString *timeKey in allkeyTimeArr) {
        
        // 小字典{key1:"字符串", key2:[数组]}
        NSMutableDictionary *finalDic = [NSMutableDictionary dictionary];
        
        NSMutableArray *smallArr = [NSMutableArray array];
        for (HistoryModel *model in modelArr) {
            NSString *nyrTimeStr = [self nyrTimeFromNYRSFMTimeStr:model.openlock_time];
            
            //比对日期是否相等相同的日期放入一个数组中
            if ([timeKey isEqualToString:nyrTimeStr]) {
                [smallArr addObject:model];
            }
        }
        
        [finalDic setValue:timeKey forKey:kNYRStr];
        [finalDic setValue:smallArr forKey:kNYRArr];
        
        [categoryArr addObject:finalDic];
    }
    
    return categoryArr;
}

#pragma mark - 工具类:日期处理
- (NSString *)nyrTimeFromNYRSFMTimeStr:(NSString *)nyrsfmStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //年月日时分秒
    NSDate *nyrsfmDate = [fmt dateFromString:nyrsfmStr];
    
    //年月日
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nyrStr = [fmt stringFromDate:nyrsfmDate];
    
    return nyrStr;
}

/**年与日时分秒字符串转时分秒字符串*/
- (NSString *)sfmStrFromNYRSFMTimeStr:(NSString *)nyrsfmStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *nyrsfmDate = [fmt dateFromString:nyrsfmStr];
    
    fmt.dateFormat = @"HH:mm:ss";
    return [fmt stringFromDate:nyrsfmDate];
}

@end
