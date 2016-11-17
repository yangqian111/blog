//
//  ViewController.m
//  iOS动画技巧(一)
//
//  Created by 羊谦 on 2016/11/15.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *layerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
    layerView.backgroundColor = [UIColor redColor];
    layerView.center = self.view.center;
    layerView.layer.contentsGravity = kCAGravityCenter;
    [self.view addSubview:layerView];
    
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50, 50, 100, 100);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [layerView.layer addSublayer:blueLayer];
    UIImage *image = [UIImage imageNamed:@"sina"];
    layerView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    layerView.layer.contentsScale = 0.5;
    
    layerView.layer.masksToBounds = YES;
    
//    layerView.layer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.25, 0.25);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
