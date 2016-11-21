//
//  LabColor.h
//  iOS KVC和KVO
//
//  Created by 羊谦 on 2016/11/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LabColor : NSObject

//LAB颜色 三个色素
@property (nonatomic) double lComponent;
@property (nonatomic) double aComponent;
@property (nonatomic) double bComponent;

@property (nonatomic, readonly) double redComponent;
@property (nonatomic, readonly) double greenComponent;
@property (nonatomic, readonly) double blueComponent;

@property (nonatomic, strong, readonly) UIColor *color;




@end
