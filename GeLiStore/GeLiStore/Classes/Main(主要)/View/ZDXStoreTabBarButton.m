//
//  ZDXStoreTabBarButton.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTabBarButton.h"
#import "ZDXComnous.h"

#define CZImageRidio 0.7

@implementation ZDXStoreTabBarButton

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 设置字体颜色
        [self setTitleColor:[UIColor colorWithHexString:@"#8a8a8a"] forState:UIControlStateNormal];
    
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:9];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
//    if (self.tag == 1) {
//        if (self.selected) {
//            // 1.imageView
//            CGFloat imageX = 0;
//            CGFloat imageY = 0;
//            CGFloat imageW = self.bounds.size.width;
//            CGFloat imageH = self.bounds.size.height;
//            self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//        
//        }else{
//            // 1.imageView
//            CGFloat imageX = 0;
//            CGFloat imageY = 0;
//            CGFloat imageW = self.bounds.size.width;
//            CGFloat imageH = self.bounds.size.height * CZImageRidio;
//            self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//            
//            // 2.title
//            CGFloat titleX = 0;
//            CGFloat titleY = imageH - 3;
//            CGFloat titleW = self.bounds.size.width;
//            CGFloat titleH = self.bounds.size.height - titleY;
//            self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
//        }
//    }else{
//        // 1.imageView
//        CGFloat imageX = 0;
//        CGFloat imageY = 0;
//        CGFloat imageW = self.bounds.size.width;
//        CGFloat imageH = self.bounds.size.height * CZImageRidio;
//        self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//        
//        // 2.title
//        CGFloat titleX = 0;
//        CGFloat titleY = imageH - 3;
//        CGFloat titleW = self.bounds.size.width;
//        CGFloat titleH = self.bounds.size.height - titleY;
//        self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
//    }
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * CZImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

@end
