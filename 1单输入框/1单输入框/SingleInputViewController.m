//
//  SingleInputViewController.m
//  1单输入框
//
//  Created by RaoBo on 2018/1/27.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "SingleInputViewController.h"
#import "RBSingleInputView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SingleInputViewController ()

@end

@implementation SingleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self rbSingleInputView];
}

- (void)rbSingleInputView {
    
    UILabel *showCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth - 100, 50)];
    showCodeLabel.backgroundColor = [UIColor lightGrayColor];
    showCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showCodeLabel];
    
    RBSingleInputView *singleView = [[RBSingleInputView alloc] initWithFrame:CGRectMake(5, 100, kScreenWidth-10, 60)];
    singleView.isShowByPassword = YES; // 密文显示
    [self.view addSubview:singleView];

    // 显示回调内容
    singleView.finshBlock = ^(NSString *codeStr) {
        showCodeLabel.text = codeStr;
    };
}

- (void)dealloc{
    NSLog(@"视图控制器被销毁%s --- %d",__FUNCTION__,__LINE__);
}

@end
