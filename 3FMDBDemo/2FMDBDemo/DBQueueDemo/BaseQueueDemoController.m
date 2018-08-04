//
//  BaseQueueDemoController.m
//  2FMDBDemo
//
//  Created by RaoBo on 2018/8/4.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "BaseQueueDemoController.h"
#import "DataBaseQueueManager.h"
@interface BaseQueueDemoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *stimulateDataArray; //用来初始化模拟数组

@end

@implementation BaseQueueDemoController

#pragma mark - 一 lazy
- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tv;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)stimulateDataArray {
    if (!_stimulateDataArray) {
        _stimulateDataArray = [NSMutableArray array];
    }
    return _stimulateDataArray;
}

#pragma mark - 二 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    //装模拟数据
    self.stimulateDataArray = [self simulateData];
    
    [self.view addSubview:self.tv];
    
    [DataBaseQueueManager shareDataBaseQueueManager];
}
- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"FMDataBaseQueueDemo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addItemAction)];
}

- (void)addItemAction {
    NSLog(@"添加");
    //在子线程中执行代码
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //0---4的随机数
        NSUInteger randomIndex = arc4random() % 5;
        NSLog(@"%ld",randomIndex);
        
        NSLog(@"%ld====",self.stimulateDataArray.count);
        BookModel *model = self.stimulateDataArray[randomIndex];
        
        //添加数据
        [[DataBaseQueueManager shareDataBaseQueueManager] addBook:model];
    });
    
    //查询所有数据 & 刷新
    self.dataArray = [[DataBaseQueueManager shareDataBaseQueueManager] queryAllBook];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tv reloadData];
    });
}

- (NSMutableArray *)simulateData {
    BookModel *model1 = [BookModel bookModelWithName:@"潜规则" bookId:@"001" author:@"吴思"];
    BookModel *model2 = [BookModel bookModelWithName:@"官家主义" bookId:@"002" author:@"吴思"];
    BookModel *model3 = [BookModel bookModelWithName:@"未来简史" bookId:@"003" author:@"赫拉利"];
    BookModel *model4 = [BookModel bookModelWithName:@"流血的仕途" bookId:@"004" author:@"曹三公子"];
    BookModel *model5 = [BookModel bookModelWithName:@"狼图腾" bookId:@"005" author:@"不知道"];
    
    NSArray *randomArr = @[model1,model2,model3,model4,model5];
    
    return randomArr.mutableCopy;
}


#pragma mark - 三 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    BookModel *model = self.dataArray[indexPath.row];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"id:%@ 书名:%@",model.bookId,model.name];
    cell.detailTextLabel.text = model.author;
    
    return cell;
}

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
