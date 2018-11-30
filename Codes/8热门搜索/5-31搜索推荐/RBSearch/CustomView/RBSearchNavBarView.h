//
//  RBSearchNavBarView.h
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/5/31.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RBSearchNavBarViewClickCancelButtonBlock)(void);
typedef void(^RBSearchNavBarViewSearchBlock)(NSString *searchStr);
@interface RBSearchNavBarView : UIView


@property(nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, copy) RBSearchNavBarViewClickCancelButtonBlock searchNavBarViewClickCancelButtonBlock;

@property(nonatomic, copy) RBSearchNavBarViewSearchBlock searchBlock;


@end
