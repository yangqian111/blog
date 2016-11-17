//
//  ViewController3.m
//  iOS每个VC单独的一个导航栏
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController4.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"点击直接跳到第一个viewController" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(50, 100, 100, 30);
    [btn1 sizeToFit];
    [btn1 addTarget:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"点击进入下一个vc,当前vc会被销毁" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, 200, 100, 30);
    [btn2 sizeToFit];
    [btn2 addTarget:self action:@selector(pushToDestoryCurrentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

- (void)popToRoot{
    [self.rt_navigationController popToRootViewControllerAnimated:YES complete:nil];
    
}

- (void)pushToDestoryCurrentVC{
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    [self.rt_navigationController pushViewController:vc4 animated:vc4 complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
