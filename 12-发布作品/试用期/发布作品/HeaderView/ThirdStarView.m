//
//  ThirdStarView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
// h : 80

#import "ThirdStarView.h"
#import "XHStarRateView.h"
@interface ThirdStarView()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) XHStarRateView *starView; //星星
@property (nonatomic, strong) UILabel *descLb; //星星对应的描述
@end
@implementation ThirdStarView

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
    [self addSubview:self.starView];
    [self addSubview:self.descLb];
}

#pragma mark - lazy
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        _titleLb.text = @"难度评星：";
    }
    return _titleLb;
}
- (XHStarRateView *)starView {
    if (!_starView) {
        CGFloat x = (kScreen_W - 200) * 0.5 ;
        CGFloat y = 10 + 30;
        _starView = [[XHStarRateView alloc] initWithFrame:CGRectMake(x , y, 200, 30) completion:^(CGFloat currentScore) {
            _descLb.text = [NSString stringWithFormat:@"%.0f颗星",currentScore];
        }];
    }
    return _starView;
}

- (UILabel *)descLb {
    if (!_descLb) {
        CGFloat x = (kScreen_W - 200) * 0.5 ;
        CGFloat y = 70;
    
        _descLb = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 20)];
        _descLb.text = @"无";
        _descLb.font = [UIFont systemFontOfSize:12.0];
        _descLb.textAlignment = NSTextAlignmentCenter;
    }
    return _descLb;
}


@end
