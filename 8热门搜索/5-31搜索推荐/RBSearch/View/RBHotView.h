//
//  RBHotView.h
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

/***
 备注:RBHotView
 宽度确定:一定要给宽度 = 默认屏幕宽
 高度不确定:算出来的。
 
*/

@interface RBHotView : UIView
/**热们搜索标签数组: 外界传入*/
@property(nonatomic, strong) NSArray *hotTagArray;

@end
