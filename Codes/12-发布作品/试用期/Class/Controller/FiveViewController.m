//
//  FiveViewController.m
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
// 不要畏难，不要怕麻烦，你只有写，你才能进步，越怕，越干。回过头再来看，这TMD只不过是浮云，有什么呀。

#import "FiveViewController.h"
#import "VSlider.h"
#import "HSlider.h"

//尝试使用masonry进行布局 ，不尝试了，是要修改frame的大小，是要进行缩放的。
//#import "Masonry.h"

static NSString *RightTableViewCellId = @"RightTableViewCellId";
@interface FiveViewController () <VSliderDelegate,
HSliderDelegate,
UITableViewDelegate,UITableViewDataSource
>
/**背景图片 所有的小控件都添加到这上面*/
@property (nonatomic, strong) UIView *bgView;
/**1.消失按钮*/
@property (nonatomic, strong) UIButton *disBtn;

@property (nonatomic, strong) UIView *div1;

/**1.左边分段控制器*/
@property (nonatomic, strong) UISegmentedControl *segLeft;
/**2.右边分段控制器*/
@property (nonatomic, strong) UISegmentedControl *segRight;
/**3.中间模具 imageView(方形、圆形、空心圆形)*/
@property (nonatomic, strong) UIImageView *mujuIv;
/**垂直滑块*/
@property (nonatomic, strong) VSlider *vSlider;
/**水平滑块*/
@property (nonatomic, strong) HSlider *hSlider;
@property (nonatomic, strong) UITableView *rightTv;//右边的小tableView



@end

@implementation FiveViewController
#pragma mark - 1 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, kScreen_W - 20, 50)];
    lb.text = @"缩放";
    [self.view addSubview:lb];
    
    //布局子视图
    [self setupView];
    
    [self showOrHideVSliderHSliderAndMuJuImageByMuJuType:self.mujuType];
}

/**根据前面传递过来的 模具类型显示不同的 模具图片 以及 vSlide 和hSlider 的显示或隐藏*/
- (void)showOrHideVSliderHSliderAndMuJuImageByMuJuType:(MuJuType)mujutype {
    switch (mujutype) {
        case MuJuRectType: {
               NSLog(@"矩形模具");
            //默认图片:矩形模具
            
        }break;
        case MuJuCircleType: {
            NSLog(@"圆形模具");
            self.mujuIv.image = [UIImage imageNamed:@"fbzpamjdy"];
            self.vSlider.hidden = YES; //垂直滑块隐藏
        }break;
        case MuJuHollowCircleType: {
            NSLog(@"空心圆模具");
            self.mujuIv.image = [UIImage imageNamed:@"fbzpamjkxy"];
            self.vSlider.hidden = YES; //垂直滑块隐藏
        }break;
        default:
            break;
    }
}




//添加控件、设置frame
- (void)setupView {
    [self.view addSubview:self.bgView];
    
    //所有的子控件都添加在 self.bgView上
    self.disBtn.frame = CGRectMake(self.view.frame.size.width - 50, 0, 40, 40);
    [self.bgView addSubview:self.disBtn];
    
    //模具
    self.mujuIv.frame = CGRectMake(60, 200, 150, 150);
    //需求，需要扰中心点缩放。不对 ❌
//    self.mujuIv.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
//    self.mujuIv.layer.position = CGPointMake(100, 200);
    [self.bgView addSubview:self.mujuIv];

    
    self.div1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.disBtn.frame), kScreen_W, 40)];
    [self.bgView addSubview:self.div1];

    //希望水平居中
    CGFloat segH = 30;
    CGFloat segY = (CGRectGetHeight(self.div1.frame) - segH) *0.5;
    self.segLeft.frame = CGRectMake(10, segY, 150, 30);
    self.segLeft.backgroundColor = [UIColor whiteColor];
    self.segLeft.tintColor = [UIColor brownColor];
    self.segRight.frame = CGRectMake(kScreen_W - 110,segY, 100, 30);
    self.segRight.backgroundColor = [UIColor whiteColor];
    self.segRight.tintColor = [UIColor brownColor];
    [self.div1 addSubview:self.segLeft];
    [self.div1 addSubview:self.segRight];
    
    
    //写死是有问题的
    //垂直滑块: CGRectMake(x, y, w, h)
    self.vSlider = [[VSlider alloc] initWithFrame:CGRectMake(10, 180, 50, 180)];
    self.vSlider.delegate = self; //设置代理
    [self.bgView addSubview:self.vSlider];

    
    //水平滑块
    self.hSlider = [[HSlider alloc] initWithFrame:CGRectMake(30, 350 , 180, 40)];
    self.hSlider.delegate = self; //设置代理对象
    [self.bgView addSubview:self.hSlider];
    
    CGFloat rightTV_X = self.view.frame.size.width - 80;
    self.rightTv.frame = CGRectMake(rightTV_X, 200, 70, 100);
    [self.bgView addSubview:self.rightTv];
}


#pragma mark - lazy
//1.背景图片
- (UIView *)bgView {
    if (!_bgView) {
        CGFloat h = self.view.frame.size.height;
        CGFloat w = self.view.frame.size.width;
        CGFloat bg_h = h *0.7;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, h - bg_h, w, bg_h)];
//        _bgView.backgroundColor = [UIColor lightGrayColor];
        _bgView.backgroundColor = UICOLOR_HEX(0xF4F4F4);
    }
    return _bgView;
}
- (UIButton *)disBtn {
    if (!_disBtn) {
        _disBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_disBtn setImage:[UIImage imageNamed:@"叉号.png"] forState:(UIControlStateNormal)];
        [_disBtn addTarget:self action:@selector(disBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _disBtn;
}
- (void)disBtnAction:(UIButton *)btn {
    NSLog(@"消失");
    [self dismissViewControllerAnimated:YES completion:nil];
}


//2.左边分段控制器

//3.右边分段控制器
//4.中间 模具 iv
- (UIImageView *)mujuIv {
    if (!_mujuIv) {
        _mujuIv = [[UIImageView alloc] init];
        //默认模具为方形
        _mujuIv.image = [UIImage imageNamed:@"fbzpamjdf"];
    }
    return _mujuIv;
}

/////////////////
- (UIView *)div1 {
    if (!_div1) {
        _div1 = [[UIView alloc] init];
    }
    return _div1;
}
- (UISegmentedControl *)segLeft {
    
    if (!_segLeft) {
//        UIImage *rectImg = [UIImage imageNamed:@""]; //矩形
//        UIImage *circleImg = [UIImage imageNamed:@""];//圆形
//        UIImage *hollowCircleImg = [UIImage imageNamed:@""];//空心圆
        //        NSArray *items = @[rectImg,circleImg,hollowCircleImg];
        
        _segLeft = [[UISegmentedControl alloc] initWithItems:@[@"方形",@"圆形",@"空心圆"]];
        
        [_segLeft addTarget:self action:@selector(segLeftAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _segLeft;
}

- (UISegmentedControl *)segRight {
    if (!_segRight) {
        _segRight = [[UISegmentedControl alloc] initWithItems:@[@"厘米",@"英寸"]];
        [_segRight addTarget:self action:@selector(segRightAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _segRight;
}

- (UITableView *)rightTv {
    if (!_rightTv) {
        _rightTv = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _rightTv.delegate = self;
        _rightTv.dataSource = self;
        //注册cell
        [_rightTv registerClass:[UITableViewCell class] forCellReuseIdentifier:RightTableViewCellId];
    }
    return _rightTv;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RightTableViewCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld个",indexPath.row];
    return cell;
}

#pragma mark - 分段控件事件监听
- (void)segLeftAction:(UISegmentedControl *)seg {
    NSLog(@"1.左 选中的下标是:%ld",seg.selectedSegmentIndex);
    switch (seg.selectedSegmentIndex) {
        case 0: //方形
        {self.mujuIv.image = [UIImage imageNamed:@"fbzpamjdf"];
            self.vSlider.hidden = NO;
        } break;
        case 1: //圆形
        {   self.mujuIv.image = [UIImage imageNamed:@"fbzpamjdy"];
            self.vSlider.hidden = YES;
        } break;
        case 2: //空心圆
        {   self.mujuIv.image = [UIImage imageNamed:@"fbzpamjkxy"];
            self.vSlider.hidden = YES;
        } break;
            
        default:
            break;
    }
}

- (void)segRightAction:(UISegmentedControl *)seg {
    NSLog(@"2.右 选中的下标是:%ld",seg.selectedSegmentIndex);
    
    NSString *unit = @"厘米";
    if (seg.selectedSegmentIndex == 0) { //厘米
        unit = @"厘米";
    }else { //inch
        unit = @"英寸";
    }
    //垂直方向
    self.vSlider.unitStr = unit;
    self.vSlider.vLb.text = [NSString stringWithFormat:@"%.0f%@",self.vSlider.length,self.vSlider.unitStr];

    //水平方向
    self.hSlider.unitStr = unit;
    self.hSlider.hLb.text = [NSString stringWithFormat:@"%.0f%@",self.vSlider.length,self.vSlider.unitStr];
}


#pragma mark - VSliderDelegate & HSliderDelegate
//垂直
- (void)vSliderChangedValue:(CGFloat)value {

    //修改 mujuIv的frame
    CGRect mujuFrame = self.mujuIv.bounds;
    CGFloat h = mujuFrame.size.height;
    
    if (value < 0.1) {
        value = 0.1;
    }
    if (h < 10) {
        h = 10;
    }else{
        h = 150;
    }
    
    CGFloat tempH = value * h;

    mujuFrame.size.height = tempH;
    self.mujuIv.bounds = mujuFrame;
    
    //view直接当model使
    self.vSlider.length = value * 38;
    self.vSlider.unitStr = @"厘米";
    self.vSlider.vLb.text = [NSString stringWithFormat:@"%.0f%@",self.vSlider.length,self.vSlider.unitStr];
}

- (void)hSliderDidChangeValue:(CGFloat)value {
    
    CGRect mujuFrame = self.mujuIv.frame;
    CGFloat w = self.mujuIv.bounds.size.width;
    
    //处理边界情况
    if (value < 0.1) {
        value = 0.1;
    }
    if (w < 10) {
        w = 10;
    }else {
        w = 150;
    }
    
    CGFloat tempW = value * w;

    if (self.mujuType == MuJuRectType) { //方形模具 ： 自由缩放
        mujuFrame.size.width = tempW;

    }else { //圆形模具 ：等比缩放
        mujuFrame.size.width = tempW;
        mujuFrame.size.height = tempW;
    }
    
    self.mujuIv.bounds = mujuFrame;
    
    self.hSlider.length = value * 50;
    self.hSlider.unitStr = @"厘米";
    self.hSlider.hLb.text = [NSString stringWithFormat:@"%.0f%@",self.hSlider.length,self.hSlider.unitStr];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
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
