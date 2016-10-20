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
 显示大图

 @param photos 照片数组 装的Photo
 @param index  当前的照片是第几张
 */
+ (void)showWithPhotos:(NSArray *)photos index:(NSInteger)index;


@end
