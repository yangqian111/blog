//
//  Entity.m
//  iOS KVO初探
//
//  Created by 羊谦 on 2016/11/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "Entity.h"

@interface Entity()

@property (nonatomic, copy) NSString *name1;

@end

@implementation Entity
{
    @private
    NSString *_name2;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"name";
        _name1 = @"name1";
        _name2 = @"name2";
    }
    return self;
}

-(void)changeName1:(NSString *)name1{
    _name1 = name1;
}

-(void)changeName2:(NSString *)name2{
    _name2 = name2;
}


@end
