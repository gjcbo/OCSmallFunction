//
//  FiveCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  第五个cell 没调用
//  赶紧写吧,什么都别说了,写不出来,就该滚蛋了.

#import "FiveCell.h"
@interface FiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *iv;
@end

@implementation FiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iv.image = [UIImage imageNamed:@"食材cell.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
