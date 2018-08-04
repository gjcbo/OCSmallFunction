//
//  FMViewController.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "FMViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "PersonCarsViewController.h"
#import "CarsViewController.h"


@interface FMViewController ()
/**数据源*/
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FMViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addAction)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"车库" style:(UIBarButtonItemStylePlain) target:self action:@selector(watchCarsAction)];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.dataArray =  [[DataBase shareDataBase] getAllPerson];
}

#pragma mark - Action

//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)fromxx to:(int)toxx
{
    return (int)(fromxx + (arc4random() % (toxx -  fromxx + 1)));
}

- (void)addAction
{

    //子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建随机Person对象
        NSInteger ageRandom = arc4random_uniform(100) + 1;
        
        NSArray *nameArr = @[@"张三",@"李四",@"王五",@"乔峰",@"段誉",@"虚竹",@"刘华强"]; // 7
        int nameRandom = arc4random() % nameArr.count;
        
        NSString *name = nameArr[nameRandom];
        NSInteger age = ageRandom;
        
        Person *p = [[Person alloc] init];
        p.name = name;
        p.age = age;
        
        // 保存到数据库
        [[DataBase shareDataBase] addPerson:p];
        
        // 获取所有数据
        self.dataArray = [[DataBase shareDataBase] getAllPerson];
    });
    
    // 更新tableView
    [self.tableView reloadData];
}

/** 生成 [x,y]之间的随机数;*/
- (void)randomNumberDemo
{
    //    int random =  arc4random_uniform(10); // 0---9
    //    NSLog(@"%d",random);
    
    //    int random = arc4random() % 15; // 0---9
    //    NSLog(@"随机数:%d",random);
    //0--x-1 之前的正整数
    // int value = arc4random() % x;
    
    // 1---x 之间的正整数
    //    arc4random() % x + 1
    
    // 5---8 之间的随机数
    int random1 =  arc4random() % (8-5+1) + 5;
    NSLog(@"%d",random1);
}

- (void)watchCarsAction
{
    NSLog(@"车库");
    
    CarsViewController *carVC = [[CarsViewController alloc] init];
    [self.navigationController pushViewController:carVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cellId";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Person *p = self.dataArray[indexPath.row];
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"person_id :%@ age:%ld",p.ID,p.age];
    
    return cell;
}

/**设置删除按钮*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *p1 = self.dataArray[indexPath.row];
        
        // 删除人
        [[DataBase shareDataBase] deletePerson:p1];
        // 删除给人的所有车
        [[DataBase shareDataBase] deleteAllCarFromPerson:p1];
        
        // 更新数据库、更新tableView
        self.dataArray = [[DataBase shareDataBase] getAllPerson];
        [self.tableView reloadData];
    }
}

/**cell点击事件,给人添加车*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Person *selectP = self.dataArray[indexPath.row];
    
    PersonCarsViewController *personCarVC = [[PersonCarsViewController alloc] init];
    personCarVC.currentPerson = selectP;
    
    [self.navigationController pushViewController:personCarVC animated:YES];
}

@end

