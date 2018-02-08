//
//  SectionHeaderView.m
//  整理服务器返回数据
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//  自定义区头

#import "SectionHeaderView.h"
#import "UIColor+Hex.h"

@interface SectionHeaderView()
/**左边日期label*/
@property(nonatomic, strong) UILabel *dateLabel;
/**右边次数label*/
@property(nonatomic, strong) UILabel *timesLabel;

@end

@implementation SectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
   // 左边日期label
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.textColor = [UIColor rb_convertToRGBColorWithHexValue:0x3d8dfc];
    [self.contentView addSubview:self.dateLabel];
    
    // 右边次数label
    self.timesLabel = [[UILabel alloc] init];
    self.timesLabel.textColor = [UIColor rb_convertToRGBColorWithHexValue:0x3d8dfc];
    self.timesLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timesLabel];
}


#pragma mark - 布局
- (void)layoutSubviews{
    // 必须调用super方法，不然self.contentView的frame为(0,0,0,0)
    [super layoutSubviews];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    self.dateLabel.frame = CGRectMake(10, 0, 150, h);

    self.timesLabel.frame = CGRectMake(200, 0, w-200, h);
}

#pragma mark - 赋值
- (void)rbSetDateStr:(NSString *)dateStr timesStr:(NSString *)timeStr{
    self.dateLabel.text = dateStr;
    self.timesLabel.text = timeStr;
}

@end
