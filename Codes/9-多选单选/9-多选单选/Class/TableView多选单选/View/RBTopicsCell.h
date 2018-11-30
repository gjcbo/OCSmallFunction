//
//  RBTopicsCell.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBTopicsModel.h"

@interface RBTopicsCell : UITableViewCell
@property (nonatomic, strong) RBTopicsModel *topicModel;

/**4.选中按钮 方便在外界修改他的 hidden属性 */
@property (nonatomic, strong) UIButton *selectButton;


@end
