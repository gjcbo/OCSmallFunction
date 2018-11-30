//
//  RBSearchResultView.h
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/8/2.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RBSearchResultViewClickCellBlock)(NSString *str, NSIndexPath *indexPath);

@interface RBSearchResultView : UIView
/**搜索结果数组 这里要求数组中装的是NSString */
@property (nonatomic, strong) NSMutableArray <NSString *> *resultArr;

@property (nonatomic, strong) RBSearchResultViewClickCellBlock searchResultViewClickCellBlock;


@end
