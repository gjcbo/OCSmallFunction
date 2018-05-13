//
//  ViewController.m
//  Runtime字典转模型
//
//  Created by RaoBo on 2018/5/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [Person rb_objPropeties];
    
    NSDictionary *dic = @{@"name":@"zhangsan",
                          @"age":@18,
                          @"title":@"boss",
                          @"height":@1.9,
                          @"daxiguan":@"xxx"};
    
    Person *person = [Person rb_objWithDic:dic];
    
    NSLog(@"%@",person);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
