//
//  PPSDBUserStore.h
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSDBBaseStore.h"

@class PPSUser;
@interface PPSDBUserStore : PPSDBBaseStore

//改
- (BOOL)updateUserData:(NSArray *)users;

//增
- (BOOL)addUser:(NSArray *)users;

//查
- (NSMutableArray *)usersByUserIds:(NSArray *)userIds;

//删
- (BOOL)deleteUserByUid:(NSArray *)userIds;

- (NSArray *)allUsers;

@end
