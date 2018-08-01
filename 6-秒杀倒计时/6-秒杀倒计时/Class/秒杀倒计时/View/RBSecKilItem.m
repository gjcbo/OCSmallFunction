//
//  RBSecKilItem.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBSecKilItem.h"
#import "RBSecKillModel.h"
#import "UILabel+CountDown.h"

@interface RBSecKilItem()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconIv; //图片
@property (nonatomic, strong) UILabel *nameLb; //商品名字
@property (nonatomic, strong) UILabel *priceLb; //原价
@property (nonatomic, strong) UILabel *seckillLb; //秒杀label


/**临时记录*/
@property (nonatomic, strong) RBSecKillModel *tempSeckillM;
/**临时记录*/
@property (nonatomic, strong) NSIndexPath *tempIndexPath;

@end

@implementation RBSecKilItem

#pragma mark - 一 lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImageView *)iconIv {
    if (!_iconIv) {
        _iconIv = [[UIImageView alloc] init];
    }
    return _iconIv;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        _nameLb.text = @"草房子";
    }
    return _nameLb;
}

- (UILabel *)priceLb {
    if (!_priceLb) {
        _priceLb = [UILabel new];
        _priceLb.text = @"12.0";
    }
    return _priceLb;
}

- (UILabel *)seckillLb {
    if (!_seckillLb) {
        _seckillLb = [UILabel new];
        _seckillLb.text = @"00:15:20";
        _seckillLb.backgroundColor = [UIColor blueColor];
    }
    return _seckillLb;
}

#pragma mark - 二 init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        [self registerNotification];
    }
    return self;
}

- (void)setupView {
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.iconIv];
    [self.bgView addSubview:self.nameLb];
    [self.bgView addSubview:self.priceLb];
    [self.bgView addSubview:self.seckillLb];
}

#pragma mark - 三 layout
// 总高度 h: 300
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgView.sd_layout.leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    
    //h: 200
    self.iconIv.sd_layout.leftEqualToView(self.bgView)
    .rightEqualToView(self.bgView)
    .topEqualToView(self.bgView)
    .heightIs(180);
    
    //距上间距 10
    self.nameLb.sd_layout.topSpaceToView(self.iconIv, 10)
    .leftSpaceToView(self.bgView, 10)
    .rightSpaceToView(self.bgView, 10)
    .heightIs(30);
    
    self.priceLb.sd_layout.topSpaceToView(self.nameLb, 10)
    .leftSpaceToView(self.bgView, 10)
    .rightSpaceToView(self.bgView, 10)
    .heightIs(22);
    
    
    self.seckillLb.sd_resetLayout.leftSpaceToView(self.bgView, 10)
    .rightSpaceToView(self.bgView, 10)
    .centerYEqualToView(self.bgView)
    .heightIs(50);
}

#pragma mark - 四 赋值
- (void)configureSecKillItemWithModel:(RBSecKillModel *)model indexPath:(NSIndexPath *)indexPath {
    
    //临时记录
    self.tempSeckillM = model;
    self.tempIndexPath = indexPath;
    
    self.iconIv.image = [UIImage imageNamed:model.cover]; //使用的是本地图片
    self.nameLb.text = model.name;
    self.priceLb.text = model.price;
    
    NSString *timeStr = [model seckillCurrentTimeString];
    [self.seckillLb setupCountDownTite:timeStr height:40];
}



#pragma mark - 五 接收通知、销毁通知
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:kRBSecKillCellNotificatio object:nil];
}

- (void)removeNotification  {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRBSecKillCellNotificatio object:nil];
}

//做什么事情: 不停的model的值
- (void)notificationAction {
    [self configureSecKillItemWithModel:self.tempSeckillM indexPath:self.tempIndexPath];
}

- (void)dealloc {
    NSLog(@"%s 销毁了",__func__);
    [self removeNotification];
}
@end
