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
#import "ProgressView.h"
#import "PPSActionSheet.h"
#import <Photos/Photos.h>

#define YQKeyWindow [UIApplication sharedApplication].keyWindow
#define OutScrollVIewTag 101
#define SCREEN_WIDTH                    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                   [[UIScreen mainScreen] bounds].size.height

@interface PhotoBrower()<UIScrollViewDelegate,PPSActionSheetDelegate>
/**
 *  底层滑动的scrollview
 */
@property (nonatomic,weak) UIScrollView *outScrollView;
/**
 *  黑色背景view
 */
@property (nonatomic,weak) UIView *blackView;
/**
 *  原始frame数组
 */
@property (nonatomic,strong) NSMutableArray *originRects;
/**
 *  存放图片的数组
 */
@property (nonatomic,strong) NSArray *photos;
/**
 *  当前的index
 */
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation PhotoBrower

+ (void)showWithPhotos:(NSArray *)photos index:(NSInteger)index{
    PhotoBrower *brower = [[PhotoBrower alloc] init];
    brower.photos = [photos copy];
    brower.currentIndex = 0;
    [brower show];
}

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
    self.outScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.photos.count, 0);
    self.outScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.currentIndex, 0);
    
    //4.创建子视图
    [self setupphotoScrollViews];
}

/**
 创建每一张照片 每一张照片都是一个scrollview
 scrollview可缩放
 */
-(void)setupphotoScrollViews{
    for (int i=0; i<self.photos.count; i++) {
        UIScrollView *photoScrollView = [[UIScrollView alloc] init];
        photoScrollView.backgroundColor = [UIColor clearColor];
        photoScrollView.tag = i;
        photoScrollView.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        photoScrollView.delegate = self;
        photoScrollView.maximumZoomScale=2.0;
        photoScrollView.minimumZoomScale=1;
        [self.outScrollView addSubview:photoScrollView];
        
        Photo *photo = self.photos[i];
        //添加手势
        [self addCustomGestureRecognizer:photoScrollView];
        [photoScrollView addSubview:photo];
        //有本地高清大图 直接大图显示出来就不需要再次访问网络
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
        ProgressView *progress = [[ProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-30, SCREEN_HEIGHT/2.0-30, 60, 60)];
        NSURL *fullImgUrl = [NSURL URLWithString:photo.fullImgUrl];
        [photo sd_setImageWithURL:fullImgUrl placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //开始下载  这里后面会做一些效果 比如下载的进度条  一个load
            photo.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/3);
            photo.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
            photo.image = photo.thumbnail.image;
            self.blackView.alpha = 1.0;
            [photoScrollView addSubview:progress];
            progress.progress = receivedSize*1.0/expectedSize*1.0;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image!=nil) {
                [progress dismiss];
                photo.frame = [self.originRects[i] CGRectValue];
                //如果是网上下载下来的图片  那么改变一下photo的位置  后面做动画 会和已有缓存的图片显示效果不一样
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
               //下载错误 提示一个 错误需要
            }
        }];
    }
}

#pragma mark - 添加手势
- (void)addCustomGestureRecognizer:(UIView *)targetView{
    //单击手势
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
    //双击手势
    UITapGestureRecognizer *zonmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zonmTap:)];
    zonmTap.numberOfTapsRequired = 2;
    [targetView addGestureRecognizer:photoTap];
    [targetView addGestureRecognizer:zonmTap];
    [photoTap requireGestureRecognizerToFail:zonmTap];
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
    [longPress requireGestureRecognizerToFail:zonmTap];
    [longPress requireGestureRecognizerToFail:photoTap];
    [targetView addGestureRecognizer:longPress];
}

#pragma mark - 保存照片
- (void)savePhoto:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        PPSActionSheet *sheet = [[PPSActionSheet alloc] initWithDelegate:self cancleTitle:@"取消" otherTitles:@"保存图片", nil];
        sheet.delegate = self;
        [sheet show];
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
    UIScrollView *outScrollView = [[UIScrollView alloc] init];
    outScrollView.backgroundColor = [UIColor clearColor];
    outScrollView.delegate = self;//这个地方的代理主要是做外部Scroll滑动的时候 处理
    outScrollView.tag = OutScrollVIewTag;//用于判断处理点击事件和缩放事件时判断是否是外部的UIScrollView
    outScrollView.pagingEnabled = YES;
    outScrollView.bounces = YES;
    outScrollView.showsHorizontalScrollIndicator = NO;
    outScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:outScrollView];
    self.outScrollView = outScrollView;
}

#pragma mark UIScrollViewDelegate
/**
 告诉scroView哪个view需要缩放

 @param scrollView 当前的scrollView 如果是最外层的  就直接返回 没有要缩放的

 @return 需要缩放的view
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag == OutScrollVIewTag) {
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
    if (scrollView.tag==OutScrollVIewTag) {
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
    if (self.currentIndex!=currentIndex && scrollView.tag==OutScrollVIewTag) {
        self.currentIndex = currentIndex;
        for (UIView *view in scrollView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;//处于缩放时  滑动  恢复
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
    UIScrollView *photoScrollView = (UIScrollView *)photoTap.view;
    Photo *photo = nil;
    for (UIView *subview in photoScrollView.subviews) {
        if ([subview isKindOfClass:[Photo class]]) {
            photo = (Photo *)subview;
        }
        if ([subview isKindOfClass:[ProgressView class]]) {
            [subview removeFromSuperview];
        }
    }
    photoScrollView.zoomScale = 1.0;
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
        UIScrollView *photoScrollView = (UIScrollView *)zonmTap.view;
        photoScrollView.zoomScale = 2.0;
    }];
}

#pragma mark - PPSActionSheetDelegate
-(void)actionSheet:(PPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        Photo *photo = self.photos[self.currentIndex];
        if (photo.image) { //保证图片存在 已经下载完成
            //判断是否有访问相册权限
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted ||
                status == PHAuthorizationStatusDenied) {
                //没有权限 拒绝
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有访问相册的权限" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }else{
                UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
}
 - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
     if (error == nil) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         [alert show];
         
     }else{
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         [alert show];
     }
}
@end
