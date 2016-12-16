//
//  ViewController.m
//  iOS获取当前设备的信息-网络相关
//
//  Created by 羊谦 on 2016/12/16.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "PPSGetAppEnvironment.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *domainTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *logInfo;
@property (nonatomic, strong) NSMutableString *logText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startButton.layer.cornerRadius = 5;
    self.logText = [[NSMutableString alloc] initWithString:@""];
}

- (IBAction)start:(id)sender {
    
    //获取局域网IP
    NSString *currentIp = [PPSGetAppEnvironment deviceIPAdress];
    [self.logText appendFormat:@"当前设备局域网IP地址：%@\n\n",currentIp];
    self.logInfo.text = self.logText;
    
    //获取网管地址
    NSString *GatewayIPAddress = [PPSGetAppEnvironment getGatewayIPAddress];
    [self.logText appendFormat:@"当前设备局域网IP地址：%@\n\n",GatewayIPAddress];
    self.logInfo.text = self.logText;
    
    //获取域名的IP
    NSArray *ips = [PPSGetAppEnvironment getDNSsWithDormain:self.domainTextFiled.text];
    [self.logText appendFormat:@"%@对应的IP地址：%@\n\n",self.domainTextFiled.text,ips];
    self.logInfo.text = self.logText;
    
    //获取当前的网络类型  区分运营商
    NSString *netinfo = [PPSGetAppEnvironment currentNetInfo];
    [self.logText appendFormat:@"当前设备网络类型：%@\n\n",netinfo];
    self.logInfo.text = self.logText;
    
    //当前设备信息
    NSString *deviceInfo = [PPSGetAppEnvironment deviceInfo];
    [self.logText appendFormat:@"当前设备类型：%@\n\n",deviceInfo];
    self.logInfo.text = self.logText;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
