//
//  RBHotViewByCategory.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBHotViewByCategory.h"
#import "UIView+Extension.h"
@interface RBHotViewByCategory()
@property(nonatomic, strong) UILabel *lastTagLabel;

@property(nonatomic,strong) UIView *bgView;

@end

@implementation RBHotViewByCategory
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
    }
    return self;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}


- (void)setHotTagArray:(NSArray *)hotTagArray {
    _hotTagArray = hotTagArray;
    
    
    // 初始化
    _lastTagLabel = nil;
    self.hidden = NO;
    
    for (int i=0; i<hotTagArray.count; i++) {
        NSString *textStr = hotTagArray[i];
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor lightGrayColor];
        label.text = textStr;
        label.font = kTagFont;
        
        // 根据文字长度和字体 计算文字的size
        CGSize textSize = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
        
        CGFloat t_w = textSize.width;
        CGFloat t_h = textSize.height;
        
        if (0 == i) { // 先确定第一label的位置
            label.frame = CGRectMake(kTagScreen_margin, 0, t_w, t_h);
        }else {
            CGFloat right = _lastTagLabel.rb_right + kTagHorizontal_margin + t_w;
            
            if (right > self.frame.size.width) { // 换行
                label.frame = CGRectMake(kTagScreen_margin, _lastTagLabel.rb_bottom+kTagVertical_margin, t_w, t_h);
            }else {
                label.frame = CGRectMake(_lastTagLabel.rb_right+kTagHorizontal_margin, _lastTagLabel.rb_y, t_w, t_h);
            }
        }
        
        
        [self.bgView addSubview:label];
        
        _lastTagLabel = label;
        
        // 根据最后一个 label的frame 计算self 的高度
        if (i == hotTagArray.count -1) {
            CGRect tempFrame = self.frame;
            tempFrame.size.width = _lastTagLabel.rb_bottom;
            self.frame = tempFrame;
            self.bgView.frame= tempFrame;
            
            self.bgView.backgroundColor = [UIColor redColor];
        }
    }
}


@end
