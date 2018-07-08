//
//  RBPayTypeCell.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBPayTypeCell.h"
@interface RBPayTypeCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@end

@implementation RBPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconIv.layer.masksToBounds = YES;
    self.iconIv.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPayTypeModel:(RBPayTypeModel *)payTypeModel {
    _payTypeModel = payTypeModel;
    
    self.iconIv.image = [UIImage imageNamed:payTypeModel.iconStr];
    self.nameLb.text = payTypeModel.name;
    
    
    // accessoryView + model选中状态实现单选🔘
    if (payTypeModel.isChecked) {
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_on"]];
    }else {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_off"]];
    }
}



@end
