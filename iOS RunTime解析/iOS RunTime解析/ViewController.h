//
//  ViewController.h
//  iOS RunTime解析
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Custome.h"

@interface ViewController : UIViewController<UITabBarDelegate>

@property (nonatomic, copy) NSString *property1;
@property (nonatomic, copy) NSString *property2;
@property (nonatomic, copy) NSString *property3;
@property (nonatomic, copy) NSString *property4;

- (void)testGetMethods;

@end

