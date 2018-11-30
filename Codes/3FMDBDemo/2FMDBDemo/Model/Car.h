//
//  Car.h
//  2FMDBDemo
//
//  Created by RaoBo on 2018/3/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
/**所有者*/
@property(nonatomic, strong) NSNumber *own_id;

/**车id*/
@property(nonatomic, strong) NSNumber *car_id;

/**品牌*/
@property(nonatomic, copy) NSString *brand;
/**价格*/
@property(nonatomic, assign) NSInteger price;

@end
