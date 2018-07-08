//
//  XJBottomView.h
//  Clv全选
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>
/**点击左边按钮Block 将btn选中状态带出去*/
typedef void(^XJAllSelectedBlock) (BOOL btnSelected);
/**点击右边删除按钮Block*/
typedef void(^XJDeleteBlock) (void);

@interface XJBottomView : UIView
@property(nonatomic, copy) XJAllSelectedBlock xjAllSeletedBlock;
@property(nonatomic, copy) XJDeleteBlock xjDeleBlock;

/**BOOL 用于标记全选状态 需重写setter方法*/
//@property(nonatomic, assign) BOOL All;


@property(nonatomic, assign) BOOL xx_isAll;


@end
