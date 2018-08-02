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
#import "RBHotView.h"

#import "RBHotView2.h"
#import "RBHotView3.h"

#import "RBHotViewByCategory.h"
#import "RBSearchNavBarView.h"



@interface SearchViewController ()
@property(nonatomic, strong) RBSearchNavBarView *searchNavView;

@end

@implementation SearchViewController


#pragma mark - 一 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//跳转到下一界面显示 nav 导航条 
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    
    RBHotView3 *hotView = [[RBHotView3 alloc] initWithFrame:CGRectMake(0, 120, kScreenW, 0)];
    [self.view addSubview:hotView];
    hotView.dataArray = @[@"xxx凉了",@"Android",@"JavaEE",@"PHP",@"Web前端",@"Vue",@"微信小程序",@"Java大数据",@"Python爬虫",@"JavaScript",@"运维",@"UI",@"产品经理"];
    hotView.hotView3ClickTagLbBlock = ^(NSString *str) {
        NSLog(@"点击了:%@",str);
        //跳转详情页
        SearchDetailViewController *detailVC = [[SearchDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    [self setupView];
}

- (void)setupView {

    self.searchNavView = [[RBSearchNavBarView alloc] initWithFrame:CGRectMake(0, k_StateBarH, kScreenW, 64)];
    [self.view addSubview:self.searchNavView];
    
    [self.searchNavView.searchBar becomeFirstResponder];
    
    __weak typeof(self) weakSelf = self;
    
    self.searchNavView.searchNavBarViewClickCancelButtonBlock = ^{
        NSLog(@"点击了===>取消 按钮");
        
        // 取消第一响应者
        
        // 返回
        
        [weakSelf dismissViewController];
    };
}

- (void)dismissViewController{
    
    [self.searchNavView.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
