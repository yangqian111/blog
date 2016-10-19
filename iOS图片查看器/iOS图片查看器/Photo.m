//
//  Photo.m
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "Photo.h"

@implementation Photo


/**
 设置图片拉伸方式
 设置图片可点击

 @param frame 尺寸

 @return 实例
 */
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.clipsToBounds = YES;
//        self.userInteractionEnabled  = YES;
//        self.contentMode = UIViewContentModeScaleAspectFill;
//    }
//    return self;
//}

- (instancetype)initWithThumbnail:(UIImageView *)thumbnail fullImage:(UIImage *)fullImage fullImgUrl:(NSString *)fullImgUrl{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail = thumbnail;
        _fullImage = fullImage;
        _fullImgUrl = fullImgUrl;
    }
    return self;
}

@end
