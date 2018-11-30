//
//  HeaderView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
/**1.封面*/
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *titleLb;///2.标题Lb
@property (nonatomic, strong) UITextView *titleTV;///3.标题TF //28个字符号以内
@property (nonatomic, strong) UILabel *sumaryLb;//3.作品摘要
@property (nonatomic, strong) UITextView *sumaryTV; //作品再要输入框 500个字符


@end

@implementation HeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iv.frame = self.bounds;
        [self addSubview:self.iv];
    }
    
    
    return self;
}

#pragma mark - getter
- (UIImageView *)iv {
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点击添加图片.png"]];
        _iv.userInteractionEnabled = YES;
        //事件监听
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgAction)];
        [_iv addGestureRecognizer:tap];
    }
    return _iv;
}

#pragma mark  - 事件监听
- (void)tapImgAction {
//    NSLog(@"%s--%d",__func__,__LINE__);
    //回调
    if (self.headerViewBlock) {
        self.headerViewBlock(_iv);
    }
}
@end
