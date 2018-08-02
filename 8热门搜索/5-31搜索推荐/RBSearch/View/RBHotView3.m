//
//  RBHotView3.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBHotView3.h"
#import "UIView+Extension.h"
#import <Masonry.h>

@interface RBHotView3()
@property(nonatomic, strong) UILabel *lastLabel;
@property(nonatomic, strong) UILabel *tipLabel;// '热门搜索'文字

@end
@implementation RBHotView3

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    
    // 热门搜索
    self.tipLabel.frame = CGRectMake(kTagScreen_margin, 0, self.frame.size.width, 20);
    [self addSubview:self.tipLabel];
    
    _lastLabel = nil;
    
    for (int i = 0; i<dataArray.count; i++) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        
        label.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:label];

        
        NSString *textStr = dataArray[i];
        
        label.text = textStr;
        label.font = kTagFont;
        
        // 获取字符串对应的size
        CGSize size = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
        CGFloat w = size.width + kTagHorizontal_margin;
        CGFloat h = size.height + kTagVertical_margin;
        
        
        // 设置label的frame
        if (0==i) { //先确定第一个的frame
            label.frame = CGRectMake(kTagScreen_margin , kTagVertical_margin + self.tipLabel.rb_bottom, w, h);
        }else {
            // 作用:最右边用于判断是否需要换行。
            CGFloat maxRight = _lastLabel.rb_right + kTagVertical_margin + w;
            if (maxRight > self.frame.size.width) { // 换行:下一行
                
                label.frame = CGRectMake(kTagScreen_margin, _lastLabel.rb_bottom+kTagVertical_margin, w, h);
            }else { // 同一行
                
                label.frame = CGRectMake(_lastLabel.rb_right+kTagHorizontal_margin, _lastLabel.rb_y, w, h);
            }
        }
    
        _lastLabel = label;
        
        
        // 根据最有一个label的frame 计算self的高度
        if (i == dataArray.count-1) {
            CGRect tempFrame = self.frame;
            tempFrame.size.height = _lastLabel.rb_bottom;
            self.frame  = tempFrame;
        }
        
    }
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"热门搜索";
        _tipLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _tipLabel;
}

@end
