//
//  AdjustStepsController.m
//  试用期
//  调整步骤控制器
//  Created by Yasin on 2018/10/8.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  https://github.com/jiuchabaikaishui/TableVIewCellEdit/blob/master/TableVIewCellEdit/ViewController.m

#import "AdjustStepsController.h"
#import "AdjustStepCell.h"
@interface AdjustStepsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AdjustStepsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"调整步骤";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneAction)];
    
    [self.view addSubview:self.tableView];
    self.tableView.editing = YES;
//    Concatenated NSString literal for an NSArray expression - possibly missing a comma
    //初始化数据源
    self.dataArr = @[@"第一步",@"第二步"@"第三步",@"第四步",@"第五步",@"第六步"].mutableCopy;
}

- (void)doneAction{
    NSLog(@"完成");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"AdjustStepCell" bundle:nil] forCellReuseIdentifier:@"AdjustStepCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

//tableView的编辑搞定 就去学习
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AdjustStepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdjustStepCell"];
    cell.lb.text  = self.dataArray[indexPath.row];
    return cell;
}


#pragma mark - 一 侧滑 左边出现删除编辑按钮
//这个是自定义右边编辑按钮的样式
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //处理数据
        [self.dataArray removeObjectAtIndex:indexPath.row];
        //更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    return @[deleteAction];
}

#pragma mark - 二 移动位置
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *exchangeStr = self.dataArr[sourceIndexPath.row];
    [self.dataArr removeObjectAtIndex:sourceIndexPath.row];
    [self.dataArr insertObject:exchangeStr atIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
