//
//  ThirdViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/29.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//
/**
 1、iOS 保存照片的三种方式。https://www.jianshu.com/p/bf20733ba19b
 
 */

#import "ThirdViewController.h"
#import "AlbumFiterViewCell.h"
#import "AlbumFiterModel.h"
#import "AlbumFilterManager.h"
#import "Constant.h"
//#import <Photos/Photos.h> //保存图片到相册 PHPhotoLibrary 使用该框架的该类

@interface ThirdViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@property (nonatomic, strong) UICollectionView *clv;
@property (nonatomic, strong) NSMutableArray *albumFiterImages;
/**缓存渲染之后的图片*/
@property (nonatomic, strong) UIImage *cacheRenderedImg;

@end

static NSString * const reuseIdentifier = @"AlbumFiterViewCellIdentifier";

@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //初始化数据源
    [self initDataSouce];
    
    //初始导航条
    [self setupNav];
    
    //初始化clv
    [self setupCollectionView];
    
    self.iv.image = self.img;
}

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveToAlbumAction:)];
}

- (void)saveToAlbumAction:(UIBarButtonItem *)item {
    NSLog(@"点击了完成:%@",item.title);
    
    UIImageWriteToSavedPhotosAlbum(self.cacheRenderedImg, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
    //2.将添加滤镜后的图片回传出去
    self.thirdVCFilteredBlock(self.cacheRenderedImg);
    
    //3.视图消失
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)image:(UIImage *)img didFinishSavingWithError:(NSError *)err contextInfo:(void *)info {
    NSLog(@"图片:%@, err:%@, info: %@",img,err, info);
    
    if (err) {
        [JRToast showWithText:@"保存到相册失败"];
    }else {
        [JRToast showWithText:@"成功保存到相册"];
    }
}


- (void)setupCollectionView {
    [self.view addSubview:self.clv];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumFiterImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumFiterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.fiter = self.albumFiterImages[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了:%ld---%ld",indexPath.section, indexPath.row);

    UIImage *renderedImg = [self renderImg:self.img didSelectedIndex:indexPath.row];
    self.iv.image = renderedImg;
    
    NSLog(@"当前线程:%@",[NSThread currentThread]);
}


//渲染图片
- (UIImage *)renderImg:(UIImage *)img didSelectedIndex:(NSInteger)index {
    //1.获取GPU 滤镜样式
    GPUImageColormatrixFilterType filterType = [[AlbumFilterManager shareManager] colormatrixFilterTypeByIndex:index];
    
    //2.滤镜渲染
    UIImage *renderedImg = [[AlbumFilterManager shareManager] imageByFilteringImage:img filterType:filterType];
    
    //3.缓存添加滤镜后的图片(后面要用)
    self.cacheRenderedImg = renderedImg;
    
    return renderedImg;
}


#pragma mark - 布局用的 UICollectionViewDelegateFlowLayout
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
        //1.初始化模型
        AlbumFiterModel *model = [[AlbumFiterModel alloc] init];
        GPUImageColormatrixFilterType filterType = [[AlbumFilterManager shareManager] colormatrixFilterTypeByIndex:i];
        //1-1.滤镜的名字
        model.thumbnailName = [[AlbumFilterManager shareManager] getFilterName:filterType];
        //1-2 滤镜效果图片
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
        CGFloat y = kScreen_W - 120;
        CGFloat clvHeight = 100;
        CGRect frame = CGRectMake(0, y, kScreen_W, clvHeight);
        _clv = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _clv.delegate = self;
        _clv.dataSource = self;
        _clv.backgroundColor = [UIColor whiteColor];
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
