//
//  GXFSecondViewController.m
//  顶部视图放大
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 GuXuefei. All rights reserved.
//

#import "GXFSecondViewController.h"
#import "UIImageView+AFNetworking.h"
@import YYWebImage;

#define ReuseIdentifier @"cellID"
#define headerViewHeight 200

@interface GXFSecondViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation GXFSecondViewController{
    
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_imageView;
    UIView *_bottomView;
    UIStatusBarStyle _barStyle;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupTableView];
    
    [self setupHeaderView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _barStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 设置tableView的contentInset
    _tableView.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);
    
    // 设置滚动指示器位置
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
}

- (void)setupHeaderView {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headerViewHeight)];
    _headerView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:_headerView];
    
    // 添加图片框
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = _headerView.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [_headerView addSubview:_imageView];
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
//    [imageView setImageWithURL:url];
    [_imageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    // 添加底部的线
    _bottomView = [[UIView alloc] init];
    _bottomView.frame = CGRectMake(0, _headerView.bounds.size.height, _headerView.bounds.size.width, 1);
    _bottomView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_bottomView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f", _tableView.contentOffset.y + _tableView.contentInset.top);
    CGFloat offset = _tableView.contentOffset.y + _tableView.contentInset.top;
    if (offset <= 0) {
        NSLog(@"放大");
        // 只需要改变高度，然后设置填充模式即可
        CGRect frame = _headerView.frame;
        frame.size.height = headerViewHeight - offset;
        _headerView.frame = frame;
        _imageView.frame = _headerView.bounds;
        _bottomView.hidden = YES;
        
    } else {
        NSLog(@"上移");
        _bottomView.hidden = NO;
        // 直接改变imageView的y
        CGRect frame = _headerView.frame;
        CGFloat maxOffset = _headerView.bounds.size.height - 64;
        frame.origin.y = -MIN(offset, maxOffset);
        _headerView.frame = frame;
        
        // 设置图片框的透明度
        _imageView.alpha = 1 - offset/maxOffset;
        
        _barStyle = _imageView.alpha > 0.5 ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1000;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _barStyle;
}
@end
