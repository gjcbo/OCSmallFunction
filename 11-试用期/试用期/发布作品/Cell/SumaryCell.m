//
//  SumaryCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "SumaryCell.h"
@interface SumaryCell()
@property (weak, nonatomic) IBOutlet UITextView *sumaryTextView;

@end

@implementation SumaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sumaryTextView.zw_placeHolder = @"对这个作品有什么想介绍或补充的吗?";
    self.sumaryTextView.zw_limitCount = 500;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone; //取消选中样式
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
