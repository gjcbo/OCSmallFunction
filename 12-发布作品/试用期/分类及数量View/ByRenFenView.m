//
//  ByRenFenView.m
//  试用期
//
//  Created by Yasin on 2018/10/8.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ByRenFenView.h"
#import "Masonry.h" //布局

@interface ByRenFenView()
/**数量按钮 默认为1  */
@property (nonatomic, strong) UIButton *cntBtn;
/**减少按钮*/
@property (nonatomic, strong) UIButton *minusBtn;
/**添加按钮*/
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic) NSInteger cnt; //数量，默认值为1
@end

@implementation ByRenFenView 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _cnt = 1;//初始值为1
    
    [self addSubview:self.cntBtn];
    [self addSubview:self.minusBtn];
    [self addSubview:self.addBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    CGFloat k5 = 5;
    CGFloat k10 = 10;
    CGFloat k30 = 30;// 宽高
    [self.cntBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cntBtn.mas_right).offset(k10);
        make.size.mas_equalTo(CGSizeMake(k30, k30));
        make.centerY.equalTo(self);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minusBtn.mas_right).offset(k10);
        make.size.mas_equalTo(CGSizeMake(k30, k30));
        make.centerY.equalTo(self);
    }];
}


#pragma mark - getter
- (UIButton *)cntBtn {
    if (!_cntBtn) {
        _cntBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cntBtn setTitle:[NSString stringWithFormat:@" x %ld",_cnt] forState:(UIControlStateNormal)];
        _cntBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:(10)];

        [_cntBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_cntBtn setImage:[UIImage imageNamed:@"面包.png"] forState:(UIControlStateNormal)];
    }
    return _cntBtn;
}

- (UIButton *)minusBtn {
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_minusBtn setImage:[UIImage imageNamed:@"gwcjsl2"] forState:(UIControlStateNormal)];
        [_minusBtn addTarget:self action:@selector(clickMinusBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _minusBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setImage:[UIImage imageNamed:@"gwcjsl"] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(clickAddBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

#pragma mark - 事件监听
- (void)clickMinusBtnAction:(UIButton *)btn {
    
    if (_cnt < 2) {
        _cnt = 1;
        _minusBtn.enabled = NO;
    }else {
        _cnt--;
        _minusBtn.enabled = YES;
    }
    
    //更新个数
    NSString *cntStr = [NSString stringWithFormat:@" x %ld",_cnt];
    [_cntBtn setTitle:cntStr forState:(UIControlStateNormal)];
}

- (void)clickAddBtnAction:(UIButton *)btn {
    _cnt++;
    _minusBtn.enabled = YES;
    
    NSString *cntStr = [NSString stringWithFormat:@" x %ld",_cnt];
    [_cntBtn setTitle:cntStr forState:(UIControlStateNormal)];
}


@end
