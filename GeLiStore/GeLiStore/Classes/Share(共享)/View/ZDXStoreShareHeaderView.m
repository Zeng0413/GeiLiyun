//
//  ZDXStoreShareHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/18.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShareHeaderView.h"

@implementation ZDXStoreShareHeaderView

+(instancetype)shareHeaderView:(CGRect)frame{
    
    ZDXStoreShareHeaderView *headerView = [[self alloc] init];
    headerView.frame = frame;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"共享-banner"];
    [headerView addSubview:imageView];
    
    return headerView;
}

@end
