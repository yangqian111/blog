//
//  ViewController1ViewController.m
//  iOS每个VC单独的一个导航栏
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController3.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"2";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label.text = @"自定义返回键";
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(leftBar1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"返回1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 sizeToFit];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"返回2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(leftBar2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [btn2 sizeToFit];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];

    self.navigationItem.leftBarButtonItems = @[item1,item2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"右键" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(rightBarClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn3 sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:label];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(50, 200, 100, 30);
    [btn4 setTitle:@"点击" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
}

- (void)leftBar1Clicked{
    [self.rt_navigationController popViewControllerAnimated:YES];
}

- (void)leftBar2Clicked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"点击返回2" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}

- (void)rightBarClicked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"点击右键" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}

- (void)btn4Clicked{
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    [self.rt_navigationController pushViewController:vc3 animated:YES complete:nil];
}


///**
// 如果对于返回事件不需要做任何处理，
// 但是有想要自定义返回按钮的样式，
// 可以直接重写这个方法
//
// @param target 监听对象
// @param action 返回事件
// @return 自定义的返回按钮
// */
//-(UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn sizeToFit];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    return item;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
