//
//  ZDXStorePhotos.h
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMargin 15

@interface ZDXStorePhotos : UIView

+(instancetype)initWithPhotosView;

@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) NSMutableArray *photoArray;
@property (assign, nonatomic) CGFloat photoWH;

@end
