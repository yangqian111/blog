//
//  PhotoBrower.h
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrower : UIView

/**
 *  存放图片的数组
 */
@property (nonatomic,strong) NSArray *photos;
/**
 *  当前的index
 */
@property (nonatomic,assign) int currentIndex;
/**
 *  显示图片浏览器
 */
-(void)show;


@end
