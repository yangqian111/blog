//
//  ViewController.m
//  MakeRoundTextHead
//
//  Created by 羊谦 on 16/10/18.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "RoundHeadView.h"

@interface ViewController ()

@property (nonatomic, weak) RoundHeadView *roundHead;//圆形头像

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 20)];
    label.text = @"文字不同，背景颜色也不会相同";
    [self.view addSubview:label];
    
    NSArray *strs = @[@"为我",@"样的",@"好啊",@"H在",@"hc",@"2才",@"哈哈",@"打算打算打算的",@"还有人v",@"哈哈"];
    
    for (int i=0; i<10; i++) {
        RoundHeadView *head = [[RoundHeadView alloc] initWithFrame:CGRectMake(30, 100+(40*i), 40, 40)];
        [head setTitle:strs[i]];
        [self.view addSubview:head];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
