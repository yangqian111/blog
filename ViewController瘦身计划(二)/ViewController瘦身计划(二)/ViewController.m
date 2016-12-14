//
//  ViewController.m
//  ViewController瘦身计划(二)
//
//  Created by 羊谦 on 2016/12/14.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController.h"

@interface ViewController ()<MyTableViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMyTableViewController];
    [self addOtherView];
}

- (void)addMyTableViewController{
    MyTableViewController *vc = [[MyTableViewController alloc] init];
    vc.delegate = self;
    [self addChildViewController:vc];
    CGRect frame = self.view.bounds;
    frame.size.height = 300;
    vc.view.frame = frame;
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)addOtherView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 100, 30)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

-(void)didSelectCell{
    NSLog(@"点击");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
