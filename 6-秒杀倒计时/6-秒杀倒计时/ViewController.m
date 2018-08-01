//
//  ViewController.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "RBDownViewController.h" //倒计时
#import "RBSecKillViewController.h" //秒杀


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController


#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"秒杀demo";
    self.dataArray = @[@"倒计时",@"秒杀"].mutableCopy;
    
    [self.view addSubview:self.tv];
}


#pragma mark - 一 lazy
- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        NSString *clsName = NSStringFromClass([UITableViewCell class]);
        //注册cell
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:clsName];
        
        _tv.tableFooterView = [UIView new];
    }
    return _tv;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *clsName = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clsName];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        RBDownViewController *downVC = [[RBDownViewController alloc] init];
        [self.navigationController pushViewController:downVC animated:YES];
    }else if(indexPath.row == 1) {
        RBSecKillViewController *seckillVC = [[RBSecKillViewController alloc] init];
        [self.navigationController pushViewController:seckillVC animated:YES];
    }
    NSLog(@"%ld",indexPath.row);
}
@end
