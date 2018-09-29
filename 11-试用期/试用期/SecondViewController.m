//
//  SecondViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//
//不要复用


#import "SecondViewController.h"
#import "HeaderView.h"
#import "FooterView.h"
//cell
#import "TitleCell.h" //1.标题
#import "SumaryCell.h" //2.作品摘要
#import "SatrCell.h" //3.难度评星
#import "CtyAndQuantityCell.h" //4.分类以及分量
#import "FiveCell.h" //5.第五个cell 食材

#define kTitleCellId @"TitleCell"
#define kSumaryCellId @"SumaryCell"
#define kSatrCellId @"SatrCell"
#define kCtyAndQuantityCellId @"CtyAndQuantityCell"
#define kFiveCellId @"FiveCell"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
//底层的tableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HeaderView *headerVeiw;
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
        
        //注册标题cell
        [_tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"SumaryCell" bundle:nil] forCellReuseIdentifier:kSumaryCellId];
        [_tableView registerClass:[SatrCell class] forCellReuseIdentifier:kSatrCellId];
        [_tableView registerClass:[CtyAndQuantityCell class] forCellReuseIdentifier:kCtyAndQuantityCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"FiveCell" bundle:nil] forCellReuseIdentifier:kFiveCellId];
    }
    return _tableView;
}

- (HeaderView *)headerVeiw {
    if (!_headerVeiw) {

        _headerVeiw = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == 0) { //0.标题cell
        
        TitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        return titleCell;
    }else if (indexPath.row == 1) { //1.作品摘要
        SumaryCell *sumaryCell = [tableView dequeueReusableCellWithIdentifier:kSumaryCellId];
        return sumaryCell;
    }else if (indexPath.row == 2) { //2.难度评星
        SatrCell *starCell = [tableView dequeueReusableCellWithIdentifier:kSatrCellId];
        return starCell;
    }else if (indexPath.row == 3) { //3.分类以及分量
        CtyAndQuantityCell *ctyAndQuantityCell = [tableView dequeueReusableCellWithIdentifier:kCtyAndQuantityCellId];
        return ctyAndQuantityCell;
    }else if (indexPath.row == 4) { //4. 第五个cell
        FiveCell *fiveCell = [tableView dequeueReusableCellWithIdentifier:kFiveCellId];
        return fiveCell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld",indexPath.section,indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1) {
        return 200;
    }else if (indexPath.row == 2) {
        return 80;
    }else if (indexPath.row == 3) {
        return 200;
    }else if (indexPath.row == 4) {
        return 44;
    }
    else {
        return 44;
    }
}

#pragma mark - UIScrollViewDelegate 滑动后 回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}




@end
