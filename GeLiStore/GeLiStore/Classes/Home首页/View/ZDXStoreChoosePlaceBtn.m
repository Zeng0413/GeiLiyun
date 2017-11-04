//
//  ZDXStoreChoosePlaceBtn.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreChoosePlaceBtn.h"
#import "UIView+Frame.h"
@implementation ZDXStoreChoosePlaceBtn

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        self.imageView.contentMode = UIViewContentModeRight;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat border = 5;
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleH = self.bounds.size.height;
    CGFloat titleY = 0;
    CGFloat titleW = self.bounds.size.width - border - 12;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 1.imageView
    CGFloat imageX = titleW;
    CGFloat imageH = 6;
    CGFloat imageY = self.centerY - imageH/2;
    CGFloat imageW = 9;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
}
@end
