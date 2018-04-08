//
//  NSString+Hex.h
//  BlueToothDemo
//
//  Created by Jeamine on 16/1/18.
//  Copyright © 2016年 Jeamine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)
-(NSData*) hexToBytes ;
- (NSData *)convertHexStrToData:(NSString *)str ;
-(Byte)strToByte:(NSString *)str;

//普通字符串转换为十六进制的。
+(NSString *)ToHex:(long long int)tmpid;
@end
