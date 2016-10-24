//
//  PPSActionSheet.m
//  iOS类似微信的ActionSheet
//
//  Created by 羊谦 on 2016/10/24.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSActionSheet.h"

#define BtnHeight 46 //每个按钮的高度

#define CancleMargin 8 //取消按钮上面的间隔

//颜色制作 定义一个宏
#define PPSColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define BGColor PPSColor(237,240,242) //背景色

#define SeparatorColor PPSColor(226, 226, 226) //分割线颜色

#define normalImage [self imageWithColor:PPSColor(255,255,255)] //普通下的图片

#define highImage [self imageWithColor:PPSColor(242,242,242)] //高粱的图片

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// 字体
#define HeitiLight(f) [UIFont fontWithName:@"STHeitiSC-Light" size:f]

@interface PPSActionSheet()

{
    int _tag;
}

@property (nonatomic, weak) PPSActionSheet *actionSheet;
@property (nonatomic, weak) UIView *sheetView;

@end

@implementation PPSActionSheet

-(instancetype)initWithDelegate:(id<PPSActionSheetDelegate>)delegate cancleTitle:(NSString *)cancleTitle otherTitles:(NSString *)otherTitles, ...{
    
    PPSActionSheet *actionSheet = [self init];
    self.actionSheet = actionSheet;
    
    //设置代理
    actionSheet.delegate = delegate;
    
    //黑色遮盖
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    actionSheet.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
    [actionSheet addGestureRecognizer:tap];
    
    // sheet
    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    sheetView.backgroundColor = BGColor;
    sheetView.alpha = 0.9;
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    self.sheetView = sheetView;
    sheetView.hidden = YES;
    
    
    _tag = 1;
    
    NSString* curStr;
    va_list list;
    if(otherTitles)
    {
        [self setupBtnWithTitle:otherTitles];
        
        va_start(list, otherTitles);
        while ((curStr = va_arg(list, NSString*))) {
            [self setupBtnWithTitle:curStr];
            
        }
        va_end(list);
    }
    
    CGRect sheetViewF = sheetView.frame;
    sheetViewF.size.height = BtnHeight * _tag + CancleMargin;
    sheetView.frame = sheetViewF;
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, sheetView.frame.size.height - BtnHeight, ScreenWidth, BtnHeight)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:cancleTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = HeitiLight(17);
    btn.tag = 0;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    return actionSheet;
}

- (void)show{
    self.sheetView.hidden = NO;
    
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    self.sheetView.frame = sheetViewF;
    
    CGRect newSheetViewF = self.sheetView.frame;
    newSheetViewF.origin.y = ScreenHeight - self.sheetView.frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.sheetView.frame = newSheetViewF;
        
        self.actionSheet.alpha = 0.3;
    }];
}


/**
 创建每个选项

 @param title 选项展示名
 */
- (void)setupBtnWithTitle:(NSString *)title{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BtnHeight * (_tag - 1) , ScreenWidth, BtnHeight)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = HeitiLight(17);
    btn.tag = _tag;
    [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sheetView addSubview:btn];
    
    // 最上面画分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line.backgroundColor = SeparatorColor;
    [btn addSubview:line];
    
    _tag ++;
}

/**
 显示黑色遮罩
 */
- (void)coverClick{
    CGRect sheetViewF = self.sheetView.frame;
    sheetViewF.origin.y = ScreenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sheetView.frame = sheetViewF;
        self.actionSheet.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.actionSheet removeFromSuperview];
        [self.sheetView removeFromSuperview];
    }];
}

- (void)sheetBtnClick:(UIButton *)btn{
    if (btn.tag == 0) {
        [self coverClick];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self.actionSheet clickedButtonAtIndex:btn.tag];
        [self coverClick];
    }
}


/**
 根据颜色生成图片

 @param color 颜色

 @return 图片
 */
- (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
