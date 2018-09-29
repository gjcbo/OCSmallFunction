//
//  ZYSegmentedControl.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ZYSegmentedControl.h"

@implementation ZYSegmentedControl

- (instancetype)initWithItems:(NSArray *)items target:(id)target sel:(SEL)sel {
    self = [super initWithItems:items];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [UIColor brownColor]; //选中的颜色
        self.selectedSegmentIndex = 0; //默认第一个选中
        
        //添加事件监听
        [self addTarget:target action:sel forControlEvents:(UIControlEventValueChanged)];
    }
    return self;
}

- (void)insertItemWithTitleArr:(NSArray<NSString *> *)titleArr selectedIndex:(NSInteger)index {
    
    //遍历数组,插入item
    [titleArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self insertSegmentWithTitle:obj atIndex:idx animated:NO];
    }];

    NSInteger selectedIndex = index ? index : 0;
    //设置默认选中 item
    self.selectedSegmentIndex = selectedIndex;
}


@end
