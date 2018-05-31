//
//  ViewController.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"首页";
    

    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(50, 100, 100, 50);
    [button setTitle:@"跳转" forState:(UIControlStateNormal)];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth  =1.0;
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [button addTarget:self action:@selector(buttonClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)buttonClickAction {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    
//    [self.navigationController pushViewController:searchVC animated:YES];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:navVC animated:YES completion:nil] ;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
