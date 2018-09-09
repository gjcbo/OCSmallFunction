//
//  ViewController.m
//  单元测试
//
//  Created by RaoBo on 2018/9/9.
//  Copyright © 2018年 RB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self printMyName:nil];
    
//    [self printMyName:@"李四"];
}

/**iOS  中的断言*/
- (void)printMyName:(NSString *)myName {
    //断言条件为真 ：表明程序正常运行
    //断言为假：奔溃报错，程序出问题了。
    
//    nil != nil // NO ---》 奔溃， 就会报后面的异常。
//    @"zhangsan" != nil //YES ---> 程序正常运行
//    NSAssert(myName != nil, @"名字不能为空");

    NSLog(@"My name is %@.",myName);
    
    
    NSAssert([myName isEqualToString:@"张三"], @"名字不是张三，奔溃");
    
}
@end
