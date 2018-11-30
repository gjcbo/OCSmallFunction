//
//  RBSecKilItem.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBSecKillModel;

@interface RBSecKilItem : UICollectionViewCell

- (void)configureSecKillItemWithModel:(RBSecKillModel *)model indexPath:(NSIndexPath *)indexPath;

@end
