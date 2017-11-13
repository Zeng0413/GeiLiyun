//
//  ZDXStoreClassifyView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreClassifyView : UIView

@property (weak, nonatomic) UILabel *label;


+(instancetype)initWithClassifyView;

-(void)setupUI;

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *imageStr;
@property (copy, nonatomic) NSString *titleStr;

@property (assign, nonatomic) NSInteger heigth;

@property (assign, nonatomic) CGFloat imageWH;
@property (assign, nonatomic) CGFloat imageToView;
@property (assign, nonatomic) CGFloat labelToImage;
@property (assign, nonatomic) CGFloat labelH;
@end
