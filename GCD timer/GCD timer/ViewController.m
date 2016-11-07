//
//  ViewController.m
//  GCD timer
//
//  Created by 羊谦 on 2016/11/7.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block int countSecond = 30; //倒计时
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (countSecond==0) { //倒计时完毕
            //@"倒计时结束，关闭"
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时完毕需要执行的操作
            });
        }else{ //倒计时
            NSLog(@"%@", [NSString stringWithFormat:@"%ld",(long)countSecond]);
            dispatch_async(dispatch_get_main_queue(), ^{
                //每秒需要执行的操作
                //在这里更新UI之类的
            });

            countSecond--;
        }
    });
    dispatch_resume(timer);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
