//
//  ShadowViewController.m
//  iOS视觉效果
//
//  Created by 羊谦 on 2016/11/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ShadowViewController.h"

@interface ShadowViewController ()

@end

@implementation ShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imagView.frame = CGRectMake(100, 200, 150, 200);
    [self.view addSubview:imagView];
    
//    imagView.layer.shadowColor = [UIColor redColor].CGColor;
//    imagView.layer.shadowOffset = CGSizeMake(0, 5);
//    imagView.layer.shadowRadius = 5;
    imagView.layer.shadowOpacity = 0.5;
    

//    CGMutablePathRef squarePath = CGPathCreateMutable();
//    CGPathAddRect(squarePath, NULL, imagView.bounds);
//    imagView.layer.shadowPath = squarePath; CGPathRelease(squarePath);

    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, imagView.bounds);
    imagView.layer.shadowPath = circlePath; CGPathRelease(circlePath);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
