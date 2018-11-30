//
//  RBSingleInputView.h
//  JHVerificationCodeView
//
//  Created by RaoBo on 2018/1/26.
//  Copyright © 2018年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinshBlock)(NSString *codeStr);
@interface RBSingleInputView : UIView
/**输入完成的回调*/
@property(nonatomic, copy) FinshBlock finshBlock;

/**是否以密码形式显示*/
@property(nonatomic, assign) BOOL isShowByPassword;

/**1-29输入的字符串 block回调有问题*/
@property(nonatomic, strong) NSString *inputString;

@end
