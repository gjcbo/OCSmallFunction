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

@interface FiveViewController () <VSliderDelegate,
HSliderDelegate
>
/**背景图片 所有的小控件都添加到这上面*/
@property (nonatomic, strong) UIView *bgView;
/**1.消失按钮*/
@property (nonatomic, strong) UIButton *disBtn;

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
}

//添加控件、设置frame
- (void)setupView {
    [self.view addSubview:self.bgView];
    
    //所有的子控件都添加在 self.bgView上
    self.disBtn.frame = CGRectMake(self.view.frame.size.width - 50, 0, 40, 40);
    [self.bgView addSubview:self.disBtn];
    
    //模具
    self.mujuIv.frame = CGRectMake(100, 200, 150, 150);
    //需求，需要扰中心点缩放。不对 ❌
//    self.mujuIv.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
//    self.mujuIv.layer.position = CGPointMake(100, 200);
    [self.bgView addSubview:self.mujuIv];
    
    //写死是有问题的
    //垂直滑块: CGRectMake(x, y, w, h)
    self.vSlider = [[VSlider alloc] initWithFrame:CGRectMake(10, 180, 50, 180)];
    self.vSlider.delegate = self; //设置代理
    [self.bgView addSubview:self.vSlider];

    
    //水平滑块
    self.hSlider = [[HSlider alloc] initWithFrame:CGRectMake(30, 350 , 180, 40)];
    self.hSlider.delegate = self; //设置代理对象
    [self.bgView addSubview:self.hSlider];
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


#pragma mark - VSliderDelegate & HSliderDelegate
//垂直
- (void)vSliderChangedValue:(CGFloat)value {

    //修改 mujuIv的frame
    CGRect mujuFrame = self.mujuIv.frame;
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
    self.mujuIv.frame = mujuFrame;
    self.vSlider.vLb.text = [NSString stringWithFormat:@"%.0f厘米",value *38];
}

- (void)hSliderDidChangeValue:(CGFloat)value {
    CGRect mujuFrame = self.mujuIv.frame;
    CGFloat w = self.mujuIv.frame.size.width;
    
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
    mujuFrame.size.width = tempW;
    
    self.mujuIv.frame = mujuFrame;
    
    self.hSlider.hLb.text = [NSString stringWithFormat:@"%.0f",value * 50];
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
