//
//  RBPayTypeModel.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBPayTypeModel : NSObject
/**1.图标*/
@property (nonatomic, copy) NSString *iconStr;
/**2.文字内容*/
@property (nonatomic, copy) NSString *name;
/**3.标记是否被选中*/
@property (nonatomic, assign) BOOL isChecked;


@end
