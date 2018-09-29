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

//model
#import "StepModel.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
//底层的tableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NewHeaderView *headerVeiw;
@property (nonatomic, strong) FooterView *footerView;

@property (nonatomic, strong) NSMutableArray *stepArrM;//步骤数组。
@property (nonatomic, assign) NSInteger cnt;//标记步骤的个数。点击加号按钮自加初始值为1;
@end

@implementation SecondViewController
- (NSMutableArray *)stepArrM {
    if (!_stepArrM) {
        _stepArrM = [NSMutableArray array];
    }
    return _stepArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布产品";
  
    [self setupTableView]; //
    
    //初始化数组
    [self setupDataArray];
    _cnt = 1 ;//初始值为1
}

- (void)setupDataArray {
    StepModel *model1 = [[StepModel alloc] init];
    model1.name = @"步骤1";
    [self.stepArrM addObject:model1];
}

- (void)setupTableView {
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
    if (section == 0) { //
        return 1;
    }else if (section == 1) { //步骤cell 个数
        return self.stepArrM.count;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { //步骤
        
        NestStepCell *stepCell = [tableView dequeueReusableCellWithIdentifier:@"NestStepCell"];
        
        //取出模型
        StepModel *model = self.stepArrM[indexPath.row];
        stepCell.stepLb.text = model.name;
        return stepCell;
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
            UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [addBtn setImage:[UIImage imageNamed:@"加号2-fill.png"] forState:(UIControlStateNormal)];
            CGFloat x = (kScreenW - 30)*0.5;
            addBtn.frame = CGRectMake(x, 0, 40, 40);
            [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [footV1 addSubview:addBtn];
        }
        return footV1;
        
    }else {
        return nil;
    }
}

#pragma mark - 添加
//添加cell
- (void)addBtnAction:(UIButton *)btn {
    NSLog(@"添加按钮");
    _cnt++;
    //创建步骤模型
    StepModel *newModel = [[StepModel alloc] init];
    newModel.name = [NSString stringWithFormat:@"步骤%ld:",_cnt];
    
    //添加到数据源数组中
    [self.stepArrM addObject:newModel];
    
    //刷新表格
    [self.tableView reloadData];
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
