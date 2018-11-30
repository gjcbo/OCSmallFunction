//
//  RBSecKillView.m
//  6-秒杀倒计时
//
//  Created by RaoBo on 2018/8/1.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "RBSecKillView.h"
#import "RBSecKilItem.h"
#import "RBSecKillModel.h"

@interface RBSecKillView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *clv;
@property (nonatomic, strong) NSArray <RBSecKillModel *>*dataArray;
@property (nonatomic, strong) NSTimer *seckillTimer;

@end

@implementation RBSecKillView

#pragma mark - 一 lazy
- (UICollectionView *)clv {
    if (!_clv) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        //左右各留出来一个间距：5。
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
        _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _clv.delegate = self;
        _clv.dataSource = self;
        _clv.backgroundColor = [UIColor lightGrayColor]; //灰色的

        [_clv registerClass:[RBSecKilItem class] forCellWithReuseIdentifier:NSStringFromClass([RBSecKilItem class])];
    }
    return _clv;
}


#pragma mark - 二 init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView {
    
    self.clv.frame = self.frame;
    [self addSubview:self.clv];
}


#pragma mark - 三 layout

#pragma mark - 四-1 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RBSecKilItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RBSecKilItem class]) forIndexPath:indexPath];
    
    RBSecKillModel *model = self.dataArray[indexPath.row];
    
    [item configureSecKillItemWithModel:model indexPath:indexPath];
    
    return item;
}

//UICollectionViewDelegateFlowLayout
#pragma mark - 四-2 UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat w =  (Width -20)/ 2;
    
    return CGSizeMake(w, 288);
}

//控制上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 100;
}

// 左右间距,不一定有用。 item的宽度过大 回导致该方法无效
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

#pragma mark - 五 读书本地JSON数据
- (void)reqeustSecKillData {

    // 网络请求 这里使用本地JSON数据
   self.dataArray =  [self readLocalJSONData];
    
    //刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.clv reloadData];
        
        [self createSeckillTimer]; //在数据请求成功之后开启定时器
    });
}

- (NSArray *)readLocalJSONData {
    
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"seckill" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:fileStr];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *seckill_list = dic[@"data"][@"seckill_list"];
    NSLog(@"个数:%ld",seckill_list.count);
    
    //转model
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *tempDic in seckill_list) {
     RBSecKillModel *model =  [RBSecKillModel mj_objectWithKeyValues:tempDic];
        
        [tempArr addObject:model];
    }
    return tempArr.copy;
}

#pragma mark - 六 计时器
//在数据请求成功之后开启定时器
- (void)createSeckillTimer {
    
    //如果使用block的方式创建定时器，可以通过 __weak 弱引用来解决循环引用问题。
    __weak typeof(self) weakSelf = self;
    
    self.seckillTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        //一秒钟做两件事
        //1.取出所有model。让时间-1
        for (RBSecKillModel *model in weakSelf.dataArray) {
            [model seckillCountDownTime];
        }
        
        //2.发通知更新model数据
        [[NSNotificationCenter defaultCenter] postNotificationName:kRBSecKillCellNotificatio object:nil userInfo:nil];
    }];
    
    
    [[NSRunLoop currentRunLoop] addTimer:self.seckillTimer forMode:NSRunLoopCommonModes];
}


//销毁定时器
- (void)dealloc {
    NSLog(@"%s 销毁了",__func__);
    
    //还是同样的问题：在这里写，始终无法销毁定时器
//    [self.seckillTimer invalidate];
//    self.seckillTimer = nil;
}

#pragma mark - 七 销毁定时器
- (void)secKillViewInvalidateTimer {
    [self.seckillTimer invalidate];
    self.seckillTimer = nil;
}
@end
