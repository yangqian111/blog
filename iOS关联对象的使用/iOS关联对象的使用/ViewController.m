//
//  ViewController.m
//  iOS关联对象的使用
//
//  Created by 羊谦 on 2016/11/9.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


static void *const PPSMyAlertViewKey = @"PPSMyAlertViewKey";
@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你确定吗？" message:@"可能没那么确定吧" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
    void (^block) (NSInteger) = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"cancle");
        }else{
            NSLog(@"continue");
        }
    };
    
    //将block设置为UIAlertView的关联对象
    
    objc_setAssociatedObject(alert, PPSMyAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger) =  objc_getAssociatedObject(alertView, PPSMyAlertViewKey);
    block(buttonIndex);
}


@end
