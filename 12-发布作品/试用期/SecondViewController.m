//
//  SecondViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//
//不要复用


#import "SecondViewController.h"
#import "NewHeaderView.h"
#import "FooterView.h"
//Cell
#import "NestStepCell.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
//底层的tableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NewHeaderView *headerVeiw;
@property (nonatomic, strong) FooterView *footerView;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布产品";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerVeiw;
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
        
        [_tableView registerNib:[UINib nibWithNibName:@"NestStepCell" bundle:nil] forCellReuseIdentifier:@"NestStepCell"];
        
    }
    return _tableView;
}

- (NewHeaderView *)headerVeiw {
    if (!_headerVeiw) {

        _headerVeiw = [[NewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 580)];
        _headerVeiw.headerViewBlock = ^(UIImageView *iv) {
            NSLog(@"%s--%d--%@",__FUNCTION__,__LINE__,iv);
            iv.image = [UIImage imageNamed:@"秋风萧瑟.jpg"];
        };
    }
    return _headerVeiw;
}


- (FooterView *)footerView {
    if (!_footerView) {
        _footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    }
    return _footerView;
}


#pragma mark - tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; //食材 + 步骤
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { //步骤
        
        NestStepCell *setpCell = [tableView dequeueReusableCellWithIdentifier:@"NestStepCell"];
        return setpCell;
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld",indexPath.section, indexPath.row];
        return cell;
    }
}

//区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *sectionView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        UILabel *titleLb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        titleLb1.text = @"食材：";
        [sectionView1 addSubview:titleLb1];
        return sectionView1;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 44;
    }else {
        return 0;
    }
}

//区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) { //返回一个表位，点击动态添加cell
  
        static NSString * identy = @"headFoot";
        UITableViewHeaderFooterView *footV1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
        if (!footV1) {
            footV1 = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identy];
            UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
            redView.center = self.view.center;
            redView.backgroundColor = [UIColor redColor];
            [footV1 addSubview:redView];
        }
        return footV1;
        
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }else {
        return 0;
    }
}

#pragma mark - UIScrollViewDelegate 滑动后 回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}


@end
