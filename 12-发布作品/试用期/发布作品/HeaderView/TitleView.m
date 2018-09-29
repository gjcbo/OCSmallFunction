//
//  TitleView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  90

#import "TitleView.h"
@interface TitleView()
@property (nonatomic, strong) UILabel *titleLb; //标题
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TitleView

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
        _titleLb.text = @"标题：";
    }
    return _titleLb;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 30, kScreen_W, 50)];
        _textView.zw_placeHolder = @"           28个字符以内";
        _textView.zw_limitCount = 28;
        _textView.backgroundColor = UICOLOR_HEX(0XF4F4F4);
        
        _textView.scrollEnabled = NO; //不让滚
    }
    return _textView;
}

@end
