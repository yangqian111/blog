//
//  PPSArrayDatasource.h
//  iOS ViewController瘦身计划
//
//  Created by 羊谦 on 2016/12/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface PPSArrayDatasource : NSObject <UITableViewDataSource>


- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
