//
//  RBGenerateRSA.h
//  RSADemo
//
//  Created by 华杨科技 on 2017/9/26.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <openssl/rsa.h>
#import <openssl/pem.h>

@interface RBGenerateRSA : NSObject
#pragma mark - 外部接口

/**
 生成rsa 密钥对

 @param keySize rsa密钥对长度 可选长度:512 、 1024 、2048; 一般情况下都使用1024 
 */
+ (void)rb_generateRSAKeyPairsWithKeySize:(int)keySize;


/**
 公钥纯文本:通常1024位的公钥长度为216个字符，通常以MIG开头......AB结尾，通常都是 base64编码 后的字符串

 @return 去掉 -----BEGIN-----    -----END------  后的公钥字符串
 */
+ (NSString *)rb_publickey;


/**
 私钥存文字符串:通常1024位的私钥长度在840 左右个字符，通常都是 base64编码 后的字符串
 
 @return 去掉 -----BEGIN-----    -----END------  后的私字符串
 */
+ (NSString *)rb_privatekey;

#pragma mark - 参考CGPoint,提供一个获取用户私钥参数的接口

@end
