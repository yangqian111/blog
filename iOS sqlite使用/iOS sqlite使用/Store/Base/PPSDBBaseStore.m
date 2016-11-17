//
//  PPSDBBaseStore.m
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSDBBaseStore.h"

@implementation PPSDBBaseStore


- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [PPSDBManager sharedInstance].commonQueue;
    }
    return self;
}

- (BOOL)createTable:(NSString *)tableName withSQL:(NSString *)sqlString
{
    __block BOOL ok = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if(![db tableExists:tableName]) {
            ok = [db executeUpdate:sqlString withArgumentsInArray:nil];
        }
    }];
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString withArrParameter:(NSArray *)arrParameter
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withArgumentsInArray:arrParameter];
        }];
    }
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString withDicParameter:(NSDictionary *)dicParameter
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withParameterDictionary:dicParameter];
        }];
    }
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString,...
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        va_list args;
        va_list *p_args;
        p_args = &args;
        va_start(args, sqlString);
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withVAList:*p_args];
        }];
        va_end(args);
    }
    return ok;
}

- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void (^)(FMResultSet * rsSet))resultBlock
{
    if (self.dbQueue) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet * retSet = [db executeQuery:sqlStr];
            if (resultBlock) {
                resultBlock(retSet);
            }
        }];
    }
}



@end
