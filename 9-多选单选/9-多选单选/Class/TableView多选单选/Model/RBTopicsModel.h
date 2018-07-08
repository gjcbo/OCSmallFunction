//
//  RBTopicsModel.h
//  9-多选单选
//
//  Created by RaoBo on 2018/7/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTopicsModel : NSObject
/**1.头像*/
@property (nonatomic, copy) NSString *avatar;
/**2.名字*/
@property (nonatomic, copy) NSString *publish_name;
/**3.帖子内容*/
@property (nonatomic, copy) NSString *content;
/**4.是否被选中*/
@property (nonatomic, assign) BOOL isSelected;


@end
