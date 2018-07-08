//
//  XJBottomView.m
//  Clv全选
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "XJBottomView.h"
@interface XJBottomView()

/**全选*/
@property(nonatomic, strong) UIButton  *leftBtn;
/**删除*/
@property(nonatomic, strong) UIButton *rightBtn;
@end
@implementation XJBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // frame (0,0,屏宽,50)
    self.backgroundColor = [UIColor whiteColor];

    CGFloat kMargin = 10;
    CGFloat btn_w = 70;
    CGFloat btn_h = 50;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    // 左边全选按钮
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.frame = CGRectMake(kMargin *2, 0,btn_w, btn_h);
    [self addSubview:self.leftBtn];

    [self.leftBtn setImage:[UIImage imageNamed:@"selected_off"] forState:(UIControlStateNormal)];
    [self.leftBtn setImage:[UIImage imageNamed:@"selected_on"] forState:(UIControlStateSelected)]; // 需要在点击事件中切换btn的状态不然这个图片不显示。
    [self.leftBtn setTitle:@"全选" forState:(UIControlStateNormal)];
    [self.leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 右边删除按钮
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.frame = CGRectMake(kWidth - btn_w*1.5 -kMargin, btn_h*0.1, btn_w*1.5, btn_h*0.6);
    [self addSubview:self.rightBtn];
    
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.rightBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
    [self.rightBtn setBackgroundColor:[UIColor redColor]];
    [self.rightBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = 10;

    [self.rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - 二 按钮点击事件
- (void)clickLeftBtn:(UIButton *)leftBtn {
    
    // 切换btn选中状态
    leftBtn.selected = !leftBtn.selected;

    if (self.xjAllSeletedBlock) {
        self.xjAllSeletedBlock(leftBtn.selected);
    }
}

- (void)clickRightBtn:(UIButton *)rightBtn {
    if (self.xjDeleBlock) {
        self.xjDeleBlock();
    }
}

#pragma mark - 三 setter

// 逻辑混乱了。
- (void)setXx_isAll:(BOOL)xx_isAll {
    _xx_isAll = xx_isAll;
    
    if (xx_isAll) {
        self.leftBtn.selected = YES;
    }else {
        self.leftBtn.selected = NO;
    }
}

@end
