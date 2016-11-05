//
//  Entity.h
//  iOS KVO初探
//
//  Created by 羊谦 on 2016/11/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject

@property (nonatomic, copy) NSString *name;



/**
 因为另外两个属性没有暴露出来 我们只能通过方法来改变
 */
- (void)changeName1:(NSString *)name1;

- (void)changeName2:(NSString *)name2;


@end
