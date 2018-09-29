//
//  NewHeaderView.h
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewHeaderViewDelegate <NSObject>
- (void)fromPaiZhaoWithImageView:(UIImageView *)iv;
- (void)fromAlbumWithImageView:(UIImageView *)iv;
@end

@interface NewHeaderView : UIView
/**9-29 传值问题 : 跨多个界面传值问题。
 碰到问题了，block 回调问题，传值问题。
 */
@property(nonatomic, copy) void(^headerViewBlock)(UIImageView *iv);
/**放到外面，所有的问题都解决了*/
@property (nonatomic, strong) UIImageView *iv;


/**基础知识不要过关：代理属性用 copy 修饰导致崩溃。*/
@property (nonatomic, weak) id <NewHeaderViewDelegate>delegate;
@end
