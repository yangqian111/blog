//
//  ViewController.m
//  iOS网络区分2、3、4G
//
//  Created by 羊谦 on 2016/10/26.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong) Reachability *intertReach;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加网络监测
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    //开启网络监测
    self.intertReach = [Reachability reachabilityForInternetConnection];
    [self.intertReach startNotifier];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 30)];
    [self.view addSubview:label];
    self.label = label;
    
    //获取当前的网络状态
    NetworkStatus status = [self.intertReach currentReachabilityStatus];
    [self judgeNetWorkStatus:status];
    
}


/**
 当网络状态发生变换时 会触发这个方法

 @param no 通知
 */
- (void)reachabilityChanged:(NSNotification *)no{
    Reachability* curReach = [no object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    [self judgeNetWorkStatus:status];
}


/**
 判断当前的网络状态

 @param status 当前的网络状态
 */
- (void)judgeNetWorkStatus:(NetworkStatus)status{
    
    switch (status){
        
    case NotReachable:
        NSLog(@"没网");
        //其他处理
        self.label.text = @"没网";
        break;
        
    case ReachableViaWiFi:
        NSLog(@"WiFi");
        self.label.text = @"WiFi";
        //其他处理
        break;
    case kReachableVia2G:
        NSLog(@"2G");
        self.label.text = @"2G";
        break;
    case kReachableVia3G:
        NSLog(@"3G");
        //其他处理
        self.label.text = @"3G";
        break;
    case kReachableVia4G:
        NSLog(@"4G");
        self.label.text = @"4G";
        //其他处理
        break;
    default:
        NSLog(@"你连的隔壁老王的网吗？");
        //其他处理
        self.label.text = @"你连的隔壁老王的网吗？";
        break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


/**
 记得移除掉
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
