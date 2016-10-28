//
//  ViewController1.m
//  APP-2
//
//  Created by 羊谦 on 2016/10/27.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 30)];
    label.text = @"当前是   ViewController1";
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
