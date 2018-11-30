//
//  NestStepCell.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "NestStepCell.h"
@interface NestStepCell()
@property (weak, nonatomic) IBOutlet UIImageView *iv; //点击添加图片
@property (weak, nonatomic) IBOutlet UITextView *tv; //内容描述TextView
@end

@implementation NestStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //占位文字和字数限制
    self.tv.zw_placeHolder = @"写下这步需要的材料、时间和制作要点";
    self.tv.zw_limitCount = 200;
    self.tv.scrollEnabled = NO;
    
    //图片添加点击事件
    _iv.userInteractionEnabled = YES;
    //事件监听
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgAction)];
    [_iv addGestureRecognizer:tap];
}

- (void)tapImgAction {
    [self selectedPicAlert];
}

- (void)selectedPicAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择一张封面" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *paizhao = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
    }];
    UIAlertAction *xiangce  = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"从相册中选择");
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alertVC addAction:paizhao];
    [alertVC addAction:xiangce];
    [alertVC addAction:cancel];
    
    //弹出来
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:alertVC animated:YES completion:nil];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
