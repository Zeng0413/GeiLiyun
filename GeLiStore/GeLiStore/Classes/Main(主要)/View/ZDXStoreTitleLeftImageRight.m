//
//  ZDXStoreTitleLeftImageRight.m
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTitleLeftImageRight.h"
#import "ZDXComnous.h"
@implementation ZDXStoreTitleLeftImageRight

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.title
    CGFloat titleW = 32;
    CGFloat titleX = self.width / 2 - 32 / 2;
    CGFloat titleY = 0;
    CGFloat titleH = self.height;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 2.imageView
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + 5;
    CGFloat imageH = 12;
    CGFloat imageY = self.height / 2 - imageH / 2;
    CGFloat imageW = 10;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

@end
