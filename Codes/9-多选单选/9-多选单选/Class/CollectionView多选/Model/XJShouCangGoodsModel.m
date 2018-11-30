//
//  XJShouCangGoodsModel.m
//  XinJiangMall
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 Tzyang. All rights reserved.
//  收藏的商品model

#import "XJShouCangGoodsModel.h"

@implementation XJShouCangGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    // 服务器返回字段和 model定义的字段不一致时:前面是你定义的字段 后面是服务器返回的字段。
    return @{@"goodsId":@"id"};
}
@end
