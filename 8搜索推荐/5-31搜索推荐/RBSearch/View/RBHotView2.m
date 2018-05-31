//
//  RBHotView2.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBHotView2.h"
#import "UIView+Extension.h"
@interface RBHotView2()
@property(nonatomic, strong) UILabel *lastLabel;

@end

@implementation RBHotView2
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    _lastLabel = nil;
    
    for (int i=0; i<dataArray.count; i++) {
        UILabel *label = [UILabel new];
        label.font = kTagFont;
        NSString *textStr = dataArray[i];
        label.text = textStr;
        label.backgroundColor = [UIColor lightGrayColor];
        
        // 根据文字计算文字的size
        CGSize size = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
        
        CGFloat w = size.width;
        CGFloat h = size.height;
        
        // 外界一定要赋值。
        CGFloat self_W = self.frame.size.width;
        
        
        //先确定第一个label的frame
        if (i==0) {
            label.frame = CGRectMake(kTagScreen_margin, 0, w, h);
        }else {
            CGFloat right =   _lastLabel.rb_right + kTagHorizontal_margin + w;
            if (right > self_W) { // 换行
                label.frame = CGRectMake(kTagScreen_margin, _lastLabel.rb_bottom + kTagVertical_margin, w, h);
            }else {
                label.frame = CGRectMake(_lastLabel.rb_right+kTagHorizontal_margin, _lastLabel.rb_y, w, h);
            }
            
        }
        
        [self addSubview:label];
        _lastLabel = label;
        
        
        // 根据最后一个Label的frame 计算self的frame
        if (i == dataArray.count -1) {
            CGRect tempFrame = self.frame;
            tempFrame.size.height = label.rb_bottom;
            self.frame = tempFrame;
        }
    }
}

@end


































