//
//  UINavigationBar+PPSNavigationBar.h
//  iOS UIScrollView上滑隐藏UINavigationBar
//
//  Created by 羊谦 on 2016/10/31.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (PPSNavigationBar)


/**
 设置scrollview的透明度 随着滑动  透明度改变

 @param alpha 透明度
 */
- (void)pps_setScrollViewAlpha:(CGFloat)alpha;


/**
 设置Bar偏移

 @param translationY 偏移量
 */
- (void)pps_setTranslationY:(CGFloat)translationY;

@end
