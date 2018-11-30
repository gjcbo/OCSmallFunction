//
//  TitleCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "TitleCell.h"
@interface TitleCell()
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;

@end

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleTextView.zw_placeHolder = @"28个字符以内";
    self.titleTextView.zw_limitCount = 28;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
