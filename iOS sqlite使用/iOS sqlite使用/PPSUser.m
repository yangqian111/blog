//
//  PPSUser.m
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSUser.h"

@implementation PPSUser

- (instancetype)initWithDic:(NSDictionary *)dic{
    NSDictionary *dicCopy = [dic copy];
    self = [super init];
    if (self) {
        _userId = dicCopy[@"userId"];
        _name = dicCopy[@"name"];
        _email = dicCopy[@"email"];
        _phoneNum = dicCopy[@"phoneNum"];
    }
    return self;
}

@end
