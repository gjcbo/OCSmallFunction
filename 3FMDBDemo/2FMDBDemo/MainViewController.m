//
//  MainViewController.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//
// FMDB的使用 https://www.jianshu.com/p/54e74ce87404

#import "MainViewController.h"
#import "FMViewController.h" //FMDataBase demo vc
#import "BaseQueueDemoController.h" //FMDataBaseQueue Demo VC

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    FMViewController *firstVC = [[FMViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    firstNav.tabBarItem.title = @"DBDemo";
    firstNav.tabBarItem.tag = 0;
    

    BaseQueueDemoController *secondVC = [[BaseQueueDemoController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    secondNav.tabBarItem.title = @"DBQueueDemo";
    secondNav.tabBarItem.tag = 1;
    
    self.viewControllers = @[firstNav,secondNav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"点击了:%ld--%@",tabBar.tag,item.title);
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
