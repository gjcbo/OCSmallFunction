//
//  SumaryView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  h: 200

#import "SumaryView.h"
@interface SumaryView()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation SumaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.titleLb];
    [self addSubview:self.textView];
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        _titleLb.text = @"作品摘要：";
    }
    return _titleLb;
}
- (UITextView *)textView {
    if (!_textView) {
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40 , kScreen_W - 20, 150)];
        _textView.zw_placeHolder = @"对于这个作品有什么想介绍或想补充的吗？";
        _textView.zw_limitCount = 500;
        _textView.backgroundColor = UICOLOR_HEX(0XF4F4F4);
        _textView.scrollEnabled = NO;
    }
    return _textView;
}


@end
