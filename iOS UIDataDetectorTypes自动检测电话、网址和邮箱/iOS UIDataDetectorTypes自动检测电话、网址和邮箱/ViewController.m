//
//  ViewController.m
//  iOS UIDataDetectorTypes自动检测电话、网址和邮箱
//
//  Created by 羊谦 on 2016/11/2.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView1 = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 200)];
    textView1.editable = NO;//不允许编辑
    textView1.font = [UIFont systemFontOfSize:20];
    textView1.text = @"只检测手机号------\r\n我的手机号不是： 13666666666 \r\n\r\n"
    "我的博客网址： www.ppsheep.com \r\n\r\n"
    "我的邮箱： 787688073@qq.com \r\n\r\n";
    textView1.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    [self.view addSubview:textView1];
    
    
    //UIDataDetectorType  是将网址和邮箱一起检测  点击能够相应地进入操作
    UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectMake(10, 250, self.view.frame.size.width, 200)];
    textView2.font = [UIFont systemFontOfSize:20];
    textView2.editable = NO;
    textView2.text = @"只检测网址和邮箱------\r\n我的手机号不是： 13666666666 \r\n\r\n"
    "我的博客网址： www.ppsheep.com \r\n\r\n"
    "我的邮箱： 787688073@qq.com \r\n\r\n";
    textView2.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.view addSubview:textView2];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
