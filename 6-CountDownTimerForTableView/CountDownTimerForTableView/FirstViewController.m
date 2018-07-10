//
//  FirstViewController.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/7/10.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)skipToNextVC:(UIButton *)sender {
    
    ViewController *vc = [[ViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
