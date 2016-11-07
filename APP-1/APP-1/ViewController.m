//
//  ViewController.m
//  APP-1
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
    label.text = @"当前是APP-1";
    [self.view addSubview:label];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 200, 30)];
    [btn1 setTitle:@"跳转到第一个界面" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(jumpToApp2_1) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    [btn2 setTitle:@"跳转到第二个界面" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(jumpToApp2_2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 300, 30)];
    [btn3 setTitle:@"跳转传递参数并且能够调回的页面" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(jumpToApp2_3) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn3];
}

- (void)jumpToApp2_1{
    //获取APP2的URL Scheme
    NSURL *appURL = [NSURL URLWithString:@"APP2://VC1"];
    
    //判断手机中是否安装了APP2
    if ([[UIApplication sharedApplication] canOpenURL:appURL]) {
        //打开APP2的ViewController1
        [[UIApplication sharedApplication] openURL:appURL];
    }else{
        NSLog(@"没有安装APP2");
    }
// ---------------如果是iOS9之前，上面代码就可以实现跳转了---------------------
// ---------------iOS9之后需要在应用程序中加上白名单，即在APP-1中加上APP-2的白名单---------
// ----------------在APP-1的Info中 添加键值对LSApplicationQueriesSchemes---------------------------------
    
}

- (void)jumpToApp2_2{
    //获取APP2的URL Scheme
    NSURL *appURL = [NSURL URLWithString:@"APP2://VC2"];
    
    //判断手机中是否安装了APP2
    if ([[UIApplication sharedApplication] canOpenURL:appURL]) {
        //打开APP2ViewController2
        [[UIApplication sharedApplication] openURL:appURL];
    }else{
        NSLog(@"没有安装APP2");
    }
    // ---------------如果是iOS9之前，上面代码就可以实现跳转了---------------------
    // ---------------iOS9之后需要在应用程序中加上白名单，即在APP-1中加上APP-2的白名单---------
    // ----------------在APP-1的Info中 添加键值对LSApplicationQueriesSchemes---------------------------------
    
}

- (void)jumpToApp2_3{
    //获取APP2的URL Scheme 还需要带上当前App的APP1
    NSString *URLScheme = @"APP2://APP1";
    
    //我们参数需要穿name age
    NSString *params = @"name=yq&age=23";
    //接下来加上我们需要携带的参数
    NSString *realURL = [NSString stringWithFormat:@"%@?%@",URLScheme,params];
    
    NSURL *appURL = [NSURL URLWithString:realURL];
    
    
    //判断手机中是否安装了APP2
    if ([[UIApplication sharedApplication] canOpenURL:appURL]) {
        //打开APP2ViewController2
        [[UIApplication sharedApplication] openURL:appURL];
    }else{
        NSLog(@"没有安装APP2");
    }
    // ---------------如果是iOS9之前，上面代码就可以实现跳转了---------------------
    // ---------------iOS9之后需要在应用程序中加上白名单，即在APP-1中加上APP-2的白名单---------
    // ----------------在APP-1的Info中 添加键值对LSApplicationQueriesSchemes---------------------------------
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
