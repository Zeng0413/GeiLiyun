//
//  ZDXStoreMainTopView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMainTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreChoosePlaceBtn.h"
@implementation ZDXStoreMainTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect imageRect = CGRectMake(0, 0, 79, 19);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
        imageView.image = [UIImage imageNamed:@"格力云商"];
        [self addSubview:imageView];
        
        ZDXStoreChoosePlaceBtn *btn = [ZDXStoreChoosePlaceBtn buttonWithType:UIButtonTypeCustom];
        btn.x = CGRectGetMaxX(imageRect) + 8;
        btn.height = 19;
        btn.width = 50;
        btn.y = 0;
        [btn setTitle:@"重庆" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"下拉按钮"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    return self;
}

-(void)btnClick{
    if ([self.delegate respondsToSelector:@selector(chooseCity)]) {
        [self.delegate chooseCity];
    }
}

@end
