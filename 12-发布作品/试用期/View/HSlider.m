//
//  HSlider.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "HSlider.h"
@interface HSlider()
@property (nonatomic, strong) UISlider *hSlider; //水平方向的slider
@end

@implementation HSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.hLb];
    [self addSubview:self.hSlider];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    [self.hSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(w-60);
    }];
    
    [self.hLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hSlider.mas_right).offset(5);
        make.top.bottom.right.equalTo(self);
    }];
}

#pragma mark - getter
- (UILabel *)hLb {
    if (!_hLb) {
        _hLb = [[UILabel alloc] init];
        
        _hLb.backgroundColor = [UIColor lightGrayColor];
        _hLb.text = @"50厘米";
        _hLb.font = [UIFont systemFontOfSize:12.0];
    }
    return _hLb;
}
- (UISlider *)hSlider {
    if (!_hSlider) {
        _hSlider = [[UISlider alloc] init];
        //事件监听
        [_hSlider addTarget:self action:@selector(hSliderAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _hSlider;
}

- (void)hSliderAction:(UISlider *)slider {
    if (self.hSliderBlock) {
        self.hSliderBlock(slider);
    }
    
    if ([self.delegate respondsToSelector:@selector(hSliderDidChangeValue:)]) {
        [self.delegate hSliderDidChangeValue:slider.value];
    }
}

@end
