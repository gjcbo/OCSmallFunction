//
//  SecondViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/28.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//
//不要复用


#import "SecondViewController.h"
//VC
#import "FiveViewController.h" //缩放view
#import "AdjustStepsController.h" //调整步骤vc
//View
#import "NewHeaderView.h"
#import "FooterView.h"
//View----Cell
#import "NestStepCell.h"


//model
#import "StepModel.h"
//三方
#import "TZImagePickerController.h" //图片选择器
#import <MobileCoreServices/MobileCoreServices.h>


//跳转滤镜控制器
#import "ThirdViewController.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
NewHeaderViewDelegate,
TZImagePickerControllerDelegate,
UINavigationControllerDelegate
>

//底层的tableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NewHeaderView *headerVeiw;
@property (nonatomic, strong) FooterView *footerView;

@property (nonatomic, strong) NSMutableArray *stepArrM;//步骤数组。
@property (nonatomic, assign) NSInteger cnt;//标记步骤的个数。点击加号按钮自加初始值为1;
@property (nonatomic, strong) UIButton *adjustStepsBtn; // 调整步骤按钮 双箭头按钮(编辑tableView的顺序) 默认隐藏

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;


@end

@implementation SecondViewController
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

- (NSMutableArray *)stepArrM {
    if (!_stepArrM) {
        _stepArrM = [NSMutableArray array];
    }
    return _stepArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布产品";
  
    [self setupTableView]; //
    
    //初始化数组
    [self setupDataArray];
    _cnt = 1 ;//初始值为1
}

- (void)setupDataArray {
    StepModel *model1 = [[StepModel alloc] init];
    model1.name = @"步骤1";
    [self.stepArrM addObject:model1];
}

- (void)setupTableView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = self.headerVeiw;
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
        
        [_tableView registerNib:[UINib nibWithNibName:@"NestStepCell" bundle:nil] forCellReuseIdentifier:@"NestStepCell"];
        
    }
    return _tableView;
}

- (NewHeaderView *)headerVeiw {
    if (!_headerVeiw) {

        _headerVeiw = [[NewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 580 + 200)];
        _headerVeiw.delegate = self;
        _headerVeiw.headerViewBlock = ^(UIImageView *iv) {
            NSLog(@"%s--%d--%@",__FUNCTION__,__LINE__,iv);
            iv.image = [UIImage imageNamed:@"秋风萧瑟.jpg"];
        };
    }
    
    //跳转控制器。跳转到缩放视图界面。
    __weak typeof(self) weakSelf = self;
    
    _headerVeiw.newHeaderViewClickMuJuBlock = ^(MuJuType newHeaderViewMuJuType) {
        FiveViewController *fiveVC = [[FiveViewController alloc] init];
        fiveVC.mujuType = newHeaderViewMuJuType; //模具类型（矩形、圆形、空心圆)
        [weakSelf presentViewController:fiveVC animated:YES completion:nil];
    };
    return _headerVeiw;
}


- (FooterView *)footerView {
    if (!_footerView) {
        _footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    }
    return _footerView;
}

//双向箭头按钮
- (UIButton *)adjustStepsBtn {
    if (!_adjustStepsBtn) {
        _adjustStepsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_adjustStepsBtn setImage:[UIImage imageNamed:@"发布作品换层._adjustStepsBtn"] forState:(UIControlStateNormal)];
        [_adjustStepsBtn addTarget:self action:@selector(adjustStepsBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _adjustStepsBtn.hidden = YES;
    }
    return _adjustStepsBtn;
}

#pragma mark - ----------分割线--------------

#pragma mark - tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; //食材 + 步骤
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { //
        return 1;
    }else if (section == 1) { //步骤cell 个数
        return self.stepArrM.count;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) { //步骤
        
        NestStepCell *stepCell = [tableView dequeueReusableCellWithIdentifier:@"NestStepCell"];
        
        //取出模型
        StepModel *model = self.stepArrM[indexPath.row];
        stepCell.stepLb.text = model.name;
        return stepCell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld",indexPath.section, indexPath.row];
        return cell;
    }
}

//区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *sectionView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        UILabel *titleLb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        titleLb1.text = @"食材：";
        [sectionView1 addSubview:titleLb1];
        return sectionView1;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 44;
    }else {
        return 0;
    }
}

//区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) { //返回一个表位，点击动态添加cell
  
        static NSString * identy = @"headFoot";
        UITableViewHeaderFooterView *footV1 = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identy];
        if (!footV1) {
            footV1 = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identy];
            UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [addBtn setImage:[UIImage imageNamed:@"加号2-fill.png"] forState:(UIControlStateNormal)];
            CGFloat x = (kScreenW - 30)*0.5;
            addBtn.frame = CGRectMake(x, 0, 40, 40);
            [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [footV1 addSubview:addBtn];
            
            CGFloat x2 = x + 60;
            self.adjustStepsBtn.frame = CGRectMake(x2, 0, 40, 40);
            [footV1 addSubview:self.adjustStepsBtn];
        }
        return footV1;
        
    }else {
        return nil;
    }
}



#pragma mark - 添加
//添加cell
- (void)addBtnAction:(UIButton *)btn {
    NSLog(@"添加按钮");
    _cnt++;
    //创建步骤模型
    StepModel *newModel = [[StepModel alloc] init];
    newModel.name = [NSString stringWithFormat:@"步骤%ld:",_cnt];
    
    //添加到数据源数组中
    [self.stepArrM addObject:newModel];
    
    //刷新表格
    [self.tableView reloadData];
    
    if (_cnt > 1) { //步骤>1 显示双箭头
        self.adjustStepsBtn.hidden = NO;
    }else {
        self.adjustStepsBtn.hidden = YES;
    }
}

- (void)adjustStepsBtnAction:(UIButton *)btn {
    AdjustStepsController *adjustStepVC = [[AdjustStepsController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:adjustStepVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }else {
        return 0;
    }
}

#pragma mark - NewHeaderViewDelegate
- (void)fromPaiZhaoWithImageView:(UIImageView *)iv {
    
//    iv.image = [UIImage imageNamed:@"秋风萧瑟.jpg"];
    
    [self takePhoto];
}
- (void)fromAlbumWithImageView:(UIImageView *)iv {
//    iv.image = [UIImage imageNamed:@"冬雪皑皑.jpg"];
    
    [self pushTZImagePickerController];
}

#pragma mark - 图片选择器 三方
#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        [self permissionAlert];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self permissionAlert];
        
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

//权限弹框
- (void)permissionAlert {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:nil];
}


// 调用相机
- (void)pushImagePickerController {
     UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
       
        [mediaTypes addObject:(NSString *)kUTTypeImage];

        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        [JRToast showWithText:@"模拟器中无法打开照相机,请在真机中使用"];
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}


- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"111111111111111");
        //跳转滤镜控制器
//
        UIImage *img = [photos firstObject];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.headerVeiw.iv.image = img;
//        });

        dispatch_async(dispatch_get_main_queue(), ^{
            ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
            thirdVC.img = img;
            
            //回传添加滤镜后的图片
            thirdVC.thirdVCFilteredBlock = ^(UIImage *filteredImg) {
                self.headerVeiw.iv.image = filteredImg; //重新赋值
            };
            
            //添加导航条
            UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:thirdVC];
            [self presentViewController:navVC animated:YES completion:nil];
        });
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate 滑动后 回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

@end
