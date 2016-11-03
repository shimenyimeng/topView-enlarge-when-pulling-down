//
//  ViewController.m
//  顶部视图放大
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 GuXuefei. All rights reserved.
//

#import "ViewController.h"
#import "GXFSecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
}

- (void)setupNav {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(pushToSecond)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)pushToSecond {
    
    GXFSecondViewController *secondVc = [[GXFSecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
    
}
@end
