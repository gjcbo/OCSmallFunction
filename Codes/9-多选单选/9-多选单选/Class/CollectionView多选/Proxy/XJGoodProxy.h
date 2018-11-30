//
//  XJGoodProxy.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XJGoodProxyClickItemBlock)(NSIndexPath *indexPath, BOOL isSelected);

@interface XJGoodProxy : NSObject <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**Format 请求数据成功之后在 VC中将请求的数据传递进来*/
@property (nonatomic, strong) NSMutableArray *goodsArray;

/**点击cellblock回调*/
@property (nonatomic, copy) XJGoodProxyClickItemBlock clickItemBlock;

/**是否处于编辑状态*/
@property(nonatomic, assign) BOOL isEditing;


@end
