//
//  NSData+hex.m
//  Hema
//
//  Created by Jeamine on 16/2/24.
//  Copyright © 2016年 Hemaapp. All rights reserved.
//

#import "NSData+hex.h"
//#import "NSString+Hex.h"

@implementation NSData (hex)
-(NSData *)getCheckSum:(NSData *)byteStr{
    int length = (int)byteStr.length;
    // NSData *data = [self hexToBytes:byteStr];
    Byte *bytes = (unsigned char *)[byteStr bytes];
    Byte sum = 0;
    for (int i = 0; i<length; i++) {
        sum += bytes[i];
    }
    int sumT = sum;
    int at = 256 -  sumT;
    // NSLog(@"字符串的 长度：%lu，NSData的长度：%lu",(unsigned long)byteStr.length,(unsigned long)data.length);
    // printf("校验和：%d\n",at);
    // printf("累加和：%d\n",sumT);
    if (at == 256) {
        at = 0;
    }
    NSString *str = [NSString stringWithFormat:@"%@",[self ToHex:sumT]];
    return [self hexToBytes:str];
}

//将十进制转化为十六进制
- (NSString *)ToHex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    int ttmpig;
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
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    //NSLog(@"16进制是：%@",str);
    //不够一个字节凑0
    if(str.length == 1){
        return [NSString stringWithFormat:@"0%@",str];
    }else{
        return str;
    }
}
- (NSData *)hexToBytes:(NSString *)str
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}
//NSdata转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
@end
