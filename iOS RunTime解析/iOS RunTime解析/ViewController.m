//
//  ViewController.m
//  iOS RunTime解析
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()<UINavigationBarDelegate>
{
    @private
    NSUInteger countTest;
}

@property (nonatomic, copy) NSString *property5;
@property (nonatomic, copy) NSString *property6;
@property (nonatomic, copy) NSString *property7;
@property (nonatomic, copy) NSString *property8;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getProperties];
}

- (void)getProperties{
    unsigned int count;
    //获取属性列表
    NSLog(@"----------获取属性---------");
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    NSLog(@"----------获取方法---------");
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    NSLog(@"----------获取成员变量---------");
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    NSLog(@"----------获取协议---------");
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

-(void)testGetMethods{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
