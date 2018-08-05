//
//  RBDownViewController.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBDownViewController.h"
#import "RBDownCell.h"
#import "RBProxy.h" // 使用代理来解决定时器和控制器的循环引用问题。

@interface RBDownViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSMutableArray *dataArray;

/**定时器*/
@property (nonatomic, strong) NSTimer *downTimer;

@end

@implementation RBDownViewController

#pragma mark - 一 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    [self createTimer];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    //备注:控制器销毁实际问题:直接在dealloc中写没用，定时器依然销毁不掉。
//    //销毁定时器、
//    [self.downTimer invalidate];
//    self.downTimer = nil;
//}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    [self.downTimer invalidate];
//    self.downTimer = nil;
//}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"倒计时";
    self.dataArray =  [self simulateData];
    
    self.tv.frame = self.view.bounds;
    [self.view addSubview:self.tv];
}

//模拟数据
- (NSMutableArray *)simulateData {
    RBDownModel *m1 = [RBDownModel rbDownModelWithTitle:@"草房子" time:31];
    RBDownModel *m2 = [RBDownModel rbDownModelWithTitle:@"平凡的世界" time:1000];
    RBDownModel *m3 = [RBDownModel rbDownModelWithTitle:@"流血的仕途" time:8089];
    RBDownModel *m4 = [RBDownModel rbDownModelWithTitle:@"人类简史" time:6666];
    RBDownModel *m5 = [RBDownModel rbDownModelWithTitle:@"张三" time:1314];
    RBDownModel *m6 = [RBDownModel rbDownModelWithTitle:@"血仇定律" time:2680];
    RBDownModel *m7 = [RBDownModel rbDownModelWithTitle:@"官家主义" time:6780];
    RBDownModel *m8 = [RBDownModel rbDownModelWithTitle:@"潜规则" time:100];
    RBDownModel *m9 = [RBDownModel rbDownModelWithTitle:@"时间简史" time:120];
    RBDownModel *m10 = [RBDownModel rbDownModelWithTitle:@"今日简史" time:46];
    
    return @[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10].mutableCopy;
}


//创建定时器
- (void)createTimer {
    
    //使用NSProxy来解决定时器的循环引用问题:
    //原来：VC 强引用--->NSTimer 强引用--->VC
    //现在: VC 强引用--->NSTimer 强引用 ---->RBProxy 弱引用----> VC 断开了循环引用，控制器销毁都被销毁。
    //这是一种思想、方法：引入一个第三方，将其中的一条线设为弱引用，就有效的解决了循环引用问题。
    //联想到以前比较大小，总喜欢多搞出来一个变量： int temp = a; a = b; b = temp;
    self.downTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[RBProxy rbProxyWithTarget:self] selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
    //解决滑动scrollview时:定时器无效问题。
    [[NSRunLoop currentRunLoop] addTimer:self.downTimer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent {

    //定时器时间间隔是：1s。 在这一秒内做两件事
    
    //1.遍历model,让model的时间自减
    for (RBDownModel *model in self.dataArray) {
        [model countDownTime];  //model 时间自减
    }
    
    //2.发通知到 RBDownCell 中
    [[NSNotificationCenter defaultCenter] postNotificationName:kRBDownCellNotification object:nil];
}

#pragma mark - 二 lazy
- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        
        NSString *clsName = NSStringFromClass([RBDownCell class]);
        [_tv registerClass:[RBDownCell class] forCellReuseIdentifier:clsName];
        
        _tv.tableFooterView = [UIView new];
    }
    return _tv;
}
#pragma mark - 三  <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBDownCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RBDownCell class])];
    
    RBDownModel *model = self.dataArray[indexPath.row];
    [cell configureDownCellWithModel:model indexPath:indexPath];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



#pragma mark - 四 dealloc
- (void)dealloc {
    
    NSLog(@"%s 挂了",__FUNCTION__);
    
    //问题 ： 在dealloc中并不能销毁定时器？ 时机问题？
//    //销毁定时器、
    [self.downTimer invalidate];
    self.downTimer = nil;
}

#pragma mark - 思考题
/**
 小技巧: bt 命令
 打个断点。 在控制台 输入 bt 然后回车， 可以打印方法的调用堆栈。很全的。

 关于控制器中的定时器销毁问题
 1.为什么在dellloc 销毁定时器无效？ 暂时想不明白。
 2.有效的解决方式
 2-1 可以在 viewWillDisappear 中销毁定时器 ✅
 2-2 或者在 viewDidDisappear  中销毁定时器 ✅
 
 感觉问题还是出在方法的调用时机上。  2-1，2-2这两个方法都比 dealloc先调用
 dealloc 最后一步，处理善后工作。
 
 3. 尝试了一下Rnuloop保活 ，在dealloc中停止runloop奔溃问题，使用同样的方式就能解决奔溃问题。
 还是调用时机问题。
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
