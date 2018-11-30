
//
//  SatrCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//
//  h : 50
#import "SatrCell.h"
#import "XHStarRateView.h"
@interface SatrCell()
@property (nonatomic, strong) UILabel *hardLabel;//难度评星lb
@property (nonatomic, strong) XHStarRateView *starRateView; //星星view

@end

@implementation SatrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

//布局视图
- (void)setupView {
    [self.contentView addSubview:self.hardLabel];
    [self.contentView addSubview:self.starRateView];
    
    //重新修改frame : 居中
    CGFloat x = (kScreen_W - 200)/2 ;
    CGFloat y = CGRectGetMaxY(self.hardLabel.frame) + 10;
    CGRect starRateViewFrame = CGRectMake(x, y, 200, 30);
    self.starRateView.frame = starRateViewFrame;
}

#pragma mark - getter
- (UILabel *)hardLabel {
    if (!_hardLabel) {
        _hardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
        _hardLabel.text = @"难度评星:";
    }
    return _hardLabel;
}
- (XHStarRateView *)starRateView {
    if (!_starRateView) {
        // 一开始创建的时候 必须要设定一frame
        _starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 200, 30) completion:^(CGFloat currentScore) {
            NSLog(@"3----%f ",currentScore);
        }];
    }
    return _starRateView;
}

@end
