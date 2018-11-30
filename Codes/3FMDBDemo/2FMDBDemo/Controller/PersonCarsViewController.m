//
//  PersonCarsViewController.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/6.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "PersonCarsViewController.h"
#import "Person.h"
#import "Car.h"
#import "DataBase.h"


@interface PersonCarsViewController ()
/**数据源数组*/
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PersonCarsViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = [NSString stringWithFormat:@"%@的所有车",self.currentPerson.name];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addCar)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   self.dataArray = [[DataBase shareDataBase] getlAllCarFromPerson:self.currentPerson];
}

#pragma mark - Action
- (void)addCar
{
    NSLog(@"添加车");
    
    // 创建随机car数据
    NSArray *brandArr = @[@"别克",@"雪佛兰",@"凯迪拉克",@"福特",@"林肯",@"奔驰",@"宝马",@"奥迪",@"大众",@"保时捷",@"丰田",@"NISSAN",@"本田",@"马自达",@"三菱",@"五十铃",@"铃木"]; // 17
    NSInteger index = arc4random() % brandArr.count;
    
    Car *car = [[Car alloc] init];
    car.own_id = self.currentPerson.ID; // 车的own_id对应人的ID
    car.brand = brandArr[index];
    car.price = arc4random() % 1000000;

    [[DataBase shareDataBase] addCar:car toPerson:self.currentPerson];
    
    // 更新数据源
    self.dataArray = [[DataBase shareDataBase] getlAllCarFromPerson:self.currentPerson];
    
    // 刷新tableView
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *personCellid = @"personCellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personCellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:personCellid];
    }

    Car *aCar = self.dataArray[indexPath.row];
    cell.textLabel.text = aCar.brand;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"价格￥：%ld",aCar.price];
    
    return cell;
}

/**编辑删除按钮*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 拿到要删除的car
        Car *aCar = self.dataArray[indexPath.row];
        
        // 这里面是有问题的，删除某个人的某辆车，只传car_id  和 Person有什么关系，
        // 另一方面，你要删除某个人的某一辆车，你不知道人你怎么删除。
        // 参考别人怎么写的。
        [[DataBase shareDataBase] deleteCar:aCar fromPerson:self.currentPerson];
        
        self.dataArray =  [[DataBase shareDataBase] getlAllCarFromPerson:self.currentPerson];
        
        [self.tableView reloadData];
    }
}
@end
