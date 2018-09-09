##### 一、基础认知
单元测试：测试逻辑单元的

```
1、单元测试是以代码测试代码
2、红灯、绿灯迭代开发。
3、目的：平时开发中，数据大部分来自网络，很难测试所有的边界情况，这时候就会导致奔溃，体验不好。
4、通过单元测试检查 `边界情况`
5、单元测试，不是靠NSLog来测试的，
	 单元测试，是使用 `断言`来测试的，提前预判条件必须满足。

6、Xcode 中的单元测试，约定以 test开头，对应的左边会有一个 ▶️ 播放按钮。通过就变绿，反之就爆红。
单元测试的类的继承关系
 PersonTests : XCTestCase : XCTest : NSObject 
 只有 .m 文件。
 
 7、Xcode中的测试是同步到的，如果要测试异步方法需要用到  XCTestExpectation 这给类，下面👇有示例代码
 
	 
注意：
1、不是所有的方法都需要测试，
	例如：私有方法不需要测试、只有暴露在 .h 中的方法才要测试。面向对象有一个原则：开闭原则

2、所有跟UI有关的都不需要测试，也不好测试
3、代码覆盖度问题：一般而言，代码的覆盖度在 50% ~ 70% 。不要为了测试而测试。

```

#### 二、性能测试
测试某个函数的性能，以前用 CACurrentMediaTime()两个相减，计算耗时，其实还可以使用 单元测试进行性能测试。

`` - (void)testPerformanceXXXXXX  `` 这一段是固定写法。

```
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
```



#### 三、异步测试 
注意事项：
Xcode的测试是同步的。

```
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
```

定义异步方法

```
+ (void)loadPersonAsync:(void (^)(Person *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1.0];
        
        Person *person = [Person personWithDic:@{@"name":@"关键词",@"age":@18}];
        
        //主队列回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                completion(person);
            }
        });
    });    
}
```


测试异步方法

```
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
```
