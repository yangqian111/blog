//
//  PPSGetAppEnvironment.h
//  iOS获取当前设备的信息-网络相关
//
//  Created by 羊谦 on 2016/12/16.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PPSNetWorkType){
    PPSNetWorkTypeNone,
    PPSNetWorkType2G,
    PPSNetWorkType3G,
    PPSNetWorkType4G,
    PPSNetWorkType5G,  //  5G备用
    PPSNetWorkTypeWiFi,
};

@interface PPSGetAppEnvironment : NSObject

/*
 * 获取当前设备ip地址
 */
+ (NSString *)deviceIPAdress;

/*
 * 获取当前设备网关地址
 */
+ (NSString *)getGatewayIPAddress;

/*
 * 通过域名获取服务器IP
 */
+ (NSArray *)getDNSsWithDormain:(NSString *)hostName;

/**
 获取当前网络状况
 
 @return WIFI/chinamobile_4G
 */
+ (NSString *)currentNetInfo;


/**
 获取当前设备信息
 
 @return iOS#iPhone 7 Plus#10.1.1
 */
+ (NSString *)deviceInfo;

@end
