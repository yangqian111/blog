//
//  ViewController.m
//  APP-2
//
//  Created by 羊谦 on 2016/10/27.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    label.text = @"当前是APP2";
    [self.view addSubview:label];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
