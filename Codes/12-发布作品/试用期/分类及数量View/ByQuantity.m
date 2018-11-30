//
//  ByQuantity.m
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  按数量

#import "ByQuantity.h"
#import "Masonry.h"
@interface ByQuantity()
/**按个数按钮 默认样式:(左图 + 右文字)*/
@property (nonatomic, strong) UIButton *cntBtn;
@property (nonatomic, strong) UIButton *minusBtn; //减少
@property (nonatomic, strong) UIButton *addBtn;   //增加
@property (nonatomic) NSInteger cnt; //个数 默认为1
@end

@implementation ByQuantity

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.cnt = 1; //默认初始值为1
    
    [self addSubview:self.cntBtn];
    [self addSubview:self.minusBtn];
    [self addSubview:self.addBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat h = self.bounds.size.height;

    CGFloat btn_h = 30;
    CGFloat y = (h - btn_h) / 2;

    CGFloat x0 = 10;
    CGFloat x1 = x0 + 100 + 10;
    CGFloat x2 = x1 + btn_h + 10;
    
    self.cntBtn.frame = CGRectMake(x0, y, 100, btn_h);
    self.minusBtn.frame = CGRectMake(x1, y, btn_h, btn_h);
    self.addBtn.frame = CGRectMake(x2, y, btn_h, btn_h);
}

#pragma mark - getter
- (UIButton *)cntBtn { //左图 右文字 默认数量为1
    if (!_cntBtn) {
        _cntBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cntBtn setTitle:@" x 1" forState:(UIControlStateNormal)];
        [_cntBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _cntBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:(10)];
        [_cntBtn setImage:[UIImage imageNamed:@"fbzparf"] forState:(UIControlStateNormal)];
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
    //如果数量小于1 按钮不可点。数量默认为1 更新文字
    if (_cnt < 2) {
        _cnt = 1;
        _minusBtn.enabled = NO;
    }else {
        _cnt--; //自减
        _minusBtn.enabled = YES;
    }
    
    //更新数量
    NSString *cntStr = [NSString stringWithFormat:@" x %ld",_cnt];
    [self.cntBtn setTitle:cntStr forState:(UIControlStateNormal)];
}

- (void)clickAddBtnAction:(UIButton *)btn {
    // 自加 、更新数量 、减号按钮可点击
    _cnt++;
    _minusBtn.enabled = YES;
    
    NSString *cntStr = [NSString stringWithFormat:@" x %ld",_cnt];
    [self.cntBtn setTitle:cntStr forState:(UIControlStateNormal)];
}




@end
