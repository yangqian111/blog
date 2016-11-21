//
//  ConrnerViewController.m
//  iOS视觉效果
//
//  Created by 羊谦 on 2016/11/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ConrnerViewController.h"

@interface ConrnerViewController ()

@end

@implementation ConrnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    imagView.frame = CGRectMake(50, 100, 150, 200);
    imagView.layer.masksToBounds = YES;
    imagView.layer.cornerRadius = 20;
    [self.view addSubview:imagView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-10, -10, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    [imagView addSubview:view];
    
    imagView.layer.borderColor = [UIColor greenColor].CGColor;
    imagView.layer.borderWidth = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
