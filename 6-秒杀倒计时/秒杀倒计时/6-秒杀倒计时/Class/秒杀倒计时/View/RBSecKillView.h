//
//  RBSecKillView.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBSecKillView : UIView

/**请求描述数据 外面调用。*/
- (void)reqeustSecKillData;


/**销毁控制器, 注意调用时机
 在控制器  viewWillDisappear 或 viewDidDisappear中可以销毁定时器 ✅
 
 其他方法中无法销毁 这里的定时器
 */
- (void)secKillViewInvalidateTimer;
@end
