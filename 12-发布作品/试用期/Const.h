//
//  Const.h
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  常量

#ifndef Const_h
#define Const_h

#define kScreen_W [UIScreen mainScreen].bounds.size.width
#define kScreen_H [UIScreen mainScreen].bounds.size.height

#define UICOLOR_HEX(hexString) [UIColor colorWithRed:((float)((hexString &0xFF0000) >>16))/255.0 green:((float)((hexString &0xFF00) >>8))/255.0 blue:((float)(hexString &0xFF))/255.0 alpha:1.0]

//#define UICOLOR_RGB(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//作者：石虎132
//链接：https://www.jianshu.com/p/cd30936c9cc7


// 10-9 模具类型
typedef NS_ENUM(NSInteger, MuJuType) {
    MuJuRectType, //方形模具
    MuJuCircleType, //圆形
    MuJuHollowCircleType //空心圆
};
#endif /* Const_h */
