//
//  RBSingleInputView.m
//  JHVerificationCodeView
//
//  Created by RaoBo on 2018/1/26.
//  Copyright © 2018年 HaoCold. All rights reserved.
//
//  单输入框view
#import "RBSingleInputView.h"
/**定义一个tag值,默认从10000开始*/
#define kSingleTFTag 10000

@interface RBSingleInputView()
/**不显示的UITextView,只用于输入内容*/
@property(nonatomic, strong) UITextView *noDisplayTextView;

@end

@implementation RBSingleInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"self.frame: %@",NSStringFromCGRect(frame));
        [self rbArrangeUI];
    }
    return self;
}

- (void)rbArrangeUI
{
    
 //1 2 3 4 5 6
    // 创建6个textField
// 间隔、宽度、高度(默认和self高度一致)
    CGFloat space = 5;
    
    CGFloat w = (self.frame.size.width - 5*space) / 6;
    CGFloat h = CGRectGetHeight(self.frame);
    
    for (int i=0; i<6; i++) {
        UITextField *singleTF = [[UITextField alloc] initWithFrame:CGRectMake((w+space)*i, 0, w, h)];
        singleTF.textAlignment = NSTextAlignmentCenter;
        singleTF.font = [UIFont systemFontOfSize:23.0];
        singleTF.textColor = [UIColor blackColor];
        singleTF.tag = kSingleTFTag + i;
        singleTF.borderStyle = UITextBorderStyleRoundedRect;
        singleTF.userInteractionEnabled = NO; // 禁用交互,给self添加手势调用键盘
        
        [self addSubview:singleTF];
    }
    
    
    self.noDisplayTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, h, 0, 0)];
//    self.noDisplayTextView.delegate = self;
    [self addSubview:self.noDisplayTextView];
    
    // 添加手势,调用键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rbShowKeyboardGestureAction)];
    [self addGestureRecognizer:tapGesture];
    
    // 注意通知的移除时机？什么时候移除通知。
    // 添加通知监听noDisplayTextView输入内容的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rbTextChange) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"%s--%d 对象被销毁 移除通知",__FUNCTION__,__LINE__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)rbTextChange
{
    NSLog(@"输入内容:%@",self.noDisplayTextView.text);
    
    // 对输入内容进行处理，只允许输入数字
    NSString *textStr = self.noDisplayTextView.text;
    
    // 定义一个可变字符串,存储处理过的字符串
    NSMutableString *mStr = @"".mutableCopy;
    
    for (int i=0; i<textStr.length; i++) {
        // 1.切割字符串
        NSString *subStr = [textStr substringWithRange:NSMakeRange(i, 1)];
        
        // 2.逐个判断是否为数字
        if ([self isNumberString:subStr]) {
            [mStr appendFormat:@"%@",subStr]; // ✅
//            [mStr appendString:subStr]; // ✅
//            [mStr stringByAppendingString:subStr]; // ❌
        }
    }
//    NSLog(@"mStr=====%@",mStr);
    self.noDisplayTextView.text = mStr;
    
    // 删除情况
    for (int j=0; j<6; j++) {
        // 倒着计算tag值，让对应tag值得UITextFiled的内容为空
        // 为什么从5开始？ ∵ 0,1,2,3,4,5  ∴ 5
        UITextField *tf = [self viewWithTag:5 - j + kSingleTFTag];
        tf.text = @"";
        
        self.inputString = mStr;
        
        // 实时回调输入内容
        if (self.finshBlock) {
            self.finshBlock(self.noDisplayTextView.text);
        }
    }
    
    // 输入情况
    for (int i=0; i<self.noDisplayTextView.text.length; i++) {
        UITextField *subTF = [self viewWithTag: i + kSingleTFTag];
        NSString *subStr = [self.noDisplayTextView.text substringWithRange:NSMakeRange(i, 1)];
        subTF.text = subStr;
    
        //1-27 是否以密码形式显示:默认为nil,明文显示. 
        subTF.secureTextEntry = self.isShowByPassword;
    }
    
    // 回收键盘
    if (self.noDisplayTextView.text.length == 6) {
        [self rbFinish];
    }
}

- (void)rbShowKeyboardGestureAction{
    [self.noDisplayTextView becomeFirstResponder]; // 称为第一响应者
}

#pragma mark - 工具方法
/**判断一个字符是不是数字*/
- (BOOL)isNumberString:(NSString *)aStr{
    NSString *regularStr = @"\\d";
    
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularStr];
    
    return [numberPredicate evaluateWithObject:aStr];
}

// 有bug先写，回头优化
- (void)rbFinish{
    // 回调字符串
    if (self.finshBlock) {
        self.finshBlock(self.noDisplayTextView.text);
    }
    
    // 回收键盘
    [self.noDisplayTextView resignFirstResponder];
}



#pragma mark - bug
 /***
  1.通知的没有移除
  2.bug 如果强制调出键盘继续输入数字，虽然界面不显示，但是删除的时候发现删除按钮暂时失灵了，之后又可用了。其实是输入多有的字符串，没删掉。
  3.继续步骤2,继续删除字符串，知道字符串少于6 会发现，对应的输入框有变化，但是时机字符串刷新还是原来的6个字符串，正常使用看不出问题，如果测试手贱就会出现问题，对于苛刻的测试，肯定会这么玩。
  这里面不应该用NSNotificaitonCenter 还是应该使用UITextView的代理方法。来进行输入限制。
  4.没有做回调操作。 ✅
  5.没有实时回调。   ✅
  */

@end
