//
//  PPSGetAppEnvironment.m
//  iOS获取当前设备的信息-网络相关
//
//  Created by 羊谦 on 2016/12/16.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSGetAppEnvironment.h"
#import <UIKit/UIKit.h>

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <netdb.h>
#import <sys/utsname.h>
#include <sys/socket.h>

#include <resolv.h>
#include <dns.h>

#import <sys/sysctl.h>
#import <netinet/in.h>

#if TARGET_IPHONE_SIMULATOR
#include <net/route.h>
#else
#include "PPSRoute.h"
#endif /*the very same from google-code*/

#define ROUNDUP(a) ((a) > 0 ? (1 + (((a)-1) | (sizeof(long) - 1))) : sizeof(long))

@implementation PPSGetAppEnvironment


/*!
 * 获取当前设备ip地址
 */
+ (NSString *)deviceIPAdress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {  // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            
            if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"] || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"])
                {
                //如果是IPV4地址，直接转化
                if (temp_addr->ifa_addr->sa_family == AF_INET){
                    
                    // Get NSString from C String
                    address = [self formatIPV4Address:((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr];
                }
                
                //如果是IPV6地址
                else if (temp_addr->ifa_addr->sa_family == AF_INET6){
                    address = [self formatIPV6Address:((struct sockaddr_in6 *)temp_addr->ifa_addr)->sin6_addr];
                    if (address && ![address isEqualToString:@""] && ![address.uppercaseString hasPrefix:@"FE80"]) break;
                }
                }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    //以FE80开始的地址是单播地址
    if (address && ![address isEqualToString:@""] && ![address.uppercaseString hasPrefix:@"FE80"]) {
        return address;
    } else {
        return @"127.0.0.1";
    }
}

+(NSString *)formatIPV4Address:(struct in_addr)ipv4Addr{
    NSString *address = nil;
    
    char dstStr[INET_ADDRSTRLEN];
    char srcStr[INET_ADDRSTRLEN];
    memcpy(srcStr, &ipv4Addr, sizeof(struct in_addr));
    if(inet_ntop(AF_INET, srcStr, dstStr, INET_ADDRSTRLEN) != NULL){
        address = [NSString stringWithUTF8String:dstStr];
    }
    
    return address;
}

+(NSString *)formatIPV6Address:(struct in6_addr)ipv6Addr{
    NSString *address = nil;
    
    char dstStr[INET6_ADDRSTRLEN];
    char srcStr[INET6_ADDRSTRLEN];
    memcpy(srcStr, &ipv6Addr, sizeof(struct in6_addr));
    if(inet_ntop(AF_INET6, srcStr, dstStr, INET6_ADDRSTRLEN) != NULL){
        address = [NSString stringWithUTF8String:dstStr];
    }
    
    return address;
}


/*!
 * 获取当前设备网关地址
 */
+ (NSString *)getGatewayIPAddress{
    NSString *address = nil;
    
    NSString *gatewayIPV4 = [self getGatewayIPV4Address];
    NSString *gatewayIPV6 = [self getGatewayIPV6Address];
    
    if (gatewayIPV6 != nil) {
        address = gatewayIPV6;
    } else {
        address = gatewayIPV4;
    }
    
    return address;
}


+ (NSString *)getGatewayIPV4Address
{
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY};
    
    size_t l;
    char *buf, *p;
    struct rt_msghdr *rt;
    struct sockaddr *sa;
    struct sockaddr *sa_tab[RTAX_MAX];
    int i;
    
    if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if (l > 0) {
        buf = malloc(l);
        if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for (p = buf; p < buf + l; p += rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for (i = 0; i < RTAX_MAX; i++) {
                if (rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if (((rt->rtm_addrs & (RTA_DST | RTA_GATEWAY)) == (RTA_DST | RTA_GATEWAY)) &&
                sa_tab[RTAX_DST]->sa_family == AF_INET &&
                sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
                unsigned char octet[4] = {0, 0, 0, 0};
                int i;
                for (i = 0; i < 4; i++) {
                    octet[i] = (((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >>
                                (i * 8)) &
                    0xFF;
                }
                if (((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                    in_addr_t addr =
                    ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                    address = [self formatIPV4Address:*((struct in_addr *)&addr)];
                    //                    NSLog(@"IPV4address%@", address);
                    break;
                }
            }
        }
        free(buf);
    }
    
    return address;
}

+ (NSString *)getGatewayIPV6Address
{
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET6, NET_RT_FLAGS, RTF_GATEWAY};
    
    size_t l;
    char *buf, *p;
    struct rt_msghdr *rt;
    struct sockaddr_in6 *sa;
    struct sockaddr_in6 *sa_tab[RTAX_MAX];
    int i;
    
    if (sysctl(mib, sizeof(mib) / sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if (l > 0) {
        buf = malloc(l);
        if (sysctl(mib, sizeof(mib) / sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for (p = buf; p < buf + l; p += rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr_in6 *)(rt + 1);
            for (i = 0; i < RTAX_MAX; i++) {
                if (rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr_in6 *)((char *)sa + sa->sin6_len);
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sin6_family == AF_INET6
               && sa_tab[RTAX_GATEWAY]->sin6_family == AF_INET6)
                {
                address = [self formatIPV6Address:((struct sockaddr_in6 *)(sa_tab[RTAX_GATEWAY]))->sin6_addr];
                //                NSLog(@"IPV6address%@", address);
                break;
                }
        }
        free(buf);
    }
    
    return address;
}


/*!
 * 通过hostname获取ip列表 DNS解析地址
 */
+ (NSArray *)getDNSsWithDormain:(NSString *)hostName{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *IPDNSs = [self getDNSWithHostName:hostName];
    if (IPDNSs && IPDNSs.count > 0) {
        [result addObjectsFromArray:IPDNSs];
    }
    
    return [NSArray arrayWithArray:result];
}


+ (NSArray *)getDNSWithHostName:(NSString *)hostName
{
    const char *hostN = [hostName UTF8String];
    Boolean result = false;
    Boolean bResolved = false;
    CFHostRef hostRef;
    CFArrayRef addresses = NULL;
    
    CFStringRef hostNameRef = CFStringCreateWithCString(kCFAllocatorDefault, hostN, kCFStringEncodingASCII);
    
    hostRef = CFHostCreateWithName(kCFAllocatorDefault, hostNameRef);
    if (hostRef) {
        result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
        if (result == true) {
            addresses = CFHostGetAddressing(hostRef, &result);
        }
    }
    bResolved = result;
    NSMutableArray *ipAddresses = [NSMutableArray array];
    if(bResolved)
        {
        struct sockaddr_in* remoteAddr;
        
        for(int i = 0; i < CFArrayGetCount(addresses); i++)
            {
            CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex(addresses, i);
            remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
            
            if(remoteAddr != NULL)
                {
                //获取IP地址
                const char *strIP41 = inet_ntoa(remoteAddr->sin_addr);
                NSString *strDNS =[NSString stringWithCString:strIP41 encoding:NSASCIIStringEncoding];
                [ipAddresses addObject:strDNS];
                }
            }
        }
    CFRelease(hostNameRef);
    if (hostRef) {
        CFRelease(hostRef);
    }
    
    return [NSArray arrayWithArray:ipAddresses];
}


/*!
 * 获取当前网络类型
 * 通过statusBar的网络subview获取具体类型
 */
+ (PPSNetWorkType)getNetworkTypeFromStatusBar
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"]
                          valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subviews) {
        if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    PPSNetWorkType nettype = PPSNetWorkTypeNone;
    NSNumber *num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    nettype = [num intValue];
    return nettype;
}


+(NSString *)currentNetInfo{
    
    NSString *returnName = nil;
    
    PPSNetWorkType type = [PPSGetAppEnvironment getNetworkTypeFromStatusBar];
    if (type == PPSNetWorkTypeWiFi) {
        returnName = @"WIFI";
        return returnName;
    }
    
    NSString *carrierName = nil;
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    if (carrier != NULL) {
        NSArray *chinaMobileMics = @[@"0",@"2",@"7"];//移动code
        NSArray *chinaTelecomMics = @[@"3",@"5",@"11"];//电信code
        NSArray *chinaUnicomMics = @[@"1",@"6"];//联通code
        NSString *mobileNetworkCode = [carrier mobileNetworkCode];
        if ([chinaMobileMics containsObject:mobileNetworkCode]) {
            carrierName = @"chinamobile";
        }else if ([chinaTelecomMics containsObject:mobileNetworkCode]){
            carrierName = @"chinatelecom";
        }else if ([chinaUnicomMics containsObject:mobileNetworkCode]){
            carrierName = @"chinaunicom";
        }else{
            carrierName = @"unknown";
        }
    } else {
        carrierName = @"unknown";
    }
    
    switch (type) {
        case PPSNetWorkType2G:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"2G"];
            break;
        case PPSNetWorkType3G:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"3G"];
            break;
        case PPSNetWorkType4G:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"4G"];
            break;
        case PPSNetWorkType5G:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"5G"];
            break;
        case PPSNetWorkTypeNone:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"unknown"];
            break;
        default:
            returnName = [NSString stringWithFormat:@"%@_%@",carrierName,@"unknown"];
            break;
    }
    return returnName;
}


/**
 获取设备的类型
 
 @return 设备类型
 */
+ (NSString *)deviceInfo {
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",        // (Original)
                              @"iPod2,1"   :@"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   :@"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" :@"iPhone",            // (Original)
                              @"iPhone1,2" :@"iPhone",            // (3G)
                              @"iPhone2,1" :@"iPhone",            // (3GS)
                              @"iPad1,1"   :@"iPad",              // (Original)
                              @"iPad2,1"   :@"iPad 2",            //
                              @"iPad3,1"   :@"iPad",              // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",          // (GSM)
                              @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",         //
                              @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",              // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",         // (Original)
                              @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",     //
                              @"iPhone7,2" :@"iPhone 6",          //
                              @"iPhone8,1" :@"iPhone 6S",         //
                              @"iPhone8,2" :@"iPhone 6S Plus",    //
                              @"iPhone8,4" :@"iPhone SE",         //
                              @"iPhone9,1" :@"iPhone 7",          //
                              @"iPhone9,3" :@"iPhone 7",          //
                              @"iPhone9,2" :@"iPhone 7 Plus",     //
                              @"iPhone9,4" :@"iPhone 7 Plus",     //
                              
                              @"iPad4,1"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   :@"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   :@"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   :@"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *systemVersion = [device systemVersion];
    
    return [NSString stringWithFormat:@"iOS#%@#%@",deviceName,systemVersion];
}





@end
