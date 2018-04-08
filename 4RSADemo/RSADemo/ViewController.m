//
//  ViewController.m
//  RSADemo
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "ObtainPrivatekeyParamController.h"

#import "RBGenerateRSA.h" // 生成RSA公私钥

#import "RSA_C.h" // RSA加解密

// NSString <---->NSData 内容原封不动的互转
#import "NSData+hex.h"
#import "NSString+Hex.h"
#define kOriginStr1 @"0123456"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

/**原始数据*/
@property (weak, nonatomic) IBOutlet UILabel *originDataLabel;

/**加密后的数据*/
@property(nonatomic, strong) NSData *encryptData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self generatePublickPrivatekeyDemo];
    
    [self showOriginData];
}

// 显示原始数据
- (void)showOriginData
{
    // 原始数据
    NSString *originStr = [NSString stringWithFormat:@"%@",kOriginStr1];
    NSData *originData = [originStr convertHexStrToData:originStr];
    self.originDataLabel.text = [NSString stringWithFormat:@"原始数据:%@ 长度:%ld",originData,(long)originData.length];
}

// 1.坑点,如果加密的数据第一个字节是0x00，解密后的数据会将00丢掉。😂
- (void)generatePublickPrivatekeyDemo{
    
    [RBGenerateRSA rb_generateRSAKeyPairsWithKeySize:1024];
    
    NSString *publickey = [RBGenerateRSA rb_publickey];
    NSString *privatekey = [RBGenerateRSA rb_privatekey];
    NSLog(@"公钥:%@ 长度:%ld",publickey,(long)publickey.length);
    NSLog(@"私钥:%@ 长度:%ld",privatekey,(long)privatekey.length);
}

#pragma mark - 按钮点击事件

- (IBAction)clickRSAEncryptAction:(UIButton *)sender {
    
    NSString *originStr= [NSString stringWithFormat:@"%@",kOriginStr1];
    
    NSData *originData = [originStr convertHexStrToData:originStr];
    
    self.encryptData = [RSA_C encryptData:originData publicKey:kPublickey];
    
    self.showLabel.text = [NSString stringWithFormat:@"密文:\n%@  \n长度:   %ld",self.encryptData,self.encryptData.length];
}

- (IBAction)clickRSADecryptAction:(UIButton *)sender {
    
    if (0 != self.encryptData.length) {
        NSData *decryptData = [RSA_C decryptData:self.encryptData privateKey:kPrivatekey];
        self.showLabel.text = [NSString stringWithFormat:@"解密:\n%@  \n长度:   %ld",decryptData,decryptData.length];
        
    }else{
        self.showLabel.text = @"密文为空，请先加密再解密";
    }
}

/**获取私钥参数*/
- (IBAction)obtainPrivatekeyFiveParameter:(UIButton *)sender {
    ObtainPrivatekeyParamController *obtainVC = [[ObtainPrivatekeyParamController alloc] init];
    
    [self.navigationController pushViewController:obtainVC animated:YES];
}

#pragma mark - 基础常识
/**
 当前这家公司是做蓝牙锁的，有大量的RSA、AES加解密流程，虽然用的都是第三方，碰到了很多问题，折磨了很久，以后在换工作应该不会用到加密了。做个笔记，记录一下以前踩过的坑。
 
 1.公钥加密私钥匙解密。比如iOS制作上线证书:a.首先从钥匙串制作一个证书请求文件.csr文件, b.上传到Apple Developer开发者网站上，生成一个.cer文件(相当于公钥)。
 2. 坑点:iOS中使用的是 “pcks8” 格式的公私钥，
 3. 对NSData进行加密，RSA加密后是128的倍数，AES加密后的结果是16的倍数
 
 4. 坑点：如果原文第一个位置的字节是 0x00，解密后会被丢掉。
 5. 一般情况下的长度是:publickey 216个字符，以MIG开头....AB结尾，
  privatekey长度是:848左右各字符。
 6. 加密数据过长的问题，
 7. 与Android互通的问题:项目中碰到的问题是Android加密出来的iOS解不出来，后来换了编码格式:使用UTF8格式解决了此问题。
 
 8. 坑点:提取RSA私钥匙的5个参数。
 9. 集成OpenSSL相关问题。
 iOS在Xcode中使用OpenSSL库 https://www.cnblogs.com/mafeng/p/6552523.html
 常见报错：'openssl/rsa.h' file not found
 
 10. 在线工具: 在线代码对比工具，在线字符串长度工具
 11. 小技巧，取出字符串中的空格，放在浏览器地址栏中
 */




@end
