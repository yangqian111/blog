//
//  Photo.h
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : UIImageView


/**
 *  缩略图 imageView
 */
@property (nonatomic, strong) UIImageView *thumbnail;

/**
 高清图
 如果存在  则在显示的时候优先显示设置的本地大图
 */
@property (nonatomic, strong) UIImage *fullImage;


/**
 *  大图URL   存在本地大图时  还是优先显示本地大图
 */
@property (nonatomic,strong) NSString *fullImgUrl;


/**
 创建图片实例

 @param thumbnail  缩略图View 用于加载在下载图片的时候
 @param fullImage  高清图 image
 @param fullImgUrl 高清图地址

 @return photo实例
 */
- (instancetype)initWithThumbnail:(UIImageView *)thumbnail fullImage:(UIImage *)fullImage fullImgUrl:(NSString *)fullImgUrl;

@end
