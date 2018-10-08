//
//  CtyAndCntView.m
//  试用期
//
//  Created by Yasin on 2018/9/30.
//  Copyright © 2018年 ZhiYuan Network. All rights reserved.
//  分类以及数量view
//  高度: 200
#import "CtyAndCntView.h"
#import "ByMuJuView.h" //1.按模具view
#import "ByQuantity.h" //2.按数量view
#import "ByRenFenView.h" //3.按人份view
#import "ZYSegmentedControl.h" //外面要改动

#import "UIButton+Extension.h" //修改UIButton 的 文字和图片的位置。

@interface CtyAndCntView()
@property (nonatomic, strong) UILabel *titleLb; //标题 “分类以及分量”
@property (nonatomic, strong) UIButton *btn; //按钮, 先写个死的。 因为外边要修改他的值，所以放到外边
@property (nonatomic, strong) ZYSegmentedControl *segControl; //外面要改

//一次性都贴上，控制hidden 。
@property (nonatomic, strong) ByMuJuView *byMujuView; //按模具
@property (nonatomic, strong) ByQuantity *byQuantityView; //按数量
@property (nonatomic, strong) ByRenFenView *byRenFenView;//按人份


@end

@implementation CtyAndCntView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


//添加子控件
- (void)setupView {
    CGFloat kMargin10 = 10;
    //布局frame
    self.titleLb.frame = CGRectMake(10, 0, 150, 30);
    
    CGFloat x1 = (kScreen_W - 200)*0.5;
    CGFloat y1 = CGRectGetMaxY(self.titleLb.frame) + kMargin10;
    self.btn.frame = CGRectMake(x1, y1, 200, 30);
    
    self.btn.backgroundColor = [UIColor lightGrayColor]; //设置背景图片
    //修改UIButton 的 文字 图片位置(左文字+右图片)
    [self.btn leftTextRightImageWithMargin:0];

    CGFloat x2 = (kScreen_W - 200)*0.5;
    CGFloat y2 = CGRectGetMaxY(self.btn.frame) + kMargin10 ;
    self.segControl.frame = CGRectMake(x2, y2, 200, 40);
    
    CGFloat x3 = (kScreen_W - 200) * 0.5;
    CGFloat y3 = CGRectGetMaxY(self.segControl.frame) + kMargin10;
    self.byMujuView.frame = CGRectMake(x3, y3, 200, 50);
    self.byQuantityView.frame = CGRectMake(x3, y3, 200, 50);
    self.byRenFenView.frame = CGRectMake(x3, y3, 200, 50);
    
    //添加到父视图
    [self addSubview:self.titleLb];
    [self addSubview:self.btn];
    [self addSubview:self.segControl];
    [self addSubview:self.byMujuView];
    [self addSubview:self.byQuantityView];
    [self addSubview:self.byRenFenView];
    
    //默认显示视图是
    self.byMujuView.hidden = NO;
    self.byQuantityView.hidden = YES;
}


#pragma mark - lazy
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"分类及分量：";
    }
    return _titleLb;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btn setTitle:@"面包" forState:(UIControlStateNormal)];
        [_btn setTitleColor:[UIColor brownColor] forState:(UIControlStateNormal)];
        [_btn setImage:[UIImage imageNamed:@"上下.png"] forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

- (ZYSegmentedControl *)segControl {
    if (!_segControl) {
        NSArray *itemsArr = @[@"按模具",@"按个数"];
        _segControl = [[ZYSegmentedControl alloc] initWithItems:itemsArr target:self sel:@selector(segControlAction:)];
        _segControl.layer.cornerRadius = 10;
        _segControl.layer.masksToBounds = YES;
    }
    return _segControl;
}

- (ByMuJuView *)byMujuView {
    if (!_byMujuView) {
        _byMujuView = [[ByMuJuView alloc] init];

        //事件传递：第二层。
        __weak typeof(self) weakSelf = self;
        _byMujuView.byMuJuViewClickRectBlock = ^{ //矩形模具
            if (weakSelf.ctyAndCntViewClickRectBlock) {
                weakSelf.ctyAndCntViewClickRectBlock();
            }
        };
        //圆形模具
        _byMujuView.byMuJuViewClickCircleBlock = ^{
            if (weakSelf.ctyAndCntViewClickCircleBlock) {
                weakSelf.ctyAndCntViewClickCircleBlock();
            }
        };
        
        //空心圆模具
        _byMujuView.byMuJuViewClickHollowCircleBlock = ^{
            if (weakSelf.ctyAndCntViewClickHollowCircleBlock) {
                weakSelf.ctyAndCntViewClickHollowCircleBlock();
            }
        };
        
        
        
    }
    return _byMujuView;
}
- (ByQuantity *)byQuantityView {
    if (!_byQuantityView) {
        _byQuantityView = [[ByQuantity alloc] init];
        _byQuantityView.backgroundColor = [UIColor redColor];
    }
    return _byQuantityView;
}

- (ByRenFenView *)byRenFenView {
    if (!_byRenFenView) {
        _byRenFenView = [[ByRenFenView alloc] init];
        _byRenFenView.backgroundColor = [UIColor greenColor];
    }
    return _byRenFenView;
}


#pragma mark - 事件监听
- (void)clickBtnAction:(UIButton *)btn {
    NSLog(@"点击了按钮");
//    [JRToast showWithText:@"点击了按钮"];
    if (self.ctyAndCntViewClickBtnBlock) {
        self.ctyAndCntViewClickBtnBlock();
    }
}

- (void)segControlAction:(ZYSegmentedControl *)segControl {
    NSLog(@"点击了分段控制，选中的下表:%ld",segControl.selectedSegmentIndex);
    
    switch (segControl.selectedSegmentIndex) {
        case 0:
            self.byMujuView.hidden = NO;
            self.byQuantityView.hidden = YES;
            self.byRenFenView.hidden = YES;
            break;
        case 1:
        {
            self.byQuantityView.hidden = NO;
            self.byMujuView.hidden = YES;
            self.byRenFenView.hidden = YES;
        }break;
        case 2: {
            self.byRenFenView.hidden = NO;
            self.byQuantityView.hidden = YES;
            self.byMujuView.hidden = YES;
        }break;
            
        default:
            break;
    }
}

#pragma mark - 提供一个接口供外部修改内部属性、样式

/** 修改 CtyAndCntView 按钮样式 */
- (void)ctyAndCntViewChangeBtnTitle:(NSString *)title {
    //修改按钮文字
    [self.btn setTitle:title forState:(UIControlStateNormal)];
    //更新按钮的文字图片位置。必写
    [self.btn leftTextRightImageWithMargin:0];
}

/**随机修改 分段控件的items个数*/
- (void)ctyAndCntViewRandomChangeSegControlItems {
    //0-3 随机数  int intValue;   intValue = (int)(random()%100)+1;//1-100内
    NSArray *arr0 = @[@"按人份",@"按模具",@"按个数"];
    NSArray *arr1 = @[@"按模具",@"按人数"];
    NSArray *arr2 = @[@"按人份",@"按模具",@"按个数"];
    NSArray *bigArr = @[arr0,arr1,arr2];
    int randomValue = (arc4random() % 3);
    
    //更新按模具、按个数、按人份 视图
    [self.segControl insertItemWithTitleArr:bigArr[randomValue] selectedIndex:0];
}
@end
//组件 //模块

