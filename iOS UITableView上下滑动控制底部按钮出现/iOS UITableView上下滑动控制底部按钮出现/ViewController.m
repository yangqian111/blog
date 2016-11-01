//
//  ViewController.m
//  iOS UITableView上下滑动控制底部按钮出现
//
//  Created by 羊谦 on 2016/11/1.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, weak) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"11";
    
    //加上这句  UIScrollView的Content就不会自动偏移64(导航栏和状态栏的高度)
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN.width, SCREEN.height-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width / 2 - 25, self.view.frame.size.height - 50, 50, 50);
    [btn setBackgroundImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
    self.btn = btn;
    [self.view addSubview:self.btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

#pragma mark - UITableView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {//向上滑动
        //按钮消失
        [UIView transitionWithView:self.btn duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.btn.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height, 50, 50);
        } completion:NULL];
    }else if (scrollView.contentOffset.y < self.offsetY ){//向下滑动
        //按钮出现
        [UIView transitionWithView:self.btn duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.btn.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
}

@end
