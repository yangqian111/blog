//
//  PPSDBManager.m
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSDBManager.h"

static PPSDBManager *manager;
@implementation PPSDBManager

+(PPSDBManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *userID = @"ppsheep";//随便写了一个id
        manager = [[PPSDBManager alloc] initWithUserId:userID];
    });
    return manager;
}


/**
 一般的，如果有用户的APP，这里就可以传入当前用户的id 用以区分数据库
 这里我就随便写了
 @param userId 用户id
 @return 实例
 */
- (instancetype)initWithUserId:(NSString *)userId{
    if (self = [super init]) {
        NSString *commonQueuePath = [PPSDBManager dbPath:userId];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
    }
    return self;
}


/**
 数据库文件地址

 @return 地址
 */
+ (NSString *)dbPath: (NSString *)userId{
     NSString *path = [NSString stringWithFormat:@"%@/User/%@/Setting/DB/", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0], userId];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //创建数据库文件
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建数据库文件失败：%@",path);
        }
    }
    return [path stringByAppendingString:@"common.sqlite3"];
}

@end
