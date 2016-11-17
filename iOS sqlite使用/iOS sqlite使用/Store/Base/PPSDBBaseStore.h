//
//  PPSDBBaseStore.h
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPSDBManager.h"

@interface PPSDBBaseStore : NSObject


// 数据库操作队列(从NADBManager中获取，默认使用commonQueue)
@property (nonatomic, weak) FMDatabaseQueue *dbQueue;

/**
 *  表创建
 */
- (BOOL)createTable:(NSString*)tableName withSQL:(NSString*)sqlString;

/*
 *  执行带数组参数的sql语句 (增，删，改)
 */
-(BOOL)excuteSQL:(NSString*)sqlString withArrParameter:(NSArray*)arrParameter;

/*
 *  执行带字典参数的sql语句 (增，删，改)
 */
-(BOOL)excuteSQL:(NSString*)sqlString withDicParameter:(NSDictionary*)dicParameter;

/*
 *  执行格式化的sql语句 (增，删，改)
 */
- (BOOL)excuteSQL:(NSString *)sqlString,...;

/**
 *  执行查询指令
 */
- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void (^)(FMResultSet * rsSet))resultBlock;

@end
