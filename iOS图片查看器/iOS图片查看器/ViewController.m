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

@property (nonatomic, weak) UIImageView *photo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *urls = @[@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg"];
    UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    photo.image = [UIImage imageNamed:@"i"];
//    photo.bigImage = [UIImage imageNamed:@"i"];
    photo.userInteractionEnabled = YES;
    [self.view addSubview:photo];
    self.photo = photo;
    
    UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [photo addGestureRecognizer:re];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imageTap:(UIGestureRecognizer *)recognizer{
    Photo *photo = [[Photo alloc] initWithThumbnail:self.photo fullImage:self.photo.image fullImgUrl:nil];
    PhotoBrower *brower = [[PhotoBrower alloc] init];
    brower.photos = [@[photo] copy];
    brower.currentIndex = 0;
    [brower show];
}
@end
