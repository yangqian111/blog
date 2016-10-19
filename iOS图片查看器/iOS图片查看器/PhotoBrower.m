//
//  PhotoBrower.m
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PhotoBrower.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

#define YQKeyWindow [UIApplication sharedApplication].keyWindow
#define bigScrollVIewTag 101
#define SCREEN_WIDTH                    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                   [[UIScreen mainScreen] bounds].size.height

@interface PhotoBrower()<UIScrollViewDelegate>
/**
 *  底层滑动的scrollview
 */
@property (nonatomic,weak) UIScrollView *bigScrollView;
/**
 *  黑色背景view
 */
@property (nonatomic,weak) UIView *blackView;
/**
 *  原始frame数组
 */
@property (nonatomic,strong) NSMutableArray *originRects;

@end

@implementation PhotoBrower

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建黑色的背景图
        [self createBlackView];
        
        //创建外部的滑动scrollview
        [self createOuterScrollView];
    }
    return self;
}

-(void)show{
    
    //1.添加photoBrowser
    [YQKeyWindow addSubview:self];
    
    //2.获取原始frame
    [self setupOriginRects];
    
    //3.设置滚动距离
    self.bigScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.photos.count, 0);
    self.bigScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.currentIndex, 0);
    
    //4.创建子视图
    [self setupSmallScrollViews];
}

/**
 创建每一张照片 每一张照片都是一个scrollview
 scrollview可缩放
 */
-(void)setupSmallScrollViews{
    for (int i=0; i<self.photos.count; i++) {
        UIScrollView *smallScrollView = [[UIScrollView alloc] init];
        smallScrollView.backgroundColor = [UIColor clearColor];
        smallScrollView.tag = i;
        smallScrollView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        smallScrollView.delegate = self;
        smallScrollView.maximumZoomScale=3.0;
        smallScrollView.minimumZoomScale=1;
        [self.bigScrollView addSubview:smallScrollView];
        
        Photo *photo = self.photos[i];
        UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
        UITapGestureRecognizer *zonmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zonmTap:)];
        zonmTap.numberOfTapsRequired = 2;
        [smallScrollView addGestureRecognizer:photoTap];
        [smallScrollView addGestureRecognizer:zonmTap];
        [photoTap requireGestureRecognizerToFail:zonmTap];
        
        [smallScrollView addSubview:photo];
        //有本地高清大图
        if (photo.fullImage) {
            photo.image = photo.fullImage;
            photo.frame = [self.originRects[i] CGRectValue];
            [UIView animateWithDuration:0.3 animations:^{
                
                self.blackView.alpha = 1.0;
                
                CGFloat ratio = (double)photo.image.size.height/(double)photo.image.size.width;
                
                CGFloat bigW = SCREEN_WIDTH;
                CGFloat bigH = SCREEN_WIDTH*ratio;
                
                photo.bounds = CGRectMake(0, 0, bigW, bigH);
                photo.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
            }];
            
            return;
        }
        
        NSURL *fullImgUrl = [NSURL URLWithString:photo.fullImgUrl];
        
        [[SDImageCache sharedImageCache] queryDiskCacheForKey:photo.fullImgUrl done:^(UIImage *image, SDImageCacheType cacheType) {
            
            if (image==nil) {
                //                loop.hidden = NO;
            }
            
        }];
        [photo sd_setImageWithURL:fullImgUrl placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //            [loop removeFromSuperview];
            
            if (image!=nil) {
                
                photo.frame = [self.originRects[i] CGRectValue];
                
                if (cacheType==SDImageCacheTypeNone) {
                    
                    photo.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                    photo.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                    
                }
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.blackView.alpha = 1.0;
                    
                    CGFloat ratio = (double)photo.image.size.height/(double)photo.image.size.width;
                    
                    CGFloat bigW = SCREEN_WIDTH;
                    CGFloat bigH = SCREEN_WIDTH*ratio;
                    
                    photo.bounds = CGRectMake(0, 0, bigW, bigH);
                    photo.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                }];
            }else{
                
                //                UITapGestureRecognizer *loopTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopTap)];
                //                [loop addGestureRecognizer:loopTap];
            }
        }];
    }
}

#pragma mark 获取原始frame 为了做动画
-(void)setupOriginRects{
    for (Photo *photo in self.photos) {
        UIImageView *sourceImageView = photo.thumbnail;
        CGRect sourceF = [YQKeyWindow convertRect:sourceImageView.frame fromView:sourceImageView.superview];
        [self.originRects addObject:[NSValue valueWithCGRect:sourceF]];
    }
}

-(NSMutableArray *)originRects{
    if (!_originRects) {
        _originRects = [NSMutableArray array];
    }
    return _originRects;
}

/**
 创建黑色的背景
 */
- (void)createBlackView{
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:blackView];
    self.blackView = blackView;
    self.blackView.alpha = 0;
}

/**
 创建外部的  滑动的scrollview
 */
- (void)createOuterScrollView{
    UIScrollView *bigScrollView = [[UIScrollView alloc] init];
    bigScrollView.backgroundColor = [UIColor clearColor];
    bigScrollView.delegate = self;
    bigScrollView.tag = bigScrollVIewTag;
    bigScrollView.pagingEnabled = YES;
    bigScrollView.bounces = YES;
    bigScrollView.showsHorizontalScrollIndicator = NO;
    bigScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:bigScrollView];
    self.bigScrollView = bigScrollView;
}

#pragma mark UIScrollViewDelegate
/**
 告诉scroView哪个view需要缩放

 @param scrollView 当前的scrollView 如果是最外层的  就直接返回 没有要缩放的

 @return 需要缩放的view
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag == bigScrollVIewTag) {
        return nil;
    }
    Photo *photo = self.photos[scrollView.tag];
    return photo;
}

/**
 根据手势缩放photo

 @param scrollView 当前的小scrollview 装图片的
 */
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if (scrollView.tag==bigScrollVIewTag) {
        return;
    }
    Photo *photo = (Photo *)self.photos[scrollView.tag];
    CGFloat photoY = (SCREEN_HEIGHT-photo.frame.size.height)/2;
    CGRect photoF = photo.frame;
    if (photoY>0) {
        photoF.origin.y = photoY;
    }else{
        photoF.origin.y = 0;
    }
    
    photo.frame = photoF;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int currentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    if (self.currentIndex!=currentIndex && scrollView.tag==bigScrollVIewTag) {
        self.currentIndex = currentIndex;
        for (UIView *view in scrollView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.zoomScale = 1.0;
            }
        }
    }
}

#pragma mark 设置frame
-(void)setFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [super setFrame:frame];
}

-(void)photoTap:(UITapGestureRecognizer *)photoTap{
    UIScrollView *smallScrollView = (UIScrollView *)photoTap.view;
    Photo *photo = nil;
    for (UIView *subview in smallScrollView.subviews) {
        if ([subview isKindOfClass:[Photo class]]) {
            photo = (Photo *)subview;
        }
    }
//    UIScrollView *smallScrollView = (UIScrollView *)photo.superview;
    smallScrollView.zoomScale = 1.0;
    CGRect frame = [self.originRects[photo.tag] CGRectValue];
    [UIView animateWithDuration:0.4 animations:^{
        photo.frame = frame;
        self.blackView.alpha = 0;
        photo.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)zonmTap:(UITapGestureRecognizer *)zonmTap{
    [UIView animateWithDuration:0.3 animations:^{
        UIScrollView *smallScrollView = (UIScrollView *)zonmTap.view;
        smallScrollView.zoomScale = 2.0;
    }];
}

@end
