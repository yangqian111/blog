//
//  ViewController.m
//  iOS KVO初探
//
//  Created by 羊谦 on 2016/11/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "Entity.h"

@interface ViewController ()

@property (nonatomic, strong) Entity *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.model  = [[Entity alloc] init];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100,200, 30)];
    btn1.tag = 100001;
    [btn1 addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"改变name" forState:UIControlStateNormal];
    [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200,200, 30)];
    btn2.tag = 100002;
    [btn2 addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"改变值name1" forState:UIControlStateNormal];
     [self.model addObserver:self forKeyPath:@"name1" options:NSKeyValueObservingOptionNew context:nil];
    
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300,200, 30)];
    btn3.tag = 100003;
    [btn3 addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"改变值name2" forState:UIControlStateNormal];
    [self.model addObserver:self forKeyPath:@"name2" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    
   
}

//KVO监听回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@", keyPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)changeName: (UIButton *)btn{
    switch (btn.tag) {
        case 100001:
            self.model.name = @"change";
            break;
        case 100002:
            [self.model changeName1:@"change"];
            break;
        case 100003:
            [self.model changeName2:@"changge"];
            break;
        default:
            break;
    }
}

@end
