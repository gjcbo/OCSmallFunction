//
//  CtyAndQuantityCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  第4个cell 分类和数量:
// 高度 160 
#import "CtyAndQuantityCell.h"
@interface CtyAndQuantityCell()
@property (nonatomic, strong) UILabel *ctyAndQuantityLb;//分类以及数量lb
@property (nonatomic, strong) UIView *tempView;

@end

@implementation CtyAndQuantityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupView {
    
    self.ctyAndQuantityLb.frame = CGRectMake(10, 10, 100, 30);
    self.tempView.frame = CGRectMake(10, 50, kScreen_W - 20, 100);
    
    [self.contentView addSubview:self.ctyAndQuantityLb];
    [self.contentView addSubview:self.tempView];
    
}

#pragma mark - getter
- (UILabel *)ctyAndQuantityLb {
    if (!_ctyAndQuantityLb) {
        _ctyAndQuantityLb = [[UILabel alloc] init];
        _ctyAndQuantityLb.text = @"分类及数量:";
    }
    return _ctyAndQuantityLb;
}

//高度自定义view
- (UIView *)tempView {
    if (!_tempView) {
        _tempView = [UIView new];
        _tempView.backgroundColor = [UIColor lightGrayColor];
        UILabel *tempLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        tempLb.text = @"临时占位";
        [_tempView addSubview:tempLb];
    }
    return _tempView;
}
@end
