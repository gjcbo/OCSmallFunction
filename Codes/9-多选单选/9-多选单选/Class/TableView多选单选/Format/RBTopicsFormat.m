//
//  RBTopicsFormat.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  负责处理业务逻辑(eg:网络请求，其他时间回调)

#import "RBTopicsFormat.h"

//model
#import "RBTopicsModel.h"
@interface RBTopicsFormat()

@property (nonatomic, strong) NSMutableArray *backUpArray;

@end

@implementation RBTopicsFormat

- (NSMutableArray *)backUpArray {
    if (!_backUpArray) {
        _backUpArray = [NSMutableArray array];
    }
    return _backUpArray;
}

#pragma mark - 接口
- (void)requestTopicsData {
    
    //网络请求
    
    // 读取本地JSON数据
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topicsData" ofType:@"json"];
    //文件转data
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *err = nil;
    
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&err];
    
    NSArray *listArr = responseDic[@"data"][@"list"];
    
    NSMutableArray *newArr = [NSMutableArray array];
    
    for (NSDictionary *tempDic in listArr) {
        RBTopicsModel *model = [RBTopicsModel mj_objectWithKeyValues:tempDic];
        [newArr addObject:model];
    }
    
    self.backUpArray = newArr;
    
    //将网络请求数据传递出去
    [self.delegate requestTopicsDataSuccessWithArray:newArr];
    [self.delegate topicsFormatReloadDataWhenNeed];
}



- (void)selectTopicsAtIndexPath:(NSIndexPath *)indexPath state:(BOOL)state {

    //修改 indexPath 对应的model 选中状态
    RBTopicsModel *currentModel = self.backUpArray[indexPath.row];
    currentModel.isSelected = state;
    
    // 处理这样一种逻辑。如果 所有model都被选中 底部全选按钮也因该处于全选状态,反之。(不太好处理。)
    [self.delegate topicsIsAllSelected:[self isAllSelected]];
    
    // 通知VC刷新
    [self.delegate topicsFormatReloadDataWhenNeed];
}


- (void)selectAllTopicsWithState:(BOOL)state {
    // 修改所有model的选中状态
    for (RBTopicsModel *model in self.backUpArray) {
        model.isSelected = state;
    }
    
    //通知VC刷新
    [self.delegate topicsFormatReloadDataWhenNeed];
}


/**
 这里的接口设计的太好。
 1.beginDeleteSelectedTpoics 筛选出删除的model数组 deleteArr
 2. 通知代理对象(本工程中就是VC)将要删除数组是什么  topicsFormatWillDeleteSelectedArr:deleteArr
 
 3. 在代理对象的(本工程中就是VC) 的 topicsFormatWillDeleteSelectedArr: 方法中 将要删除的方法在传递给 Format 的 另外一个方法 deleteSelectTopicsWithSelectedArr
 
 
 Format ---》筛选出要删除的数组 然后通知----》     VC  --------- 》 在回调方法中再将 筛选出来的数组 回传到  Format 中。
 目的 ？？？？
 答:Format 的职责负责业务逻辑，转了一大圈就是为了将网络请求挪到这里来。给控制器瘦身。 简单问题复杂化了😁
 */
//用于获取将要删除的数组
- (void)beginDeleteSelectedTpoics {
    NSMutableArray *deleteArr = [NSMutableArray array];
    
    for (RBTopicsModel *model in self.backUpArray) {
        if (model.isSelected) {
            [deleteArr addObject:model];
        }
    }
    
    //要删除的数组
    [self.delegate topicsFormatWillDeleteSelectedArr:deleteArr];
}

- (void)deleteSelectTopicsWithSelectedArr:(NSArray *)selectedArr {

    //这里写网路请求的方法:调删除接口
    
    
    //这里用的是本地模拟数据。
    [self.backUpArray removeObjectsInArray:selectedArr];
    
    NSLog(@"数组元素个数:%ld",(unsigned long)self.backUpArray.count);
    
    
    [self.delegate requestTopicsDataSuccessWithArray:self.backUpArray];
    [self.delegate topicsFormatReloadDataWhenNeed];
}


#pragma mark - 二 Private method
//判断是否全选
- (BOOL)isAllSelected {
    
    if (self.backUpArray.count == 0) return NO;
    
    BOOL isAllselected = YES;
    
    for (RBTopicsModel *model in self.backUpArray) {
        if (model.isSelected == NO) {
            isAllselected = NO;
            break;
        }
    }
    
    return isAllselected;
}

@end
