//
//  RBTopicsViewController.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  收藏的帖子(多选)

#import "RBTopicsViewController.h"
#import "RBTopicsProxy.h" //负责tableView代理方法
#import "RBTopicsFormat.h" //业务逻辑

//view
#import "RBTopicsCell.h"
#import "XJBottomView.h"

@interface RBTopicsViewController ()<RBTopicsFormatDelegate>
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RBTopicsProxy *topicsProxy;
@property (nonatomic, strong) RBTopicsFormat *topicsFormat;

/**右边编辑按钮*/
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) XJBottomView *bottomView;


@end

@implementation RBTopicsViewController

#pragma mark - 一 lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self.topicsProxy;
        _tableView.dataSource = self.topicsProxy;
        
        [_tableView registerClass:[RBTopicsCell class] forCellReuseIdentifier:@"RBTopicsCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


//负责:代理方法
- (RBTopicsProxy *)topicsProxy {
    if (!_topicsProxy) {
        _topicsProxy = [[RBTopicsProxy alloc] init];
        
        XJWeakSelf(self);
        
        _topicsProxy.topicsProxyDidSelectCellBlock = ^(NSIndexPath *indexPath, BOOL isSelected) {
            [weakself.topicsFormat selectTopicsAtIndexPath:indexPath state:isSelected];
        };
    }
    
    return _topicsProxy;
}

//负责:处理业务逻辑
- (RBTopicsFormat *)topicsFormat {
    if (!_topicsFormat) {
        _topicsFormat = [[RBTopicsFormat alloc] init];
        _topicsFormat.delegate = self;
    }

    return _topicsFormat;
}

- (UIButton *)editButton {
    if (!_editButton) {
        
        _editButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editButton setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editButton setTitle:@"完成" forState:(UIControlStateSelected)];
        [_editButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_editButton addTarget:self action:@selector(clickRightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        CGSize btnSize =  [_editButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
        _editButton.frame = CGRectMake(0, 0, btnSize.width*1.3,
                                       40);
    }
    return _editButton;
}
- (XJBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[XJBottomView alloc] initWithFrame:CGRectMake(0, KHeight, kWidth, 50)];
        [self.view addSubview:_bottomView];
        
        XJWeakSelf(self);
        _bottomView.xjAllSeletedBlock = ^(BOOL btnSelected) {
            [weakself.topicsFormat  selectAllTopicsWithState:btnSelected];
        };
        
        _bottomView.xjDeleBlock = ^{
            [weakself.topicsFormat beginDeleteSelectedTpoics];
        };
    }
    return _bottomView;
}



#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"收藏的帖子";
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    [self reqeustData];
}

- (void)clickRightButtonAction:(UIButton *)btn {
    
    btn.selected  = !btn.selected;
    self.topicsProxy.isEditing = btn.selected;
    [self.tableView reloadData]; //刷新
    
    [self showAndHideBottomViewAnimation:btn.selected];
}

- (void)reqeustData {
    
    [self.topicsFormat requestTopicsData];
}

#pragma mark - 三 RBTopicsFormatDelegate
- (void)requestTopicsDataSuccessWithArray:(NSArray *)array {
    //RBTopicsProxy 封装了tableView的代理方法的代理。 将网络请求的数据传递过去让他显示数据
    
    self.topicsProxy.topicsArr = [array mutableCopy];
}

- (void)topicsFormatReloadDataWhenNeed {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)topicsIsAllSelected:(BOOL)isAll {
    
    NSLog(@"%@",isAll ? @"是":@"没有全选");
    //通知底部view修改状态
    self.bottomView.xx_isAll = isAll;
}

//触发时机  Format 调用 beginDeleteSelectedTpoics 此方法时。
- (void)topicsFormatWillDeleteSelectedArr:(NSArray *)array {
    
    if (array.count == 0) return;
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要删除这些数据?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"确认删除");
        [self.topicsFormat deleteSelectTopicsWithSelectedArr:array];
    }];
    
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - 四 Private method

- (void)showAndHideBottomViewAnimation:(BOOL)isEditing {
    if (isEditing) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.frame = CGRectMake(0, KHeight - kNavigationBarHeight, kWidth, 50);
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.frame = CGRectMake(0, KHeight, kWidth, 50);
        }];
    }
}
@end
