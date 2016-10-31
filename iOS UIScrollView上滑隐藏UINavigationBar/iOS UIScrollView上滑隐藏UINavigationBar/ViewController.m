//
//  ViewController.m
//  iOS UIScrollView上滑隐藏UINavigationBar
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+PPSNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"11111";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //这里做一下说明  因为在iOS7之后  如果UIScrolView是第一个被 [self.view addSubview:scrollView] 添加到
    //当前的VC view上   那么之后添加到UIScrollView上的view都会在Y方向上 向下偏移64 这里加上64就是为了让UIScrollview的偏移量处于0  这样offsetY就是我们真正手势滑动的距离  如果不想要UIScrollView偏移，那么需要在VC上使用如下方法：
    //self.automaticallyAdjustsScrollViewInsets = NO 如果这样用  那么就需要在滑动时  改变TableView的frame 这样  我们移动NavigationBar的时候 才不会出现空白view
    CGFloat offsetY = scrollView.contentOffset.y+64;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY/44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar pps_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar pps_setScrollViewAlpha:(1-progress)];
}

@end
