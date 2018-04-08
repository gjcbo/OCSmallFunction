//
//  NSString+Hex.m
//  BlueToothDemo
//
//  Created by Jeamine on 16/1/18.
//  Copyright © 2016年 Jeamine. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)
-(NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
   // NSLog(@"hexdata: %@", hexData);
    return hexData;
}

-(Byte)strToByte:(NSString *)str
{
    Byte endMinutes = [str intValue];
    Byte endMinuteByte = (Byte)0xff&endMinutes;
    return endMinuteByte;
}

//普通字符串转换为十六进制的。
+(NSString *)ToHex:(long long int)tmpid

{
    
    NSString *nLetterValue;
    
    NSString *str =@"";
    
    long long int ttmpig;
    
    for (int i = 0; i<9; i++) {
        
        ttmpig=tmpid%16;
        
        tmpid=tmpid/16;
        
        switch (ttmpig)
        
        {
                
            case 10:
                
                nLetterValue =@"A";break;
                
            case 11:
                
                nLetterValue =@"B";break;
                
            case 12:
                
                nLetterValue =@"C";break;
                
            case 13:
                
                nLetterValue =@"D";break;
                
            case 14:
                
                nLetterValue =@"E";break;
                
            case 15:
                
                nLetterValue =@"F";break;
                
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
                
                
        }
        
        str = [nLetterValue stringByAppendingString:str];
        
        if (tmpid == 0) {
            
            break;  
            
        }  
        
        
        
    }  
    
    return str;  
    
}
@end
