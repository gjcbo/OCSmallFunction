//
//  NewHeaderView.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "NewHeaderView.h"
#import "TitleView.h" // 70
#import "SumaryView.h" // 200
#import "ThirdStarView.h" //80
@interface NewHeaderView()
@property (nonatomic, strong) TitleView *titleV; //1.
@property (nonatomic, strong) SumaryView *sumV; //2.
@property (nonatomic, strong) ThirdStarView *starV; //3.

@end

@implementation NewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.iv];
    [self addSubview:self.titleV];
    [self addSubview:self.sumV];
    [self addSubview:self.starV];
}

#pragma mark - lazy
- (UIImageView *)iv {
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点击添加图片.png"]];
        _iv.frame = CGRectMake(0, 0, kScreen_W, 200);
        _iv.userInteractionEnabled = YES;
        //事件监听
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgAction)];
        [_iv addGestureRecognizer:tap];
    }
    return _iv;
}

- (TitleView *)titleV {
    if (!_titleV) {
        _titleV = [[TitleView alloc] initWithFrame:CGRectMake(0, 200, kScreen_W, 80)];
    }
    return _titleV;
}
- (SumaryView *)sumV {
    if (!_sumV) {
        _sumV = [[SumaryView alloc] initWithFrame:CGRectMake(0, 280, kScreen_W, 200)];
    }
    return _sumV;
}
- (ThirdStarView *)starV {
    if (!_starV) {
        _starV = [[ThirdStarView alloc] initWithFrame:CGRectMake(0, 470, kScreen_W, 80)];
    }
    return _starV;
}


#pragma mark  - 事件监听
- (void)tapImgAction {
    //    NSLog(@"%s--%d",__func__,__LINE__);
    //回调
//    if (self.headerViewBlock) {
//        self.headerViewBlock(_iv);
//    }
    
    [self selectedPicAlert];
}

#pragma mark - 选择图片弹框
- (void)selectedPicAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择一张封面" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *paizhao = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSLog(@"%s----%d 拍照",__FUNCTION__,__LINE__);
    
        if ([self.delegate respondsToSelector:@selector(fromPaiZhaoWithImageView:)]) {
            [self.delegate fromPaiZhaoWithImageView:self.iv];
        }
        
    }];
    UIAlertAction *xiangce  = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"从相册中选择");
        
        if ([self.delegate respondsToSelector:@selector(fromAlbumWithImageView:)]) {
            [self.delegate fromAlbumWithImageView:self.iv];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];

    [alertVC addAction:paizhao];
    [alertVC addAction:xiangce];
    [alertVC addAction:cancel];

    //弹出来
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@end
