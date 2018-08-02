//
//  SearchViewController.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDetailViewController.h"

//view
//#import "RBHotView.h"
//#import "RBHotView2.h"
#import "RBHotView3.h"

#import "RBHotViewByCategory.h"
#import "RBSearchNavBarView.h"
#import "RBSearchResultView.h"


@interface SearchViewController ()
@property (nonatomic, strong) RBSearchNavBarView *searchNavView;
@property (nonatomic, strong) RBSearchResultView *searchResultView; //搜索结果view
@property (nonatomic, strong) RBHotView3 *hotView;
@end

@implementation SearchViewController

#pragma mark - 一 lazy
//默认隐藏
- (RBSearchResultView *)searchResultView {
    if (!_searchResultView) {
        //y: 状态栏 + searchNavView的高度 + 间距 10
        CGFloat y = k_StateBarH + 64 + 10;
        _searchResultView = [[RBSearchResultView alloc] initWithFrame:CGRectMake(0, y, kScreenW, kScreenH - y)];
        
        RBWeakSelf(self);
        
        //跳转详情view
        _searchResultView.searchResultViewClickCellBlock = ^(NSString *str, NSIndexPath *indexPath) {
            
            //跳转详情页
            SearchDetailViewController *detailVC = [[SearchDetailViewController alloc] init];
            [weakself.navigationController pushViewController:detailVC animated:YES];
        };
    }
    return _searchResultView;
}

- (RBSearchNavBarView *)searchNavView {
    if (!_searchNavView) {
        _searchNavView = [[RBSearchNavBarView alloc] initWithFrame:CGRectMake(0, k_StateBarH, kScreenW, 64)];
        
        [_searchNavView.searchBar becomeFirstResponder];
        
        RBWeakSelf(self);
        
        //点击搜索按钮
        _searchNavView.searchBlock = ^(NSString *searchStr) {
            NSLog(@"要搜索的字符串是：%@",searchStr);
            [weakself simulateRequestSearchDataWithSearchStr:searchStr];
            
        };
        
        _searchNavView.searchNavBarViewClickCancelButtonBlock = ^{
            NSLog(@"点击了===>取消 按钮");
            // 取消第一响应者
            // 返回
            [weakself dismissViewController];
        };
    }
    
    return _searchNavView;
}
- (RBHotView3 *)hotView {
    if (!_hotView) {
        _hotView = [[RBHotView3 alloc] initWithFrame:CGRectMake(0, 120, kScreenW, 0)];
        _hotView.backgroundColor = [UIColor redColor];
        
        _hotView.dataArray = @[@"xxx凉了",@"Android",@"JavaEE",@"PHP",@"Web前端",@"Vue",@"微信小程序",@"Java大数据",@"Python爬虫",@"JavaScript",@"运维",@"UI",@"产品经理"];
        
        RBWeakSelf(self);
        
        _hotView.hotView3ClickTagLbBlock = ^(NSString *str) {
            NSLog(@"点击了:%@",str);
            //跳转详情页
            SearchDetailViewController *detailVC = [[SearchDetailViewController alloc] init];
            [weakself.navigationController pushViewController:detailVC animated:YES];
        };
        
    }
    return _hotView;
}


#pragma mark - 一 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//跳转到下一界面显示 nav 导航条
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.searchResultView.hidden = YES; //隐藏搜索view
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.searchNavView];

    [self.view addSubview:self.hotView];
    
    [self.view addSubview:self.searchResultView]; //搜索结果view 默认隐藏。
    self.searchResultView.hidden = YES;
}

- (void)dismissViewController{
    
    [self.searchNavView.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 模拟网络请求
- (void)simulateRequestSearchDataWithSearchStr:(NSString *)searchStr {
    
    NSMutableArray *searchResultArr = [NSMutableArray array];
    for (int i =0; i<20; i++) {
        NSString *tempStr = [NSString stringWithFormat:@"%@-----%d",searchStr,i];
        
        [searchResultArr addObject:tempStr];
    }
    
    self.searchResultView.hidden = NO; //显示view
    self.searchResultView.resultArr = searchResultArr;
}



#pragma mark - 二 demos
- (void)demos {
    //    RBHotView *hotView = [[RBHotView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 0)];
    //    hotView.backgroundColor = [UIColor redColor];
    //
    //    hotView.hotTagArray = @[@"我是",@"创建",@"科技",@"研发",@"iOS组员",@"玉树临风",@"高大威猛",@"才华横溢",@"这TM都信"].mutableCopy;
    //    [self.view addSubview:hotView];
    
    
    //    RBHotViewByCategory *hotViewByCategory = [[RBHotViewByCategory alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 0)];
    //    hotViewByCategory.hotTagArray = @[@"我是",@"创建",@"科技",@"研发",@"iOS组员",@"玉树临风",@"高大威猛",@"才华横溢",@"这TM都信"].mutableCopy;
    //
    //
    //    // dispa
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        // 问什么:设置 hotViewByCategory 他 的背景颜色无效
    //        hotViewByCategory.backgroundColor = [UIColor brownColor];
    //        hotViewByCategory.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //        hotViewByCategory.layer.borderWidth =1.0;
    //    });
    //    [self.view addSubview:hotViewByCategory];
    //
    //    RBSearchNavBarView *navView = [[RBSearchNavBarView alloc] initWithFrame:CGRectMake(0, 400, kScreenW, 50)];
    //    [self.view addSubview:navView];
    
    
    //    UIImage *redImg = [navView rb_imageWithColor:[UIColor lightGrayColor]];
    //    NSLog(@"%@",NSStringFromCGSize(redImg.size));
    //
    //    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    //    iv.image = redImg;
    //
    //    [self.view addSubview:iv];
}

#pragma mark - 三 问题: 键盘回收问题。
/**
 1.找不到一个合适的时机回收键盘。
 刚看了下 Android 版的淘宝。Android 的键盘自带回收按钮。ios的没有。尴尬了。
 1-1. 一般来说进入搜索页面，就是要进行搜索---> ∴ 展示键盘
 看需求吧。 
 */
@end
