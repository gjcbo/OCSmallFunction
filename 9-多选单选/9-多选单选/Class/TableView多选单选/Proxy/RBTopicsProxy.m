//
//  RBTopicsProxy.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  负责tableView的代理方法

#import "RBTopicsProxy.h"
#import "RBTopicsCell.h"

@implementation RBTopicsProxy

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RBTopicsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectButton.hidden = !self.isEditing; //根据是否处于编辑状态 控制选择按钮的hidden属性
    
    RBTopicsModel *model = self.topicsArr[indexPath.row];
    cell.topicModel = model;
    
    return cell;
}


#pragma mark -  UITableViewDelegate,
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //作用:需要一个变量记录cell的选中状态,并通过block将该结果传递出去。不得已为之。状态实在是太多了。
    BOOL tempSelected = NO;
    
    
    if (self.isEditing) { //编辑状态时 实现单选全选效果
        
        NSLog(@"row:%ld",(long)indexPath.row);
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //模型isSelected属性取反
        RBTopicsModel *model = self.topicsArr[indexPath.row];
        model.isSelected = !model.isSelected;
    
        tempSelected = model.isSelected;

        //        [tableView reloadData]; //建议:不建议在这里刷新。合理的做法是:应该在 Format中通过代理方法通知vc刷新表格。Format(负责业务逻辑)
    }
    
    //block回调
    if (self.topicsProxyDidSelectCellBlock) {
        self.topicsProxyDidSelectCellBlock(indexPath, tempSelected);
    }
}


@end






