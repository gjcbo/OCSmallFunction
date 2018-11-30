//
//  PersonCarsViewController.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/6.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;

@interface PersonCarsViewController : UITableViewController
/**当前选中的人*/
@property(nonatomic, strong) Person *currentPerson;
@end
