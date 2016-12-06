//
//  ViewController.m
//  iOS ViewController瘦身计划
//
//  Created by 羊谦 on 2016/12/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "PPSFriend.h"
#import "PPSFriendCell.h"
#import "PPSArrayDatasource.h"

@interface ViewController ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *friends;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView registerClass:[PPSFriendCell class] forCellReuseIdentifier:@"friendCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self configCell];
}


-(NSMutableArray *)friends{
    if (!_friends) {
        _friends = [NSMutableArray array];
    }
    return _friends;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableview config cell
- (void)configCell{
    void (^configCell)(PPSFriendCell *, PPSFriend *, NSIndexPath *) = ^(PPSFriendCell *cell, PPSFriend *friend, NSIndexPath *indexPath){
        cell.textLabel.text = friend.name;
    };
    PPSArrayDatasource *datasources = [[PPSArrayDatasource alloc] initWithItems:self.friends cellIdentifier:@"friendCell" configureCellBlock:configCell];
    self.tableView.dataSource = datasources;
}

@end
