//
//  XJShouCangGoodsModel.h
//  XinJiangMall
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 Tzyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJShouCangGoodsModel : NSObject
/**用于标记一个Model是否没选中*/
//@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isScgoosModelSelected;


@property (nonatomic, copy) NSString *market_price;// 超市价格
@property (nonatomic, copy) NSString *goodsId; // 商品id
@property (nonatomic, copy) NSString *price; // 价格
@property (nonatomic, copy) NSString *cover; //图片
@property (nonatomic, copy) NSString *name; // 名字
@end
