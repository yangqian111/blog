//
//  ProgressView.h
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/20.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>


#define YQColorMaker(r, g, b, a) [UIColor colorWithRed: ((r) / 255.0) green: ((g) / 255.0) blue: ((b) / 255.0) alpha: (a)]

#define YQProgressViewItemMargin 10

#define YQProgressViewFontScale (MIN(self.frame.size.width, self.frame.size.height) / 100.0)

// 背景颜色
#define YQProgressViewBackgroundColor YQColorMaker(240, 240, 240, 0.9)


@interface ProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)dismiss;

- (void)show;

@end
