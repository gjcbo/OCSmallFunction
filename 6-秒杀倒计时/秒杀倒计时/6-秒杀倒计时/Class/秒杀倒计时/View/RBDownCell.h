//
//  RBDownCell.h
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBDownModel.h"

@interface RBDownCell : UITableViewCell


- (void)configureDownCellWithModel:(RBDownModel *)model indexPath:(NSIndexPath *)indexPath;

@end
