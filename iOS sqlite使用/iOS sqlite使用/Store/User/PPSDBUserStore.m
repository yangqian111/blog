//
//  PPSDBUserStore.m
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSDBUserStore.h"
#import "PPSUser.h"
#import "PPSDBUserSQL.h"

//METHOD
#define     PPSNoNilString(str)  (str.length > 0 ? str : @"")

@implementation PPSDBUserStore


- (id)init
{
    if (self = [super init]) {
        //父类中 已经默认使用commonQueue
        //        self.dbQueue = [NADBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 好友表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_USER_TABLE, USER_TABLE_NAME];
    return [self createTable:USER_TABLE_NAME withSQL:sqlString];
}


-(BOOL)addUser:(NSArray *)users{
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_USER, USER_TABLE_NAME];
    NSArray *usersCopy = [users copy];
    BOOL ok = YES;
    for (PPSUser *user in usersCopy) {
        NSArray *arrPara = [NSArray arrayWithObjects:
                            PPSNoNilString(user.userId),
                            PPSNoNilString(user.name),
                            PPSNoNilString(user.email),
                            PPSNoNilString(user.phoneNum),
                            @"", @"", @"", @0, @0, @0,  nil];
        ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    }
    return ok;
}

-(BOOL)deleteUserByUid:(NSArray *)userIds{
    NSArray *ids = [userIds copy];
    BOOL ok = YES;
    for (NSString *userId in ids) {
        NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_USER, USER_TABLE_NAME, userId];
        ok = [self excuteSQL:sqlString, nil];
    }
    return ok;
}

-(BOOL)updateUserData:(NSArray *)users{
    NSArray *userCopy = [users copy];
    BOOL ok = YES;
    for (PPSUser *user in userCopy) {
        NSString *sql = [NSString stringWithFormat:SQL_UPDATE_USER, USER_TABLE_NAME, user.userId];
        NSArray *arrPara = [NSArray arrayWithObjects:
                            PPSNoNilString(user.name),
                            PPSNoNilString(user.email),
                            PPSNoNilString(user.phoneNum),
                            @"", @"", @"", @0, @0, @0,  nil];
        ok = [self excuteSQL:sql withArrParameter:arrPara];
    }
    return ok;
}

-(NSMutableArray *)usersByUserIds:(NSArray *)userIds{
    NSArray *ids = [userIds copy];
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    
    for (NSString *userId in ids) {
      NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_USER, USER_TABLE_NAME, userId];
        [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
            while ([retSet next]) {
                NSDictionary *dic = @{
                                      @"userId" : [retSet stringForColumn:@"uid"],
                                      @"email" : [retSet stringForColumn:@"email"],
                                      @"name" : [retSet stringForColumn:@"name"],
                                      @"phoneNum" : [retSet stringForColumn:@"phoneNum"],
                                      };
                PPSUser *user = [[PPSUser alloc] initWithDic:dic];
                [data addObject:user];
            }
            [retSet close];
        }];
    }
    return data;
}

-(NSArray *)allUsers{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_GET_ALL_USER,USER_TABLE_NAME];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            NSDictionary *dic = @{
                                  @"userId" : [retSet stringForColumn:@"uid"],
                                  @"email" : [retSet stringForColumn:@"email"],
                                  @"name" : [retSet stringForColumn:@"name"],
                                  @"phoneNum" : [retSet stringForColumn:@"phoneNum"],
                                  };
            PPSUser *user = [[PPSUser alloc] initWithDic:dic];
            [data addObject:user];
        }
        [retSet close];
    }];
    return data;
}

@end
