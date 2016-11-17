//
//  ViewController.m
//  iOS每个VC单独的一个导航栏
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"1";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushTofirst) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushTofirst{
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    
    //注意这里push的时候需要使用rt_navigation push出去
    [self.rt_navigationController pushViewController:vc1 animated:YES complete:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
