//
//  RBGenerateRSA.m
//  RSADemo
//
//  Created by 华杨科技 on 2017/9/26.
//  Copyright © 2017年 饶波. All rights reserved.
//

#import "RBGenerateRSA.h"
#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define OpenSSLRSAKeyDir [DocumentsDir stringByAppendingPathComponent:@"openssl_rsa"]
#define OpenSSLRSAPublicKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.publicKey.pem"]
#define OpenSSLRSAPrivateKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.privateKey.pem"]

@implementation RBGenerateRSA
#pragma mark - 外部接口


/**
 根据 keySize 的大小生成对应的 RSA 公私钥对

 @param keySize RSA位数的大小
 */
+ (void)rb_generateRSAKeyPairsWithKeySize:(int)keySize {
    
    RSA *p;
    RSA *q;
    
    [self generateRSAKeyPairWithKeySize:keySize publicKey:&p privateKey:&q];

    //通过FileManager 创建文件夹 openssl_rsa
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:OpenSSLRSAKeyDir]) {
        [fileManager createDirectoryAtPath:OpenSSLRSAKeyDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSString *publickey = [self PEMFormatRSAKey:p isPublickey:YES]; // 公钥PEM文件
    NSString *privatekey = [self PEMFormatRSAKey:q isPublickey:NO]; // 私钥PEM文件
    
    
    // 保存本地
    [publickey writeToFile:OpenSSLRSAPublicKeyFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [privatekey writeToFile:OpenSSLRSAPrivateKeyFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"公私钥文件夹路径:%@",[NSString stringWithFormat:@"%@",OpenSSLRSAKeyDir]);
    
}

+ (NSString *)rb_publickey {
    NSString *publickey = [NSString stringWithContentsOfFile:OpenSSLRSAPublicKeyFile encoding:NSUTF8StringEncoding error:nil];
    
    // 去掉 -----BEGIN PUBLIC KEY-----   和  -----END PUBLIC KEY-----
    NSRange beginRange = [publickey rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange endRange = [publickey rangeOfString:@"-----END PUBLIC KEY-----"];
    if ((beginRange.location != NSNotFound) && (endRange.location != NSNotFound)) {
        NSUInteger s = beginRange.location + beginRange.length; // 起点
        NSUInteger e = endRange.location;
        NSRange range = NSMakeRange(s, e-s);
        
        publickey = [publickey substringWithRange:range];
    }
    
    return [self pureStringWithOriginStr:publickey]; // 提纯
}

+ (NSString *)rb_privatekey {
    NSString *privatekey = [NSString stringWithContentsOfFile:OpenSSLRSAPrivateKeyFile encoding:NSUTF8StringEncoding error:nil];

    // 去掉 -----BEGIN PRIVATE KEY-----  和   -----END PRIVATE KEY-----
    NSRange beginR = [privatekey rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
    NSRange endR = [privatekey rangeOfString:@"-----END PRIVATE KEY-----"];
    
    if ((beginR.location != NSNotFound) && (endR.location != NSNotFound)) {
        NSUInteger s = beginR.location + beginR.length;
        NSUInteger e = endR.location;
        NSRange range = NSMakeRange(s, e-s);
        privatekey = [privatekey substringWithRange:range];
    }
        
    // 提纯
    return [self pureStringWithOriginStr:privatekey];
}


#pragma mark - ==============OpenSSL 方式================
#pragma mark - 生成密钥对
+ (BOOL)generateRSAKeyPairWithKeySize:(int)keySize publicKey:(RSA **)publicKey privateKey:(RSA **)privateKey {
   
    if (keySize == 512 || keySize == 1024 || keySize == 2048) {
        
        // 产生RSA密钥 
        RSA *rsa = RSA_new();
        BIGNUM* e = BN_new();
        
        // 设置随机数长度 
        BN_set_word(e, 65537);
        
        //生成RSA密钥对 
        RSA_generate_key_ex(rsa, keySize, e, NULL);
        
        if (rsa) {
            *publicKey = RSAPublicKey_dup(rsa);
            *privateKey = RSAPrivateKey_dup(rsa);
            return YES;
        }
    }
    return NO;
}


#pragma mark - RSA转化为字符串
+ (NSString *)PEMFormatRSAKey:(RSA *)rsaKey isPublickey:(BOOL)isPublickey {
    
    if (!rsaKey) {
        return nil;
    }
    
    BIO *bio = BIO_new(BIO_s_mem());
    if (isPublickey)
        PEM_write_bio_RSA_PUBKEY(bio, rsaKey);  
    else
    {
        //此方法生成的是pkcs1格式的,IOS中需要pkcs8格式的,因此通过PEM_write_bio_PrivateKey 方法生成
        // PEM_write_bio_RSAPrivateKey(bio, rsaKey, NULL, NULL, 0, NULL, NULL);
        
        EVP_PKEY* key = NULL;
        key = EVP_PKEY_new();
        EVP_PKEY_assign_RSA(key, rsaKey);
        PEM_write_bio_PrivateKey(bio, key, NULL, NULL, 0, NULL, NULL);
    }
    
    BUF_MEM *bptr;
    BIO_get_mem_ptr(bio, &bptr);
    BIO_set_close(bio, BIO_NOCLOSE); /* So BIO_free() leaves BUF_MEM alone */
    BIO_free(bio);
    return [NSString stringWithUTF8String:bptr->data];
}


#pragma mark - 工具方法

/**
 对一个字符串进行提纯处理，取出多余的换行，空格......
 
 @param originStr 源字符串
 @return 提纯后的字符串
 */
+ (NSString *)pureStringWithOriginStr:(NSString *)originStr {
    
    originStr = [originStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\r" withString:@""]; // 去掉 回车
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\t" withString:@""]; // 去掉 tab 键
    originStr = [originStr stringByReplacingOccurrencesOfString:@" " withString:@""]; // 去掉空格
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\n" withString:@""]; // 去掉换行
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\0" withString:@""]; // 去掉 '\0'
    
    return originStr;
}



@end

