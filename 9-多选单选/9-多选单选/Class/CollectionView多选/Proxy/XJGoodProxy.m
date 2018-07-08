//
//  XJGoodProxy.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  封装collectionview代理方法

#import "XJGoodProxy.h"
#import "XJShouCangGoodsItem.h"
#import "XJShouCangGoodsModel.h"

@implementation XJGoodProxy

#pragma mark -  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld",(unsigned long)self.goodsArray.count);
    
    return self.goodsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XJShouCangGoodsItem *item  = [collectionView dequeueReusableCellWithReuseIdentifier:@"XJShouCangGoodsItem" forIndexPath:indexPath];
    
    
    //控制器右上角点击编辑按钮是否处于编辑状态。
    [item rb_showDotButtonWithState:self.isEditing];

    
    XJShouCangGoodsModel *model = self.goodsArray[indexPath.row];
    item.model = model;
    
    return item;
}

#pragma mark - UICollectionViewDelegate
/**点没点 这个方法知道
 点一下选中 再点一下取消选中
 要做的事情就是: 记录 点击了那个cell。 是否选中。 通过block将两个状态传出去。
 在block里面让format处理对应的业务逻辑。
 Format 负责业务逻辑，
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL tempIsSelected = NO;
    
//    如果处于编辑状态
    if (self.isEditing) {
        
        XJShouCangGoodsModel *model = self.goodsArray[indexPath.row];

        model.isScgoosModelSelected = !model.isScgoosModelSelected;
        
        tempIsSelected = model.isScgoosModelSelected;
    }

    NSLog(@"%@",tempIsSelected ? @"选中" : @"取消选中");
    
    if (self.clickItemBlock) {
        self.clickItemBlock(indexPath, tempIsSelected);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat w = (kWidth - 4) / 2;
    CGFloat h = 280;
    
    return CGSizeMake(w, h);
}


/**x轴间距*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

/**轴间距*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}






@end
