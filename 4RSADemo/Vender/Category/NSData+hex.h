//
//  NSData+hex.h
//  Hema
//
//  Created by Jeamine on 16/2/24.
//  Copyright © 2016年 Hemaapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (hex)
-(NSData *)getCheckSum:(NSData *)byteStr;
- (NSString *)convertDataToHexStr:(NSData *)data ;

@end

