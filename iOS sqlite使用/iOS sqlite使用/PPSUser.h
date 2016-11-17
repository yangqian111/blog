//
//  PPSUser.h
//  iOS sqlite使用
//
//  Created by 羊谦 on 2016/11/17.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSUser : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phoneNum;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
