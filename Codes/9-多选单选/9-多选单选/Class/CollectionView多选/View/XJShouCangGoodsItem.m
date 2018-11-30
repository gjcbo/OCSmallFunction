//
//  XJShouCangGoodsItem.m
//  XinJiangMall
//
//  Created by RaoBo on 2018/5/14.
//  Copyright © 2018年 Tzyang. All rights reserved.
//  收藏的商品item

#import "XJShouCangGoodsItem.h"

//Model
#import "XJShouCangGoodsModel.h"

@interface XJShouCangGoodsItem()
@property (nonatomic, strong) UIView *bgView; //1.背景view
@property(nonatomic, strong) UIImageView *goodsIV;//2.商品图片
@property(nonatomic, strong) UILabel *goodsNameLb;//3.商品名
@property(nonatomic, strong) UILabel *goodsPriceLb;//4.价格
@property(nonatomic, strong) UILabel *goodsOriginPriceLb; // 5.原价(高价)

/**6.圆形选中按钮*/
@property(nonatomic, strong) UIButton *dotBtn;
@end

@implementation XJShouCangGoodsItem
#pragma mark - 一 lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

- (UIImageView *)goodsIV {
    if (!_goodsIV) {
        _goodsIV = [UIImageView new];
        _goodsIV.layer.masksToBounds = YES;
        _goodsIV.layer.cornerRadius = 5;
    }
    return _goodsIV;
}

- (UILabel *)goodsNameLb {
    if (!_goodsNameLb) {
        _goodsNameLb = [UILabel new];
        _goodsNameLb.numberOfLines = 0;
    }
    return _goodsNameLb;
}

- (UILabel *)goodsPriceLb {
    if (!_goodsPriceLb) {
        _goodsPriceLb = [UILabel new];
        _goodsPriceLb.textColor = [UIColor redColor];
        _goodsPriceLb.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsPriceLb;
}
- (UILabel *)goodsOriginPriceLb {
    if (!_goodsOriginPriceLb) {
        _goodsOriginPriceLb = [UILabel new];
        _goodsOriginPriceLb.font = [UIFont systemFontOfSize:13.0];
        _goodsOriginPriceLb.textColor = [UIColor lightGrayColor];
        _goodsOriginPriceLb.textAlignment = NSTextAlignmentRight;
    }
    return _goodsOriginPriceLb;
}
- (UIButton *)dotBtn {
    if (!_dotBtn) {
        _dotBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _dotBtn.hidden = YES; // 默认隐藏
        [_dotBtn setImage:[UIImage imageNamed:@"selected_off"] forState:(UIControlStateNormal)];
        [_dotBtn setImage:[UIImage imageNamed:@"selected_on"] forState:(UIControlStateSelected)];
    }
    return _dotBtn;
}



#pragma mark - 二 init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.goodsIV];
    [self.bgView addSubview:self.goodsNameLb];
    [self.bgView addSubview:self.goodsPriceLb];
    [self.bgView addSubview:self.goodsOriginPriceLb];
    [self.bgView addSubview:self.dotBtn];
}

#pragma mark - 三 layout

//((kWidth-4)/2,280)
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    [self.goodsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(175, 175));
    }];
    
    
    //商品名字
    [self.goodsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsIV.mas_bottom).offset(2);
        make.left.equalTo(self.bgView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    
    //价格
    [self.goodsPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(8);
        make.top.equalTo(self.goodsNameLb.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    //现价
    [self.goodsOriginPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsNameLb.mas_bottom).offset(5);
        make.right.equalTo(self.bgView.mas_right).offset(-8);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    // 选中取消选中小圆点
    [self.dotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.equalTo(self.bgView.mas_top).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
    }];
//    self.dotBtn.frame = CGRectMake(self.frame.size.width - 50 ,20 , 30, 30);
}

- (void)setModel:(XJShouCangGoodsModel *)model {
    _model = model;
    
    [self.goodsIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.goodsPriceLb.text = [NSString stringWithFormat:@"￥%.2f",(float)[model.price integerValue]];
    self.goodsNameLb.text = model.name;
    self.goodsOriginPriceLb.text = [NSString stringWithFormat:@"￥%0.2f",(float)[model.market_price integerValue]];
    
    self.dotBtn.selected = model.isScgoosModelSelected; //✅
}

#pragma mark - 是否显示选中小圆点
- (void)rb_showDotButtonWithState:(BOOL)isEditing{
// 如果是编辑状态:显示圆点。
    if (isEditing) {
        self.dotBtn.hidden = NO;
        self.dotBtn.selected = YES;
    }else {
        self.dotBtn.hidden = YES;
        self.dotBtn.selected = NO;
    }
}

- (void)xjscgoodsItem_showOrHideSelectedBtnWithState:(BOOL)state {
    self.dotBtn.hidden = !state;
}

#pragma mark - 四 回调事件



@end
