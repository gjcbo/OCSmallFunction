//
//  RBHotView.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBHotView.h"



@interface RBHotView()
/**作用:*/
@property(nonatomic, strong) UILabel *lastTagLabel;

/**作用:显示 '热门搜索' 四个字*/
@property(nonatomic, strong) UILabel *hotSearhcLabel;


@end
@implementation RBHotView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    }
    return self;
}

#pragma mark - lazy
- (UILabel *)hotSearhcLabel {
    if (!_hotSearhcLabel) {
        _hotSearhcLabel = [UILabel new];
        _hotSearhcLabel.text = @"热门搜索";
        _hotSearhcLabel.textColor = [UIColor blackColor];
    }
    return _hotSearhcLabel;
}

#pragma mark - hotTagArray;


//- (void)setHotTagArray:(NSArray *)hotTagArray {
//    _hotTagArray = hotTagArray;
//
//    for (int i = 0; i<hotTagArray.count; i++) {
//        NSString *textStr = hotTagArray[i];
//
//        UILabel *label = [[UILabel alloc] init];
//        label.text = textStr;
//
//       CGSize labelSize = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
//
//
//
//    }
//}
// 作用:1.动态创建热门标签Label,2.赋值 3.动态摆放位置 4.计算self的frame
- (void)setHotTagArray:(NSArray *)hotTagArray {

    

    _hotTagArray = hotTagArray;

    // 如果数组为空,什么不做,直接返回
    if (hotTagArray.count == 0) {
        self.hidden = YES;
        return;
    }


    self.hidden = NO;
    // 热门搜索标签
    self.hotSearhcLabel.frame = CGRectMake(10, 0, self.frame.size.width, 20);
    [self addSubview:self.hotSearhcLabel];


    // 作用:
    _lastTagLabel = nil;


    for (int i = 0; i<hotTagArray.count; i++) {
        UILabel *tagLabel = [UILabel new];
        tagLabel.backgroundColor = [UIColor lightGrayColor];

        NSString *textStr = hotTagArray[i];
        tagLabel.text = textStr;
        tagLabel.font = kTagFont;
        

        // 根据文字计算 文字所占的size
        CGSize tagLabelSize = [textStr sizeWithAttributes:@{NSFontAttributeName:kTagFont}];
//        CGFloat t_w = tagLabelSize.width+20;
//        CGFloat t_h = tagLabelSize.height+10;
        
        CGFloat t_w = tagLabelSize.width;
        CGFloat t_h = tagLabelSize.height;

//        NSLog(@"%f===%f",t_w,t_h);



        // 作用？
        if (i==0) {
            tagLabel.frame = CGRectMake(kTagScreen_margin, 20 + kTagVertical_margin, t_w, t_h);
        }else{
            // 计算第下一个标签的frame
            // x轴最左边 + 间距 + 自己的屏宽 > self 的屏宽 ---》说明需要换行。
            CGFloat right = CGRectGetMaxX(_lastTagLabel.frame) + kTagHorizontal_margin + t_w;


            if (right > self.frame.size.width) { // 换行

                tagLabel.frame = CGRectMake(kTagScreen_margin, CGRectGetMaxY(_lastTagLabel.frame) + kTagVertical_margin, t_w, t_h);
            }else { // 同一行
                tagLabel.frame = CGRectMake(CGRectGetMaxX(_lastTagLabel.frame)+kTagHorizontal_margin, CGRectGetMinY(_lastTagLabel.frame), t_w, t_h);
            }
        }


        [self addSubview:tagLabel];

        tagLabel.font = kTagFont;
        NSLog(@"%@",NSStringFromCGRect(tagLabel.frame));
        _lastTagLabel = tagLabel;
        NSLog(@"张三:%@",NSStringFromCGRect(tagLabel.frame));


        // 作用: 根据最有一个tagLabl 的frame 计算 self的高度。动态显示其高度
        if (i == hotTagArray.count -1) {
            CGRect tempFrame = self.frame;

           CGFloat bottom = CGRectGetMaxY(_lastTagLabel.frame);
            tempFrame.size.height = bottom + kTagVertical_margin;

            self.frame = tempFrame;
        }
    }

}

@end
