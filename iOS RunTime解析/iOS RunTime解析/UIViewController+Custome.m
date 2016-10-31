//
//  UIViewController+Custome.m
//  iOS RunTime解析
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "UIViewController+Custome.h"
#import <objc/runtime.h>

@implementation UIViewController (Custome)


/**
 load方法会在类第一次加载的时候被调用
 调用的时间比较靠前，适合在这个方法里做方法交换
 */
+(void)load{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法的selector
        SEL customeSel = @selector(custome_viewWillAppear:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method customeMethod = class_getInstanceMethod([self class], customeSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(customeMethod), method_getTypeEncoding(customeMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, customeSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, customeMethod);
        }

    });
}

- (void)custome_viewWillAppear:(BOOL)animated{
    //这时候调用自己，看起来像是死循环
    //但是其实自己的实现已经被替换了
    [self custome_viewWillAppear:animated];//这里 是去执行系统的viewWillApper:方法
    NSLog(@"custome");
}


@end
