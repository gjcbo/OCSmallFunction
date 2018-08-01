//
//  RBDownCell.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBDownCell.h"
@interface RBDownCell()

@property (nonatomic, strong) UIView *bgView; //背景view
/**姓名lb*/
@property (nonatomic, strong) UILabel *nameLb;
/**倒计时时间lb*/
@property (nonatomic, strong) UILabel *countTimeLb;


/**备份 model*/
@property (nonatomic, strong) RBDownModel *tempModel;
/**备份 indexPath */
@property (nonatomic, strong) NSIndexPath *tempIndexPath;


@end

@implementation RBDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 一 init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
        
        [self defaultConfigure];
    }
    return self;
}

- (void)defaultConfigure {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self registerNotification];
}


- (void)setupView {
 
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLb];
    [self.bgView addSubview:self.countTimeLb];
}

#pragma mark - 二 layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.bgView.sd_layout.leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    self.nameLb.sd_layout.leftSpaceToView(self.bgView, 10)
    .centerYEqualToView(self.bgView)
    .heightIs(40)
    .widthIs(100);
    
    self.countTimeLb.sd_layout.leftSpaceToView(self.nameLb, 10)
    .rightSpaceToView(self.bgView, 10)
    .centerYEqualToView(self.bgView)
    .heightIs(40);
}

#pragma mark - 三 lazy
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}
- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        _nameLb.text = @"张三";
        _nameLb.backgroundColor = [UIColor lightGrayColor];
    }
    return _nameLb;
}
- (UILabel *)countTimeLb {
    if (!_countTimeLb) {
        _countTimeLb = [UILabel new];
        _countTimeLb.text = @"13:03:33";
        _countTimeLb.backgroundColor = [UIColor yellowColor];
    }
    return _countTimeLb;
}

#pragma mark - 四 赋值
- (void)configureDownCellWithModel:(RBDownModel *)model indexPath:(NSIndexPath *)indexPath {
    self.nameLb.text = model.titleStr;
    self.countTimeLb.text = [model currentTimeString];
    
    //备份
    self.tempModel = model;
    self.tempIndexPath = indexPath;
}


#pragma mark - 五 注册/移除通知

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterEvent) name:kRBDownCellNotification object:nil];
}
- (void)notificationCenterEvent {
    //不停的给cell赋值。每过1秒计时器时间-1
    [self configureDownCellWithModel:self.tempModel indexPath:self.tempIndexPath];
}
- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRBDownCellNotification object:nil];
}


- (void)dealloc {
    NSLog(@"%s---销毁了",__FUNCTION__);
    
    [self removeNotification];
}
@end
