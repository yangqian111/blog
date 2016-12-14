//
//  MyTableViewController.h
//  ViewController瘦身计划(二)
//
//  Created by 羊谦 on 2016/12/14.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTableViewControllerDelegate <NSObject>

- (void)didSelectCell;

@end


@interface MyTableViewController : UITableViewController

@property (nonatomic, weak) id<MyTableViewControllerDelegate> delegate;

@end
