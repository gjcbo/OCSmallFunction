//
//  ObtainPrivatekeyParamController.m
//  RSADemo
//
//  Created by RaoBo on 2018/2/8.
//  Copyright © 2018年 关键词. All rights reserved.
//  获取私钥参数

#import "ObtainPrivatekeyParamController.h"
#import "UIButton+Addition.h"
#import "RBGenerateRSA.h"

#import "NSString+Hex.h"
#import "NSData+hex.h"


#import "GTMBase64.h"



@interface ObtainPrivatekeyParamController ()
/**label*/
@property(nonatomic, strong) UILabel *shoLabel;

@end

@implementation ObtainPrivatekeyParamController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提取用户公私钥";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // contentLabel
    self.shoLabel = [self createShowLabel];
    self.shoLabel.frame = CGRectMake(10, 20,kScreen_W - 20, kScreen_H - 100);
    [self.view addSubview:self.shoLabel];
    
    UIButton *btn = [UIButton rb_BtnWithFrame:CGRectMake(30, kScreen_H-60, 150, 40) target:self action:@selector(obtainPrivateParamAction:) title:@"获取私钥参数"];
    [self.view addSubview:btn];
}

- (UILabel *)createShowLabel
{
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"私钥参数";
    aLabel.backgroundColor = [UIColor lightGrayColor];
    aLabel.numberOfLines = 0;
    
    return aLabel;
}

- (void)obtainPrivateParamAction:(UIButton *)btn
{
    [self abstractFiveParameterWithPrivatekey:kPrivatekey];
}


- (void)baseDecodeEncodeDemo
{
    [RBGenerateRSA rb_generateRSAKeyPairsWithKeySize:1024];
    NSString *privatekeyString = [RBGenerateRSA rb_privatekey];
    NSLog(@"私钥:%@--长度:%ld",privatekeyString,privatekeyString.length);
    
    NSData *data =   [GTMBase64 decodeString:privatekeyString];
    NSLog(@"%@",data);
    
    
    NSString *encodString = [GTMBase64 encodeBase64Data:data];
    NSLog(@"%@ 长度:%ld",encodString,(long)encodString.length);
}



#pragma markr - 提取私钥匙参数工具方法
/**1.将私钥base64解密并用16进制显示
 以前收藏了两篇博客，目前找不到了，提取RSA私钥参数，需要对私钥字符串进行base64解码 转为16进制；前面有一部分是无效的，五个参数以0241、0240进行分割，顺序排列，起吊多余的数据剩下的就是私钥参数。
 这里还需要借助一个第三方GTMBase64
 
 //私钥参数:p,q,ep,eq,cf格式参考
 http://www.cnblogs.com/jukan/p/5527922.html

 */


//

/**abstract:抽象，提取，提取私钥匙参数 */
- (void)abstractFiveParameterWithPrivatekey:(NSString *)privatekey
{
    
   //如果私钥为空，直接返回

    //1.1 将PEM格式的RSA私钥base64解码:将RSA钥钥Base64解码，转为NSData
    NSData *base64DecodeData = [GTMBase64 decodeString:privatekey];
    NSLog(@"base64解码后的用户私钥:%@",base64DecodeData);
    
    
    NSString *originStr = [base64DecodeData convertDataToHexStr:base64DecodeData];
    
    //1.2私钥格式参考链接  http://www.cnblogs.com/jukan/p/5527922.html
    //提取私钥参数:解码后的数据格式如下xxxx0241xxxx0240xxxxxx0241xxxx0240xxxx0241xxxxxx。只保留0240或0241之间的数据，前后不可能为空，这里没做判空处理
    
    // 准备一个大容器
    NSMutableArray *resultArr = [NSMutableArray array];
    
    // 第一次切割，
    NSArray *firstArr =  [originStr componentsSeparatedByString:@"0240"];

    // 第二次切割
    for (int i=0; i<firstArr.count; i++) {
        NSString *firstString = firstArr[i];
        
        // 切割第二次
        NSArray *secondArr = [firstString componentsSeparatedByString:@"0241"];
        
        for (int j=0; j<secondArr.count; j++) {
            NSString *secStr = secondArr[j];
            [resultArr addObject:secStr];
        }
    }
    
//    NSLog(@"%@--%ld",resultArr,(long)resultArr.count);
    NSLog(@"========分割线=========");
    
    // 1.3去掉resultArr数组中第一个元素，只保留剩余的五个参数:p,q,ep,eq,cf
    if (resultArr.count) {
        [resultArr removeObjectAtIndex:0];
    }
    
    // 1.4 去掉 "00"
    // 重新找两个容器装东西
    NSMutableArray *tempArr = resultArr;
    NSMutableArray *newArr = [NSMutableArray array];
    
    for (NSString *str in tempArr) {
        
        //前两个字符为"00" 丢掉
       NSString *theFirstTwoStr = [str substringToIndex:2];
        
        if ([theFirstTwoStr isEqualToString:@"00"]) { // 有00去掉
            NSString *without00Str = [str substringFromIndex:2];
            
            // 放入数组中
            [newArr addObject:without00Str];
        }else{ // 没0直接放
            [newArr addObject:str];
        }
    }
    
    NSLog(@"私钥五个参数:%@",newArr);
    
    // 显示
    NSMutableString *mStr = @"".mutableCopy;
    for (NSString *parameterStr in newArr) {
        [mStr appendFormat:@"\"%@\" \n",parameterStr];
    }
    
    self.shoLabel.text = [NSString stringWithFormat:@"%@",mStr];
}

@end
