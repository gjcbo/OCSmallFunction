//
//  PersonTests.m
//  单元测试Tests
//
//  Created by RaoBo on 2018/9/9.
//  Copyright © 2018年 RB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests
//一次单元测试开始前的准备工作，可以设置全局变量
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

//一次单元测试结束前的销毁工作，
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// 异步测试
/**
 iOS 中的单元测试是同步的
 setUp
    testXXX1
    testXXX2
    testXXX3
 tearDown
 
 Xcode 6后解决，使用 XCTestExpection 测试异步方法
 */
- (void)testLoadPersonAsync {
    
    XCTestExpectation *expection = [self expectationWithDescription:@"异步测试 Person"];

    [Person loadPersonAsync:^(Person *person) {
        NSLog(@"异步回调：%@",person.name);
        
        //标注预期达成
        [expection fulfill];
    }];
    
    // 等待10s 期待 预期达成
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}


/**
 1. 单元测试是以代码测试代码
 2. 红灯 、 绿灯迭代开发。
 3、目的：日常开发中，数据大部分来自网络，很难出现所有的边界情况，如果没有测试所有的情况就上架，
    在运行的时候就会导致闪退。
 4. 自己建立 `测试用例` 检查边界情况。
 5. 单元测试，不是靠NSLog来测试的，NSLog是程序猿用眼睛看的笨办法，
    单元测试 是使用 `断言` 来测试的，提前预判条件必须满足。
 
 测试新建 Person 模型
 
 拓展：为什么有的公司不喜欢单元测试！ 因为代码覆盖度 “不好确认”。
 
 提示：
 1、不是所有的方法都需要测试，
    例如：私有方法不需要测试，只有暴露在 .h中的方法需要测试！面向对象有一个原则：开闭原则，
 2、所有跟 UI 有关的都不需要测试，也不好测试。
    MVVM 把小的业务逻辑封装出来！ 变成可测试的代码，让程序更加健壮。
 3、代码的覆盖度：一般而言，代码的覆盖度大约在 50% ~ %70%。不要为了测试而测试。
 
 */
- (void)testNewPerson {
    //下面的👇的代码就像当于 测试用例。
    [self checkPersonWithDic:@{@"name":@"张三",@"age":@5}];
    [self checkPersonWithDic:@{@"name":@"张三"}];
    [self checkPersonWithDic:@{}];
    [self checkPersonWithDic:@{@"name":@"张三",@"age":@5,@"title":@"boss"}];
    
    [self checkPersonWithDic:@{@"name":@"李四",@"age":@200}]; //超限
    [self checkPersonWithDic:@{@"name":@"王五",@"age":@-1}];
    
    //到目前为止 Person 对象的工厂方法测试完毕。
}

/** 根据dic 检查 Person 模型的信息*/
- (void)checkPersonWithDic:(NSDictionary *)dic {

    Person *p = [Person personWithDic:dic];
    NSLog(@"%@",p);
    NSString *name = dic[@"name"];
    NSInteger age = [dic[@"age"] integerValue];
    
    //检查名称
    XCTAssert([name isEqualToString:p.name] || p.name == nil, @"姓名不一致");
    
    //检查年龄
    if (age > 0 && age < 130) {
        XCTAssert(age == p.age, "年龄不一致");
    }else {

        //搞清楚断言是什么？判断条件别写错了。
        NSLog(@"%@",(p.age >= 0 && p.age <= 130) ? @"年龄合法" : @"年龄不合法");
        XCTAssert(p.age >= 0 && p.age <= 130 , "年龄超限");
    }
}


- (void)testExample {
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


//Performance 性能
/**
 相同代码重复执行10次，统计时间，并计算平均时间
 性能测试代码一旦写好，可以随时测试。
 */
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.

//       NSTimeInterval start =  CACurrentMediaTime();

        for (int i = 0; i < 10000; i++) {
            [Person personWithDic:@{@"name":@"张三",@"age":@5}];
        }
        
//        NSLog(@"耗时：%f", CACurrentMediaTime() - start);
    }];
}

@end
