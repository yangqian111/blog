//
//  ViewController.m
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "PPSDBUserStore.h"
#import "PPSUser.h"

@interface ViewController ()

@property (nonatomic, strong) PPSDBUserStore *store;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self updateUsers];
//    NSArray *users = [self.store allUsers];
//    [self.store deleteUserByUid:@[@"0_userId"]];
//    [self initUsers];
    
    
}

- (void)updateUsers{
    NSMutableArray *arr=  [self.store usersByUserIds:@[@"1_userId"]];
    PPSUser *userCopy = nil;
    for (PPSUser *user in arr) {
        user.name = @"hahaha";
        userCopy = user;
    }
    [self.store updateUserData:@[userCopy]];
}

- (void)initUsers{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        PPSUser *user = [[PPSUser alloc] init];
        user.userId = [NSString stringWithFormat:@"%ld_userId",(long)i];
        user.name = [NSString stringWithFormat:@"%ld_userName",(long)i];
        user.email = [NSString stringWithFormat:@"%ld_email",(long)i];
        user.phoneNum = [NSString stringWithFormat:@"%ld_phoneNum",(long)i];
        [arr addObject:user];
    }
    [self.store addUser:arr];
}

-(PPSDBUserStore *)store{
    if (!_store) {
        _store = [[PPSDBUserStore alloc] init];
    }
    return _store;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
