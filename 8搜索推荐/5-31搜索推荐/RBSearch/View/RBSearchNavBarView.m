//
//  RBSearchNavBarView.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "RBSearchNavBarView.h"
#import <Masonry.h>

@interface RBSearchNavBarView() <UISearchBarDelegate>

@property(nonatomic, strong) UIButton *cancelButton;

@end
@implementation RBSearchNavBarView

#pragma mark - 一 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView{
    [self addSubview:self.searchBar];
    [self addSubview:self.cancelButton];
}


#pragma mark - 二 lazy
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @" 请输入搜索名称";
        _searchBar.delegate = self;
//        _searchBar.backgroundColor = [UIColor whiteColor]; 无效
        _searchBar.backgroundImage = [self rb_imageWithColor:[UIColor whiteColor]]; // ✅
        
        // 放大镜
        UIImage *leftImg = [UIImage imageNamed:@"searchBar_left_icon"];
        [_searchBar setImage:leftImg forSearchBarIcon:(UISearchBarIconSearch) state:(UIControlStateNormal)];
        
        // 清除按钮
        UIImage *clearImg = [UIImage imageNamed:@"searchBar_right_clear_icon"];
        [_searchBar setImage:clearImg forSearchBarIcon:(UISearchBarIconClear) state:(UIControlStateNormal)];
        
        //KVC 设置输入框的样式:固定写法
        UITextField *tf = [_searchBar valueForKey:@"_searchField"];
        tf.enablesReturnKeyAutomatically = YES;
        [tf setValue:[UIColor whiteColor] forKeyPath:(@"_placeholderLabel.textColor")];//placeholder颜色
        [tf setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        tf.backgroundColor = [UIColor lightGrayColor]; // tf输入框颜色
    }
    return _searchBar;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateHighlighted)];

        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelButton;
}

#pragma mark - 三 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.cancelButton.mas_left).offset(10);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(80);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
}

#pragma mark - 四 回调事件
- (void)cancelButtonAction {
    
    if (self.searchNavBarViewClickCancelButtonBlock) {
        self.searchNavBarViewClickCancelButtonBlock();
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"输入的的内容是:%@",searchText);
}


// 触发时机:称为第一响应者时触发、
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    
    return YES;
}


//触发实际:点击键盘上的搜索按钮。

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击搜索按钮");
    
    // 判断:如果输入的全是空格,什么也不做
    NSString *searchText = searchBar.text;
    NSString *noWhiteSpaveStr = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (noWhiteSpaveStr.length == 0) {return;}
    
    
    [searchBar resignFirstResponder];
    
    if (self.searchBlock) {
        self.searchBlock(searchText);
    }
}



#pragma mark - 五 private method
/**作用: 将颜色生成一种张图片*/
- (UIImage *)rb_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
 
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}



@end
