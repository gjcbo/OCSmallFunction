//
//  CtyAndCntView.h
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <UIKit/UIKit.h>

/**点击按钮的 block回调*/
typedef void(^CtyAndCntViewClickBtnBlock)(void); //矩形
typedef void(^CtyAndCntViewClickCircleBlock)(void); //圆
typedef void(^CtyAndCntViewClickHollowCircleBlock)(void);//空心圆


@interface CtyAndCntView : UIView

@property (nonatomic, copy) CtyAndCntViewClickBtnBlock ctyAndCntViewClickBtnBlock;//1.按钮
@property (nonatomic, copy) void(^ctyAndCntViewClickRectBlock)(void); //2.点击矩形事件回调
@property (nonatomic, copy) CtyAndCntViewClickCircleBlock ctyAndCntViewClickCircleBlock;//3.点击圆事件回调
@property (nonatomic, copy) CtyAndCntViewClickHollowCircleBlock ctyAndCntViewClickHollowCircleBlock; //4.点击空心圆事件回调




/**提供一个接口供外部修改内部属性、样式*/
/** 修改 CtyAndCntView 按钮样式 */
- (void)ctyAndCntViewChangeBtnTitle:(NSString *)title;
/**随机修改 分段控件的items个数*/
- (void)ctyAndCntViewRandomChangeSegControlItems;
@end
