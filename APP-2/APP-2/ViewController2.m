//
//  ViewController2.m
//  APP-2
//
//  Created by 羊谦 on 2016/10/27.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()


@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 30)];
    label.text = @"当前是  ViewController2";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
