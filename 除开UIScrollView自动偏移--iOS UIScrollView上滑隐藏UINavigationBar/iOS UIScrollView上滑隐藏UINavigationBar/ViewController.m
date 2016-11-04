//
//  ViewController.m
//  iOS UIScrollView上滑隐藏UINavigationBar
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+PPSNavigationBar.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"11111";
    
    //这种情况  是  在全手动布局   除去UIScrollView的偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
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
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            //这种情况下 是NavigationBar已经全部隐藏了 改变tableview的frame
            [self setNavigationBarTransformProgress:1];
            self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
        } else {
            //这是在滑动的时候 改变tableview的frame
            [self setNavigationBarTransformProgress:(offsetY/44)];
            self.tableView.frame = CGRectMake(0, 64-offsetY, self.view.frame.size.width, self.view.frame.size.height+(64-offsetY));
        }
    } else {
        //这里是tableview恢复原位置
        self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
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
