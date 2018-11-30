//
//  FooterView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  今日事今日毕
//  Don't let yesterday take up too much of today.
//  Don't let yesterday take up too much of today.

#import "FooterView.h"
@interface FooterView()
@property (nonatomic, strong) UIButton *saveDraftBtn;//保存到草稿按钮
@property (nonatomic, strong) UIButton *publichBtn; //发布按钮
@property (nonatomic, strong) UIView *lineView; //白色的线条

@end

@implementation FooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.lineView];
    [self addSubview:self.saveDraftBtn];
    [self addSubview:self.publichBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width; //总宽
    
    // 白色线条
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(w/2);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(3);
    }];

    [self.saveDraftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.lineView.mas_left);
    }];

    [self.publichBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right);
        make.top.bottom.right.equalTo(self);
    }];
}


#pragma mark - getter
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UIButton *)saveDraftBtn {
    if (!_saveDraftBtn) {
        _saveDraftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saveDraftBtn setTitle:@"保存到草稿" forState:(UIControlStateNormal)];
        [_saveDraftBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _saveDraftBtn.backgroundColor = [UIColor brownColor];
        [_saveDraftBtn addTarget:self action:@selector(savaDraftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _saveDraftBtn;
}

- (UIButton *)publichBtn {
    if (!_publichBtn) {
        _publichBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_publichBtn setTitle:@"发布" forState:(UIControlStateNormal)];
        [_publichBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _publichBtn.backgroundColor = [UIColor brownColor];
        [_publichBtn addTarget:self action:@selector(publicBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _publichBtn;
}


#pragma mark - 点击事件
- (void)publicBtnAction:(UIButton *)btn {
    NSLog(@"%s--%d",__FUNCTION__,__LINE__);
    [JRToast showWithText:@"发布"];

}
- (void)savaDraftAction:(UIButton *)btn {
    NSLog(@"%s--%d",__FUNCTION__,__LINE__);
    [JRToast showWithText:@"保存到草稿"];
}

- (void)addAddressAction {
    NSLog(@"添加收货地%s---%d",__FUNCTION__, __LINE__);
}

@end
