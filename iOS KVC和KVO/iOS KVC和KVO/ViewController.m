//
//  ViewController.m
//  iOS KVC和KVO
//
//  Created by 羊谦 on 2016/11/19.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "ViewController.h"
#import "LabColor.h"
#import "KeyValueObserver.h"

@interface ViewController ()

@property (nonatomic, strong) LabColor *labColor;
@property (nonatomic, strong) id colorObserveToken;
@property (nonatomic, weak) UIView *colorView;

@property (nonatomic, weak) UISlider *lSlider;
@property (nonatomic, weak) UISlider *aSlider;
@property (nonatomic, weak) UISlider *bSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 100, 80)];
    [self.view addSubview:colorView];
    self.colorView = colorView;
    
    
    UISlider *lSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 200, 200, 20)];
    [lSlider addTarget:self action:@selector(updateLComponent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:lSlider];
    self.lSlider = lSlider;
    
    UISlider *aSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 250, 200, 20)];
     [aSlider addTarget:self action:@selector(updateAComponent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:aSlider];
    self.aSlider = aSlider;
    
    UISlider *bSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 300, 200, 20)];
    [bSlider addTarget:self action:@selector(updateBComponent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:bSlider];
    self.bSlider = bSlider;
    
    self.labColor = [[LabColor alloc] init];
}

- (void)setLabColor:(LabColor *)labColor{
    _labColor = labColor;
    self.colorObserveToken = [KeyValueObserver observeObject:labColor keyPath:@"color" target:self selector:@selector(colorDidChange:) options:NSKeyValueObservingOptionInitial];
    
    //这里设置一下最大值和最小值，便于我们处理颜色值
    self.lSlider.maximumValue = 100;
    self.lSlider.minimumValue = 50;
    self.aSlider.maximumValue = 20;
    self.aSlider.minimumValue = -20;
    self.bSlider.maximumValue = 20;
    self.bSlider.minimumValue = -20;
    
    
    
    
    self.lSlider.value = self.labColor.lComponent;
    self.aSlider.value = self.labColor.aComponent;
    self.bSlider.value = self.labColor.bComponent;
}

- (void)colorDidChange:(NSDictionary *)change;
{
    self.colorView.backgroundColor = self.labColor.color;
}


- (void)updateLComponent:(UISlider *)sender;
{
    self.labColor.lComponent = sender.value;
}

- (void)updateAComponent:(UISlider *)sender;
{
    self.labColor.aComponent = sender.value;
}

- (void)updateBComponent:(UISlider *)sender;
{
    self.labColor.bComponent = sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
