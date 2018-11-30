//
//  CarsViewController.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/7.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "CarsViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "Car.h"

#define kPersonName @"personName"
#define kCarArray @"carArray"

@interface CarsViewController ()
/**personArr*/
@property(nonatomic, strong) NSMutableArray *personArray;
/**person拥有的car*/
@property(nonatomic, strong) NSMutableArray *personCarArr;

@end

@implementation CarsViewController
- (NSMutableArray *)personArray {
    if (!_personArray) {
        _personArray = [NSMutableArray array];
    }
    return _personArray;
}

- (NSMutableArray *)personCarArr {
    if (!_personCarArr) {
        _personCarArr = [NSMutableArray array];
    }
    return _personCarArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"animated : %d",animated);
    
    [super viewWillAppear:animated];
    
   self.personArray =  [[DataBase shareDataBase] getAllPerson];

    // 临时容器
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (Person *p in self.personArray) {
       NSArray *carArr = (NSArray *)[[DataBase shareDataBase] getlAllCarFromPerson:p];
     
        // 如果我空会怎么办
        [tempArr addObject:carArr];
    }
    
    self.personCarArr = tempArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"车库";
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.personArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *carsArr = self.personCarArr[section];
    
    return carsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *carCellId = @"carCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:carCellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:carCellId];
    }
    
    NSArray *carArr = self.personCarArr[indexPath.section];
    Car *aCar = carArr[indexPath.row];
    
    cell.textLabel.text = aCar.brand;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"价格：￥%ld",aCar.price];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Person *p = self.personArray[section];
    
    return [NSString stringWithFormat:@"%@的所有车",p.name];
}


@end
