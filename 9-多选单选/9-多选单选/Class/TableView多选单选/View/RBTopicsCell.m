//
//  RBTopicsCell.m
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBTopicsCell.h"
@interface RBTopicsCell()
@property (nonatomic, strong) UIView *bgView; //背景view

/**1.图标*/
@property (nonatomic, strong) UIImageView *iconIv;
/**2.姓名*/
@property (nonatomic, strong) UILabel *nameLb;
/**3.帖子内容*/
@property (nonatomic, strong) UILabel *topicsContentLb;

@end

@implementation RBTopicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 一 lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

- (UIImageView *)iconIv {
    if (!_iconIv) {
        _iconIv = [UIImageView new];
        _iconIv.layer.masksToBounds = YES;
        _iconIv.layer.cornerRadius = 20;
    }
    return _iconIv;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
    }
    return _nameLb;
}
- (UILabel *)topicsContentLb{
    if (!_topicsContentLb) {
        _topicsContentLb = [UILabel new];
    }
    return _topicsContentLb;
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectButton setImage:[UIImage imageNamed:@"selected_off"] forState:(UIControlStateNormal)];
        [_selectButton setImage:[UIImage imageNamed:@"selected_on"] forState:UIControlStateSelected]; // 注意这里是控制选中状态。 Selected 
        
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _selectButton.hidden = YES; //默认隐藏在 format中根据是否处于编辑状态进行修改
    }
    return _selectButton;
}

#pragma mark - 二 init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.bgView];
    
    [self.bgView addSubview:self.iconIv];
    [self.bgView addSubview:self.nameLb];
    [self.bgView addSubview:self.topicsContentLb];
    [self.bgView addSubview:self.selectButton];
}

#pragma mark - 三 layout

//h:60
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    CGFloat k15 = 15.0;
    CGFloat k10 = 10.0;
    
    
    //(30,30)
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(k15);
        make.centerY.equalTo(self.bgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconIv.mas_right).offset(k10);
        make.top.equalTo(self.bgView).offset(5);
        make.size.mas_equalTo(CGSizeMake(150, 21));
    }];
    
    [self.topicsContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.equalTo(self.iconIv.mas_right).offset(k10);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.bgView.mas_right).offset(-k10);
    }];    
}

#pragma mark - 四 回调事件
- (void)selectButtonAction:(UIButton *)button {
    NSLog(@"点击了按钮");
}

#pragma mark - 五 赋值
- (void)setTopicModel:(RBTopicsModel *)topicModel {
    _topicModel = topicModel;
    
    [self.iconIv sd_setImageWithURL:[NSURL URLWithString:topicModel.avatar]];
    
    self.nameLb.text = topicModel.publish_name;
    self.topicsContentLb.text = topicModel.content;
    
    self.selectButton.selected = topicModel.isSelected;
}





@end
