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
/**确定button*/
@property(nonatomic, strong) UIButton *sureButton;
/**单输入框*/
@property(nonatomic, strong) RBSingleInputView *singleView;
@end

@implementation SingleInputViewController

#pragma mark - lazy
- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sureButton.backgroundColor = [UIColor brownColor];
        [_sureButton setTitle:@"验证" forState:(UIControlStateNormal)];
        [_sureButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_sureButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self rbSingleInputView];
}

- (void)rbSingleInputView {
    
    //Label
    UILabel *showLabel = [self rbCreateALabel];
    [self.view addSubview:showLabel];
    
    self.singleView = [[RBSingleInputView alloc] initWithFrame:CGRectMake(5, 100, kScreenWidth-10, 60)];
    self.singleView.isShowByPassword = YES; // 密文显示
    [self.view addSubview:self.singleView];

    // 显示回调内容
    self.singleView.finshBlock = ^(NSString *codeStr) {
        showLabel.text = codeStr;
    };
    
    //UIButton
    self.sureButton.frame = CGRectMake(100, 300, kScreenWidth - 200, 50);
    [self.view addSubview:self.sureButton];
}

- (UILabel *)rbCreateALabel{
    // label
    UILabel *showCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth - 100, 50)];
    showCodeLabel.backgroundColor = [UIColor lightGrayColor];
    showCodeLabel.textAlignment = NSTextAlignmentCenter;

    return showCodeLabel;
}

// 这里面解决一个bug:block回调实际有问题，如果在Button里面进行判断，苦于无法拿到block里面的codeStr数据，只好勉强定义一个属性。
- (void)sureButtonAction:(UIButton *)btn
{
    NSLog(@"你输入的内容是:%@",self.singleView.inputString);
}


- (void)dealloc{
    NSLog(@"视图控制器被销毁%s --- %d",__FUNCTION__,__LINE__);
}

@end
