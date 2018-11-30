//
//  UILabel+CountDown.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "UILabel+CountDown.h"

@implementation UILabel (CountDown)
- (void)setupCountDownTite:(NSString *)title height:(NSInteger)hieght {
    self.textColor = [UIColor whiteColor];
    self.text = title;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = hieght / 2;
    self.backgroundColor = RBCOLOR_RGBA(0, 0, 0, 0.4);
    self.textAlignment = NSTextAlignmentCenter;
    
    
    
    //富文本添加图片
    NSMutableAttributedString *countDownAttrM = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"CountDown"];
    attach.bounds = CGRectMake(0, 0, 15, 15);
    
    NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:attach];
    
    [countDownAttrM insertAttributedString:attr atIndex:0];
    self.attributedText = countDownAttrM;
}
@end
