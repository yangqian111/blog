//
//  KeyValueObserver.h
//  iOS KVC和KVO
//
//  Created by 羊谦 on 2016/11/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueObserver : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;

// 其中__attribute__((warn_unused_result))这个的意思是，当调用这个方法时，必须要检查返回值，或者使用返回值，不然编译器直接报警告

+ (NSObject *)observeObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector __attribute__((warn_unused_result));


+ (NSObject *)observeObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector options:(NSKeyValueObservingOptions)options __attribute__((warn_unused_result));


@end
