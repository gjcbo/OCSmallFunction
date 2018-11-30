//
//  Person.h
//  Runtime字典转模型
//
//  Created by RaoBo on 2018/5/13.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/**姓名*/
@property (nonatomic, copy) NSString *name;
/**年级*/
@property (nonatomic) NSInteger age;
/**职务*/
@property (nonatomic, copy) NSString *title;
@property (nonatomic) double height;


@end
