//
//  XJGoodsFormat.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "XJGoodsFormat.h"

#import "XJShouCangGoodsModel.h" //model

@interface XJGoodsFormat()
/**保存一份请求的数据*/
@property (nonatomic, strong) NSMutableArray *backupArray;

@end


@implementation XJGoodsFormat

#pragma mark - 一 lazy
- (NSMutableArray *)backupArray {
    if (!_backupArray) {
        _backupArray = [NSMutableArray array];
    }
    return _backupArray;
}


#pragma mark - 二 接口

- (void)requestGoodsData {
    //网络请求在这里写 这里直接使用本地JSON数据
    
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goodsData" ofType:@"json"];
    
    //转Data
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //JSON 转 Dic
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *listArr = responseDic[@"data"][@"collection_list"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSDictionary *tempDic in listArr) {
        XJShouCangGoodsModel *model = [XJShouCangGoodsModel mj_objectWithKeyValues:tempDic];
        
        [tempArr addObject:model];
    }
    
    self.backupArray = tempArr; //保存一份网络请求的数据
    
    [self.delegate requestDataSucccessWithArray:[tempArr copy]]; //将请求数据传递出去
    [self.delegate goodsFormatReloadDataWhenNeed]; // 通知控制器刷新界面
}

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    
    //取出对应indexPath的model。修改其状态
    XJShouCangGoodsModel *selectedModel = self.backupArray[indexPath.row];
    selectedModel.isScgoosModelSelected = isSelected;
    
    
    if ([self.delegate respondsToSelector:@selector(goodsFormatIsAllSelected:)]) {
        [self.delegate goodsFormatIsAllSelected:[self isAllSelecte]];
    }
    
    //在需要的时候刷新表格:刷新之后才能看到修改后的结果。
    [self.delegate goodsFormatReloadDataWhenNeed];
}


- (void)selectAllWithState:(BOOL)state {
    //遍历数据源修改所有model的状态
    for (XJShouCangGoodsModel *model in self.backupArray) {
        model.isScgoosModelSelected = state;
    }
    
    //通知vc刷新结果
    [self.delegate goodsFormatReloadDataWhenNeed];
}


- (void)beginToDeleteSelectedGoods {
    //遍历数据源 将 isScgoosModelSelected 属性为YES的 XJShouCangGoodsModel 记录下来
    NSMutableArray *selectedArray = [NSMutableArray array];
    
    for (XJShouCangGoodsModel *model in self.backupArray) {
        if (model.isScgoosModelSelected) {
            [selectedArray addObject:model];
        }
    }
    
    [self.delegate goodsFormatWillDeleteSelectedGoodsArray:[selectedArray copy]];
    [self.delegate goodsFormatReloadDataWhenNeed];//刷新数据
}



- (void)deleteSelectGoodsArray:(NSArray *)array {
    
    if(array.count==0) return;
    
    //调删除的接口
    
    
    //刷新数据源 这里使用的是本地模拟数据
    [self.backupArray removeObjectsInArray:array];
    [self.delegate requestDataSucccessWithArray:self.backupArray];
    [self.delegate goodsFormatReloadDataWhenNeed];
}

#pragma mark - 私有方法
/**
 作用:判断所有的cell 是否都被选中
 */
- (BOOL)isAllSelecte {
    
    //假设是全选的
    BOOL isAll = YES;
    
    //遍历每一个model  如果有一个为NO ,非全选状态。停止遍历
    for (XJShouCangGoodsModel *model in self.backupArray) {
        if (model.isScgoosModelSelected == NO) {
            isAll = NO;
            break;
        }
    }
    
    NSLog(@"结果:%@",isAll ? @"全选":@"没有全选");
    
    return isAll; //返回结果
}


@end
