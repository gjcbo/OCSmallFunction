//
//  RBTableViewSingleViewController.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  talbeView单选

#import "RBTableViewSingleViewController.h"

//view
#import "RBPayTypeCell.h"
//model
#import "RBPayTypeModel.h"


@interface RBTableViewSingleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSMutableArray <RBPayTypeModel *>*dataArray;

/**标记选择的支付方式 model*/
@property (nonatomic, strong) RBPayTypeModel *selectedPayTypeModel;



@end

@implementation RBTableViewSingleViewController

//#pragma mark - 一 lazy
//#pragma mark - 二 生命周期
//#pragma mark - 三 fkfj

#pragma mark - 一 lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RBPayTypeCell class]) bundle:nil] forCellReuseIdentifier:@"RBPayTypeCell"];
//        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 80)];
        
        UIButton *payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        payButton.backgroundColor = [UIColor brownColor];
        payButton.frame = CGRectMake(15, 30, kWidth - 30, 40);
        
        [payButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [payButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        [payButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
        
        [payButton addTarget:self action:@selector(clickPayButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_footerView addSubview:payButton];
    }
    
    return _footerView;
}

#pragma mark - 点击立即支付
- (void)clickPayButtonAction:(UIButton *)button {
//    NSLog(@"立即支付");

    //请选择支付方式:如果selectedPayTypeModel 为 nil
    if (self.selectedPayTypeModel == nil) {
        [JRToast showWithText:@"请选择支付方式"];
    }else {

        [JRToast showWithText:[NSString stringWithFormat:@"选择的付款方式是:%@",self.selectedPayTypeModel.name]];
        NSLog(@"%@",self.selectedPayTypeModel);
    }
}


- (NSMutableArray<RBPayTypeModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 二 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"tableView单选";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footerView;
    
    [self requestMoNiShuJu];
}

- (void)requestMoNiShuJu {
    
    NSArray *moniArr = @[@{@"iconStr":@"pay_alipay",
                           @"name":@"支付宝支付"},
                         @{@"iconStr":@"pay_WeChat",
                           @"name":@"微信支付"},
                         @{@"iconStr":@"pay_card",
                           @"name":@"银行卡支付"},
                         @{@"iconStr":@"pay_money",
                           @"name":@"钱包支付"}
                         ];
    
    
    for (NSDictionary *dic in moniArr) {
        RBPayTypeModel *model = [RBPayTypeModel mj_objectWithKeyValues:dic];
        [self.dataArray addObject:model];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - 三 UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RBPayTypeCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.payTypeModel = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - 三 UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"请选择付款方式";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //全部清空
    for (RBPayTypeModel *model in self.dataArray) {
        model.isChecked = NO;
    }
    
    //让当前选中的model处于选中状态
    self.dataArray[indexPath.row].isChecked = YES;
    self.selectedPayTypeModel = self.dataArray[indexPath.row];
    
    //刷新 查看效果
    [self.tableView reloadData];
}







@end
