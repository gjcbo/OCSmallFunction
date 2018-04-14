//
//  BaseTableViewCell.m
//  CountDownTimerForTableView
//
//  Created by RaoBo on 2018/4/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self defaultConfig];
        
        [self buildViews];
    }
    return self;
}

- (void)defaultConfig{
    
}

- (void)buildViews{
    
}

- (void)loadData:(id)data indexPath:(NSIndexPath *)indexPath{
    
}

@end
