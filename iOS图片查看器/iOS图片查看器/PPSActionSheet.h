//
//  PPSActionSheet.h
//  iOS类似微信的ActionSheet
//
//  Created by 羊谦 on 2016/10/24.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPSActionSheet;
@protocol PPSActionSheetDelegate <NSObject>

@required

/**
 点击选项 实现这个代理必须实现这个方法 不然点击不能实现

 @param actionSheet 当前显示的actionsheet 如果存在多个actionsheet 可以分别出是哪一个actionsheet
 @param buttonIndex 点击的位置
 */
- (void)actionSheet:(PPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface PPSActionSheet : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <PPSActionSheetDelegate> delegate;

/**
 创建实例

 @param delegate    代理 一般为当前的VC
 @param cancleTitle 取消的title 最下面的选项
 @param otherTitles 其他的一些选项标题

 @return actionsheet
 */
- (instancetype)initWithDelegate:(id<PPSActionSheetDelegate>)delegate cancleTitle:(NSString *)cancleTitle otherTitles:(NSString *)otherTitles,... NS_REQUIRES_NIL_TERMINATION;


/**
 展示
 */
- (void)show;
@end
