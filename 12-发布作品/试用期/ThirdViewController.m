//
//  ThirdViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//

#import "ThirdViewController.h"
#import "AlbumFiterViewCell.h"
#import "AlbumFiterModel.h"
#import "AlbumFilterManager.h"
#import "Constant.h"
@interface ThirdViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@property (nonatomic, strong) UICollectionView *clv;
@property (nonatomic, strong) NSMutableArray *albumFiterImages;

@end

static NSString * const reuseIdentifier = @"AlbumFiterViewCellIdentifier";

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //初始化数据源
    [self initDataSouce];
    
    self.iv.image = self.img;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumFiterImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumFiterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.fiter = self.albumFiterImages[indexPath.row];

    return cell;
}

//先敲返回值， 在敲方法名，可以先过滤一部分。
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 12, 0, 12);
}

#pragma mark - 初始化数据源
- (void)initDataSouce {

    if(self.img == nil) return; //一般不会为空的
    
    for (int i=0; i< 8; i++) {
        //初始化模型
        AlbumFiterModel *model = [[AlbumFiterModel alloc] init];
        GPUImageColormatrixFilterType filterType = [[AlbumFilterManager shareManager] colormatrixFilterTypeByIndex:i];
        model.thumbnailName = [[AlbumFilterManager shareManager] getFilterName:filterType];
        
        UIImage *filterImg = [[AlbumFilterManager shareManager] imageByFilteringImage:self.img filterType:filterType];
        model.thumbnailImage = filterImg;
        
        [self.albumFiterImages addObject:model];
    }
}


#pragma mark - lazy
- (UICollectionView *)clv {
    if (!_clv) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
        
        CGFloat clvHeight = kScreen_H - CGRectGetMaxY(self.iv.frame);
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.iv.frame), kScreen_W, clvHeight);
        
        _clv = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _clv.backgroundColor = [UIColor whiteColor];
        _clv.delegate = self;
        _clv.dataSource = self;
        [_clv registerClass:[AlbumFiterViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self.view addSubview:_clv];
    }
    return _clv;
}

- (NSMutableArray *)albumFiterImages {
    if (!_albumFiterImages) {
        _albumFiterImages = [NSMutableArray array];
    }
    return _albumFiterImages;
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
