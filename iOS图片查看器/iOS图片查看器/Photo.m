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
 将图片的一些实例

 @param thumbnail  含缩略图的view
 @param fullImage  高清大图
 @param fullImgUrl 高清大图网络地址

 @return 照片model实例
 */
- (instancetype)initWithThumbnail:(UIImageView *)thumbnail fullImage:(UIImage *)fullImage fullImgUrl:(NSString *)fullImgUrl{
    self = [super init];
    if (self) {
        //设置照片填充模式 可点击
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
