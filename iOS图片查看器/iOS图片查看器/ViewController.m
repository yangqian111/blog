//
//  ViewController.m
//  iOS图片查看器
//
//  Created by 羊谦 on 16/10/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrower.h"
#import "Photo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *urls = @[@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg"];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 30)];
    label1.text = @"存在本地图片的";
    [self.view addSubview:label1];
    
    for (int i=0; i<3; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(30+100*i, 100, 80, 80)];
        image.image = [UIImage imageNamed:@"i"];
        image.tag = i;
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [image addGestureRecognizer:re];
        [self.view addSubview:image];
    }
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
    label2.text = @"没有本地图片的";
    [self.view addSubview:label2];
    for (int i=3; i<6; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(30+100*(i-3), 250, 80, 80)];
        image.image = [UIImage imageNamed:@"i"];
        image.tag = i;
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [image addGestureRecognizer:re];
        [self.view addSubview:image];
    }
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
//    photo.tag = 0;
//    photo.image = [UIImage imageNamed:@"i"];
//    photo.userInteractionEnabled = YES;
//    [self.view addSubview:photo];
//    self.photo = photo;
//    
//    UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
//    [photo addGestureRecognizer:re];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imageTap:(UIGestureRecognizer *)recognizer{
    UIImageView *thumbnail = (UIImageView *)recognizer.view;
    Photo *photo = nil;
    if (thumbnail.tag<3) {//属于有大图的
        photo = [[Photo alloc] initWithThumbnail:thumbnail fullImage:thumbnail.image fullImgUrl:nil];
    }else{
        photo = [[Photo alloc] initWithThumbnail:thumbnail fullImage:nil fullImgUrl:@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg"];
    }
    PhotoBrower *brower = [[PhotoBrower alloc] init];
    brower.photos = [@[photo] copy];
    brower.currentIndex = 0;
    [brower show];
}

@end
