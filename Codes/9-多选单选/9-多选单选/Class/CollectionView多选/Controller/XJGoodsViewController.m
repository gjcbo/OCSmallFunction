//
//  XJGoodsViewController.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "XJGoodsViewController.h"
#import "XJShouCangGoodsItem.h" //cell
#import "XJShouCangGoodsModel.h" //model

#import "XJGoodProxy.h" //collectionView的代理方法
#import "XJGoodsFormat.h" // 业务逻辑

#import "XJBottomView.h"

@interface XJGoodsViewController () <XJGoodsFormatDelegate>
@property(nonatomic, strong) UICollectionView *clv;

@property(nonatomic, strong) XJGoodProxy *goodsProxy;
@property(nonatomic, strong) XJGoodsFormat *goodsFormat;

/**底部view*/
@property (nonatomic, strong) XJBottomView *bottomView;
@property(nonatomic, strong) UIButton *rightEditButton;
@end

@implementation XJGoodsViewController

#pragma mark - 一 lazy
- (UICollectionView *)clv {
    if (!_clv) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _clv.backgroundColor = [UIColor whiteColor];//务必设置背景色
        _clv.delegate = self.goodsProxy;
        _clv.dataSource = self.goodsProxy; //代理方法
        
        //注册cell
        [_clv registerClass:[XJShouCangGoodsItem class] forCellWithReuseIdentifier:@"XJShouCangGoodsItem"];
    }
    return _clv;
}


- (XJGoodProxy *)goodsProxy {
    if (!_goodsProxy) {
        _goodsProxy = [[XJGoodProxy alloc] init];
        
        XJWeakSelf(self);
        _goodsProxy.clickItemBlock = ^(NSIndexPath *indexPath, BOOL isSelected) {
            [weakself.goodsFormat selectItemAtIndexPath:indexPath isSelected:isSelected];

        };
    }
    return _goodsProxy;
}

- (XJGoodsFormat *)goodsFormat {
    if (!_goodsFormat) {
        _goodsFormat = [[XJGoodsFormat alloc] init];
        _goodsFormat.delegate = self;
    }
    return _goodsFormat;
}

- (XJBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[XJBottomView alloc] initWithFrame:CGRectMake(0, KHeight, kWidth, 50)];
        [self.view addSubview:_bottomView];

    
        XJWeakSelf(self);
        _bottomView.xjAllSeletedBlock = ^(BOOL btnSelected) {
            
            //让format干活
            [weakself.goodsFormat selectAllWithState:btnSelected];
        };
        
        _bottomView.xjDeleBlock = ^{
            NSLog(@"%s--%d 点击了删除按钮",__FUNCTION__,__LINE__);
            
            //让format干活
            [weakself.goodsFormat beginToDeleteSelectedGoods];
        };
    }
    return _bottomView;
}

- (UIButton *)rightEditButton {
    if (!_rightEditButton) {
        _rightEditButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_rightEditButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_rightEditButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateSelected)];
        [_rightEditButton setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_rightEditButton setTitle:@"完成" forState:(UIControlStateSelected)];
        
        [_rightEditButton addTarget:self action:@selector(rightEditButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightEditButton;
}

- (void)rightEditButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    
    self.goodsProxy.isEditing = button.selected;
    [self.clv reloadData]; // 刷新
    
    [self showAndHideBottomViewAnimation:button.selected];
}
#pragma mark - 二 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    
    [self setupView];
    
    [self requestData];
}

- (void)setupNav {
    self.navigationItem.title = @"收藏的商品";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightEditButton];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.clv.frame = self.view.bounds;
    [self.view addSubview:self.clv];
}

//网路请求的实现在:Format  调用:在VC中
- (void)requestData {
    [self.goodsFormat requestGoodsData];
}

#pragma mark -  三 XJGoodsFormatDelegate
- (void)requestDataSucccessWithArray:(NSArray *)array {
    
    //将数据传递到Proxy中对 cell 进行赋值
    self.goodsProxy.goodsArray = [array mutableCopy];
}

//界面需要刷新的时候的统一回调
- (void)goodsFormatReloadDataWhenNeed {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.clv reloadData];
    });
}

- (void)goodsFormatIsAllSelected:(BOOL)isAll {
    
    self.bottomView.xx_isAll = isAll;
}

- (void)goodsFormatWillDeleteSelectedGoodsArray:(NSArray *)array {
    NSLog(@"要删除的数据源的个数是:%ld 个",array.count);
    
    if (array.count == 0) {
        [JRToast showWithText:@"请选择要删除的商品"];
        return;
    }
    
  NSString *msg =  [NSString stringWithFormat:@"确定要删除这 %ld 件商品吗?",array.count];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sureAction= [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 在将选择的数据传回去。
        // 绕一圈子 目的？？: Format 负责业务逻辑。想把网络请求放在Format中
        [self.goodsFormat deleteSelectGoodsArray:array];
    }];
    
    
    [alertVc addAction:cancelAction];
    [alertVc addAction:sureAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - 四 显示底部的 bottomView
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

