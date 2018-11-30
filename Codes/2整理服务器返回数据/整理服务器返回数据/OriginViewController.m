//
//  OriginViewController.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/7.
//  Copyright © 2018年 关键词. All rights reserved.
//  原始数据VC

#import "OriginViewController.h"
#import "RBReadPlist.h"
#import "OriginCell.h"

@interface OriginViewController ()<UITableViewDelegate,UITableViewDataSource>

/**tableView*/
@property(nonatomic, strong) UITableView *tableView;

/**数据源*/
@property(nonatomic, strong) NSMutableArray *dataArr;
@end

static NSString *originCellIdentifier = @"originCellIdentifier";
@implementation OriginViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"原始数据";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    // 注册cell
//    [self.tableView registerNib:[OriginCell class] forCellReuseIdentifier:@"OriginCell"];
    

    [self.tableView registerNib:[UINib nibWithNibName:@"OriginCell" bundle:nil] forCellReuseIdentifier:@"OriginCell"];
    
    // 读取plist文件给数据源数组赋值
    self.dataArr = [RBReadPlist rbReadPlist];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OriginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OriginCell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    [cell rbSetName:dic[@"username"] timeStr:dic[@"openlock_time"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
@end
