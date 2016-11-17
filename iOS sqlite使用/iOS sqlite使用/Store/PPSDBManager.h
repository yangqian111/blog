//
//  PPSDBManager.h
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface PPSDBManager : NSObject


/**
 *  DB队列  还可以定义其他的数据库 这里只是一个示例
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

+ (PPSDBManager *)sharedInstance;

/**
 创建数据库文件

 @param userId 传入用户id
 @return 数据库文件地址
 */
+ (NSString *)dbPath:(NSString *)userId;

@end
