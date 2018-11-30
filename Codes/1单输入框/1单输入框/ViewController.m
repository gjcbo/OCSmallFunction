//
//  ViewController.m
//  1单输入框
//
//  Created by RaoBo on 2018/1/27.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "SingleInputViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)skipToSingleInputVCAction:(UIButton *)sender {
    
    SingleInputViewController *singleVC = [[SingleInputViewController alloc] init];
    [self.navigationController pushViewController:singleVC animated:YES];
}


@end
