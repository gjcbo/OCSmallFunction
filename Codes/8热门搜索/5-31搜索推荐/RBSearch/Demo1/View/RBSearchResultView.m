//
//  RBSearchResultView.m
//  5-31搜索推荐
//
//  Created by RaoBo on 2018/8/2.
//  Copyright © 2018年 关键词. All rights reserved.
//  搜索结果view

#import "RBSearchResultView.h"
@interface RBSearchResultView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tv;

@end

@implementation RBSearchResultView

#pragma mark - 一 lazy
- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        NSString *clsName = NSStringFromClass([UITableViewCell class]);
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:clsName];
        
        _tv.tableFooterView = [UIView new];
    }
    return _tv;
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
    self.tv.frame = self.bounds;
    [self addSubview:self.tv];
}

#pragma mark - 三 UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *clsName = NSStringFromClass([UITableViewCell class]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clsName];
    
    cell.textLabel.text = self.resultArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld---",indexPath.row);
    
    NSString *str = self.resultArr[indexPath.row];
    
    if (self.searchResultViewClickCellBlock) {
        self.searchResultViewClickCellBlock(str, indexPath);
    }
}


#pragma mark - set 刷新
- (void)setResultArr:(NSMutableArray<NSString *> *)resultArr {
    _resultArr = resultArr;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tv reloadData];
    });
}

#pragma mark - 二 点击事件



@end
