//
//  NestStepCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "NestStepCell.h"
@interface NestStepCell()
@property (weak, nonatomic) IBOutlet UIImageView *iv; //点击添加图片
@property (weak, nonatomic) IBOutlet UITextView *tv; //内容描述TextView
@end

@implementation NestStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //占位文字和字数限制
    self.tv.zw_placeHolder = @"写下这不需要的材料、时间和制作要点";
    self.tv.zw_limitCount = 200;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
