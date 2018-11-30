//
//  ViewController.m
//  定时器-循环引用
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "MethodViewController1.h"
#import "MethodViewController2.h"
#import "MethodViewController3.h" //推荐。✅ 
#import "MethodViewController4.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, copy) NSArray  *dataArray;


@end

@implementation ViewController

#pragma mark - 一 lazy
- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        _tv.tableFooterView = [UIView new];
    }
    return _tv;
}
#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
    NSString *str1 = @"1.使用带block的API + __weak解决循环引用问题";
    NSString *str2 = @"2.使用中间类并进行弱引用来解决循环引用";
    NSString *str3 = @"3.使用NSProxy来解决循环引用 ✅ 推荐";
    NSString *str4 = @"4.在控制器将要消失的时候提前销毁定时器";

    self.dataArray = @[str1,str2,str3,str4];
    
    [self.view addSubview:self.tv];
}

#pragma mark - 三 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * clsName = NSStringFromClass([UITableViewCell class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clsName];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        MethodViewController1 * vc1 = [[MethodViewController1 alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    } else if(indexPath.row == 1) {
        MethodViewController2 *vc2 = [[MethodViewController2 alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }else if(indexPath.row == 2){
        MethodViewController3 *vc3 = [[MethodViewController3 alloc] init];
        [self.navigationController pushViewController:vc3 animated:YES];
    }else if(indexPath.row == 3) {
        MethodViewController4 *vc4 = [[MethodViewController4 alloc] init];
        [self.navigationController pushViewController:vc4 animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
