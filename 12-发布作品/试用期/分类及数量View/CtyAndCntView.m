//
//  CtyAndCntView.m
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  分类以及数量view
//  高度: 200
#import "CtyAndCntView.h"
#import "ZYSegmentedControl.h"
#import "ByMuJuView.h" //按模具view
#import "ByQuantity.h" //按数量view
#import "UIButton+Extension.h" //修改UIButton 的 文字和图片的位置。

@interface CtyAndCntView()
@property (nonatomic, strong) UILabel *titleLb; //标题 “分类以及分量”
@property (nonatomic, strong) UIButton *btn; //按钮, 先写个死的。
//@property (nonatomic, strong)
@property (nonatomic, strong) ZYSegmentedControl *segControl; //分段控件

//一次性都贴上，控制hidden 。
@property (nonatomic, strong) ByMuJuView *mujuView; //按模具
@property (nonatomic, strong) ByQuantity *quantity; //按数量

@end

@implementation CtyAndCntView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


//添加子控件
- (void)setupView {
    CGFloat kMargin10 = 10;
    //布局frame
    self.titleLb.frame = CGRectMake(10, 0, 150, 30);
    
    CGFloat x1 = (kScreen_W - 200)*0.5;
    CGFloat y1 = CGRectGetMaxY(self.titleLb.frame) + kMargin10;
    self.btn.frame = CGRectMake(x1, y1, 200, 30);
    //修改UIButton 的 文字 图片位置(左文字+右图片)
    [self.btn leftTextRightImageWithMargin:0];

    CGFloat x2 = (kScreen_W - 200)*0.5;
    CGFloat y2 = CGRectGetMaxY(self.btn.frame) + kMargin10 ;
    self.segControl.frame = CGRectMake(x2, y2, 200, 40);
    
    CGFloat x3 = (kScreen_W - 200) * 0.5;
    CGFloat y3 = CGRectGetMaxY(self.segControl.frame) + kMargin10;
    self.mujuView.frame = CGRectMake(x3, y3, 200, 50);
    self.quantity.frame = CGRectMake(x3, y3, 200, 50);
    
    
    //添加到父视图
    [self addSubview:self.titleLb];
    [self addSubview:self.btn];
    [self addSubview:self.segControl];
    [self addSubview:self.mujuView];
    [self addSubview:self.quantity];
    
    //默认显示视图是
    self.mujuView.hidden = NO;
    self.quantity.hidden = YES;
}


#pragma mark - lazy
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"分类及分量：";
    }
    return _titleLb;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btn setTitle:@"面包" forState:(UIControlStateNormal)];
        [_btn setTitleColor:[UIColor brownColor] forState:(UIControlStateNormal)];
        [_btn setImage:[UIImage imageNamed:@"上下.png"] forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

- (ZYSegmentedControl *)segControl {
    if (!_segControl) {
        NSArray *itemsArr = @[@"按模具",@"按个数"];
        _segControl = [[ZYSegmentedControl alloc] initWithItems:itemsArr target:self sel:@selector(segControlAction:)];
        _segControl.layer.cornerRadius = 10;
        _segControl.layer.masksToBounds = YES;
    }
    return _segControl;
}

- (ByMuJuView *)mujuView {
    if (!_mujuView) {
        _mujuView = [[ByMuJuView alloc] init];
//        _mujuView.backgroundColor = [UIColor brownColor];
    }
    return _mujuView;
}
- (ByQuantity *)quantity {
    if (!_quantity) {
        _quantity = [[ByQuantity alloc] init];
        _quantity.backgroundColor = [UIColor redColor];
    }
    return _quantity;
}

#pragma mark - 事件监听
- (void)clickBtnAction:(UIButton *)btn {
    NSLog(@"点击了按钮");
    [JRToast showWithText:@"点击了按钮"];
}

- (void)segControlAction:(ZYSegmentedControl *)segControl {
    NSLog(@"点击了分段控制，选中的下表:%ld",segControl.selectedSegmentIndex);
    
    switch (segControl.selectedSegmentIndex) {
        case 0:
            self.mujuView.hidden = NO;
            self.quantity.hidden = YES;
            break;
        case 1:
        {
            self.mujuView.hidden = YES;
            self.quantity.hidden = NO;
        }break;
        default:
            break;
    }
}
@end
