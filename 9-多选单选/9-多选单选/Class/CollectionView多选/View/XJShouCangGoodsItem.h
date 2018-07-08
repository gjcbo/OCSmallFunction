//
//  XJShouCangGoodsItem.h
//  XinJiangMall
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 Tzyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJShouCangGoodsModel;

@interface XJShouCangGoodsItem : UICollectionViewCell
@property(nonatomic, strong) XJShouCangGoodsModel *model;

/**根据model的选中状态和
 是否编辑状态来判断是否要显示 别选中view。
 */
//- (void)rb_showOrHideSelectedViewWithModel:(XJShouCangGoodsModel *)model editingMode:(BOOL)isEditing;

- (void)rb_showDotButtonWithState:(BOOL)isEditing;

- (void)xjscgoodsItem_showOrHideSelectedBtnWithState:(BOOL)state;


@end
