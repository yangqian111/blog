//
//  RoundHeadView.m
//  MakeRoundTextHead
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "RoundHeadView.h"


@interface RoundHeadView()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat colorPoint;

@end

@implementation RoundHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [[self subStringWithLendth:2 string:title] copy];
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self caculateColor];//计算颜色
    
    /*画圆*/
    CGContextSetRGBFillColor (context,_colorPoint, 0.5, 0.5, 1.0);//设置填充颜色
    //    CGContextSetRGBStrokeColor(context,red,green,blue,1.0);//画笔线的颜色
    
    //填充圆，无边框
    CGContextAddArc(context, self.frame.size.width/2.0, self.frame.size.width/2.0, self.frame.size.width/2.0, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    
    /*写文字*/
    //    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:self.frame.size.width/3.0], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    CGSize size = [self caculateLableSize];
    CGFloat X = (self.frame.size.width-size.width)/2.0;
    CGFloat Y = (self.frame.size.height-size.height)/2.0;
    [self.title drawInRect:CGRectMake(X, Y, self.frame.size.width, self.frame.size.width) withAttributes:dic];
}


/**
 获取汉子拼音

 @param originalStr 原始中文字符

 @return 汉子的全拼
 */
- (NSString *)pinyin: (NSString *)originalStr{
    NSMutableString *str = [originalStr mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 截取字符串，截取字符串最开始的两个  汉子和英文一样处理

 @param length 截取的字符长度（汉子和英文同样计算）
 @param string 需要截取的字符串

 @return 返回截取的字符串
 */
-(NSString *)subStringWithLendth:(int)length string:(NSString *)string{
    
    NSString *copyStr = [string copy];
    NSMutableString *realStr = [[NSMutableString alloc] init];
    
    for(int i = 0; i < copyStr.length; i++){
        if(length == 0){
            break;
        }
        unichar ch = [copyStr characterAtIndex:0];
        if (0x4e00 < ch  && ch < 0x9fff)//如何判断是汉字
        {
            //如果是汉子需要做其他处理  可以在这里做处理
        }
        //若为汉字
        [realStr appendString:[copyStr substringWithRange:NSMakeRange(i,1)]];
            
        length = length - 1;
    }
    return realStr;
}


/**
 计算文字的尺寸，在绘制图像时，保证文字总是处于图像的正中
 文字的尺寸可以自己计算  这里定义的是 宽度的1/3  我看使用起来比较合适  当然
 你可以自己定义的
 @return 文字的宽高
 */
- (CGSize)caculateLableSize{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.font = [UIFont fontWithName:@"Arial-BoldMT" size:self.frame.size.width/3.0];
    lable.text = self.title;
    [lable sizeToFit];
    CGSize size = lable.frame.size;
    return size;
}

/**
 随机一个颜色
 填充圆形头像的底色
 根据字符的拼音计算出的颜色
 */
- (void)caculateColor{
    if (_title.length == 0) {
        return;
    }
    if (_title.length>1) {
        NSString *firstStr = [_title substringWithRange:NSMakeRange(0,1)];
        NSString *secondStr = [_title substringWithRange:NSMakeRange(1, 1)];
        NSString *firstPinyin = [self pinyin:firstStr];
        NSString *secondPinyin = [self pinyin:secondStr];
        NSUInteger count = firstPinyin.length+secondPinyin.length;
        if (count>10) {
            count-=10;
            self.colorPoint = count/10.0;
        }else{
            self.colorPoint = count/10.0;
        }
    }else{
        NSString *firstStr = [_title substringWithRange:NSMakeRange(0,1)];
        NSString *firstPinyin = [self pinyin:firstStr];
        NSUInteger count = firstPinyin.length;
        self.colorPoint = count/10.0;
    }
}


@end
