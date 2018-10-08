//
//  ByMuJuView.m
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ByMuJuView.h"
@interface ByMuJuView()
@property (nonatomic, strong) UIButton *rectBtn; //方形
@property (nonatomic, strong) UIButton *circleBtn;//圆形
@property (nonatomic, strong) UIButton *hollowCircleBtn;//空心圆
@end

@implementation ByMuJuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.rectBtn];
    [self addSubview:self.circleBtn];
    [self addSubview:self.hollowCircleBtn];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat wh = 40;
    
    CGFloat self_w = self.frame.size.width;
    CGFloat kMargin = (self_w - wh*3) / 2;
    CGFloat self_h = self.frame.size.height;
    CGFloat y = (self_h - wh) * 0.5;
    self.rectBtn.frame = CGRectMake(0, y, wh, wh);
    CGFloat x1 = wh + kMargin;
    self.circleBtn.frame = CGRectMake(x1, y, wh, wh);
    CGFloat x2 = (wh + kMargin)*2;
    self.hollowCircleBtn.frame = CGRectMake(x2, y, wh, wh);
}

- (UIButton *)customBtnWithImageStr:(NSString *)imgStr target:(id)target sel:(SEL)sel {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    //设置图片
    UIImage *img = [UIImage imageNamed:imgStr];
    [btn setImage:img forState:(UIControlStateNormal)];
    
    //添加点击事件
    [btn addTarget:target action:sel forControlEvents:(UIControlEventTouchUpInside)];

    return btn;
}

#pragma mark - lazy
- (UIButton *)rectBtn {
    if (!_rectBtn) {
        _rectBtn = [self customBtnWithImageStr:@"fbzpamjdf" target:self sel:@selector(rectBtnAction:)];
    }
    return _rectBtn;
}
- (UIButton *)circleBtn {
    if (!_circleBtn) {
        _circleBtn = [self customBtnWithImageStr:@"fbzpamjdy" target:self sel:@selector(circleBtnAction:)];
    }
    return _circleBtn;
}

- (UIButton *)hollowCircleBtn {
    if (!_hollowCircleBtn) {
        _hollowCircleBtn = [self customBtnWithImageStr:@"fbzpamjkxy" target:self sel:@selector(hollowCircleBtnAction:)];
    }
    return _hollowCircleBtn;
}

#pragma mark - 事件监听
- (void)rectBtnAction:(UIButton *)btn {
    NSLog(@"方形 %s---%d",__FUNCTION__, __LINE__);
    [JRToast showWithText:@"ByMuJuView:方形"];
    
    //第一次：事件回调机制。传递出去
    if (self.byMuJuViewClickRectBlock) {
        self.byMuJuViewClickRectBlock();
    }
}

- (void)circleBtnAction:(UIButton *)btn {
    NSLog(@"圆形 %s---%d",__FUNCTION__, __LINE__);
    [JRToast showWithText:@"ByMuJuView:圆形"];
    
    if (self.byMuJuViewClickCircleBlock) {
        self.byMuJuViewClickCircleBlock();
    }
}

- (void)hollowCircleBtnAction:(UIButton *)btn {
    NSLog(@"空心圆 %s---%d",__FUNCTION__, __LINE__);
    [JRToast showWithText:@"ByMuJuView:空心圆形"];
    
    if (self.byMuJuViewClickHollowCircleBlock) {
        self.byMuJuViewClickHollowCircleBlock();
    }
}


@end
