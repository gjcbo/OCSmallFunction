//
//  XJGoodsFormat.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol XJGoodsFormatDelegate <NSObject>
@required
/**1.成功请求到数据的回调*/
- (void)requestDataSucccessWithArray:(NSArray *)array;
/**2.界面需要刷新时的统一回调*/
- (void)goodsFormatReloadDataWhenNeed;

@optional
/**3.将要删除收藏的商品*/
- (void)goodsFormatWillDeleteSelectedGoodsArray:(NSArray *)array;

/**4.是否处于全选状态: 如果全选了 就同步更新底部bottomView的全选按钮的状态*/
- (void)goodsFormatIsAllSelected:(BOOL)isAll;

@end

@interface XJGoodsFormat : NSObject

@property (nonatomic, weak) id <XJGoodsFormatDelegate> delegate;

/**请求数据*/
- (void)requestGoodsData;

/**选中、取消选中*/
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;

/**全选、取消全选*/
- (void)selectAllWithState:(BOOL)state;

/**批量删除收藏的商品*/
- (void)beginToDeleteSelectedGoods;

/**将选中的商品删除,注意调用时时机*/
- (void)deleteSelectGoodsArray:(NSArray *)array;


@end
