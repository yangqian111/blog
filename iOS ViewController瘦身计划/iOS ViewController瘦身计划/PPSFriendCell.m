//
//  PPSFriendCell.m
//  iOS ViewController瘦身计划
//
//  Created by 羊谦 on 2016/12/5.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "PPSFriendCell.h"

@implementation PPSFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//瘦身计划二部分
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        //高亮时改变cell的状态
    }else{
        //非高亮时改变
    }
}

@end
