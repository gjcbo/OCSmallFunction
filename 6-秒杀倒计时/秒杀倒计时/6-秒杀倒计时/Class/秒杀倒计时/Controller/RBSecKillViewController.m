//
//  RBSecKillViewController.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBSecKillViewController.h"
#import "RBSecKillView.h"

@interface RBSecKillViewController ()
@property (nonatomic, strong) RBSecKillView *seckillView;

@end

@implementation RBSecKillViewController

#pragma mark - 一 lazy
- (RBSecKillView *)seckillView {
    if (!_seckillView) {
        _seckillView = [[RBSecKillView alloc] initWithFrame:self.view.bounds];
    }
    return _seckillView;
}


#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    //注意定时器的销毁时机！！！
//    [self.seckillView secKillViewInvalidateTimer];
//}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"秒杀";
    
    [self.view addSubview:self.seckillView];
    
    //请求秒杀数据
    [self.seckillView reqeustSecKillData];
}

- (void)dealloc {
    NSLog(@"控制器被销毁");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
