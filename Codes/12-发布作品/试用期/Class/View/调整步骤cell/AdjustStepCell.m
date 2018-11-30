
//
//  AdjustStepCell.m
//  试用期
//
//  Created by Yasin on 2018/10/8.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "AdjustStepCell.h"
@interface AdjustStepCell()


@end

@implementation AdjustStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
