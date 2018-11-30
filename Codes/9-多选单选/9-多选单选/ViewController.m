//
//  ViewController.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "RBTableViewSingleViewController.h" //tv单选
#import "RBTopicsViewController.h" // tv多选
#import "XJGoodsViewController.h" //clv多选



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - 一lazy

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}



#pragma mark - 二 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"单选多选";
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.dataArray = @[@"1.tableView单选",@"2.tableView多选",@"3.collectionView多选"].mutableCopy;
}



#pragma mark - 三 UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld---%ld",(long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.row == 0) {
        RBTableViewSingleViewController *singleVC = [[RBTableViewSingleViewController alloc] init];
        [self.navigationController pushViewController:singleVC animated:YES];
    }else if (indexPath.row == 1) {
        RBTopicsViewController *topicsVC = [[RBTopicsViewController alloc] init];
        [self.navigationController pushViewController:topicsVC  animated:YES];
    }else if(indexPath.row == 2){
        
        XJGoodsViewController *goodVC = [[XJGoodsViewController alloc] init];
        [self.navigationController pushViewController:goodVC animated:YES];
    }
}

@end
