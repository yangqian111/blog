//
//  ViewController.m
//  iOS类似微信的ActionSheet
//
//  Created by 羊谦 on 2016/10/24.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "PPSActionSheet.h"

@interface ViewController ()<PPSActionSheetDelegate>

@property (nonatomic, weak) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 300, 30)];
    label.text = @"当前点击的是：";
    [self.view addSubview:label];
    
    UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 100, 30)];
    [self.view addSubview:currentLabel];
    self.label = currentLabel;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
    PPSActionSheet *sheet = [[PPSActionSheet alloc] initWithDelegate:self cancleTitle:@"取消" otherTitles:@"嘿嘿",@"啦啦",@"我玩",@"喔喔", nil];
    // 2.显示出来
    [sheet show];
}

-(void)actionSheet:(PPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            self.label.text = @"嘿嘿";
            break;
        case 2:
            self.label.text = @"啦啦";
            break;
        case 3:
            self.label.text = @"我玩";
            break;
        case 4:
            self.label.text = @"喔喔";
            break;
    }

}

@end
