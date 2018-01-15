//
//  ZDXStorePhotosView.m
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStorePhotosView.h"
#import "ZDXComnous.h"

#define border 5
#define maxCols 3
#define photoImgWH (SCREEN_WIDTH - 20 - (maxCols - 1) * border) / maxCols
@implementation ZDXStorePhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    NSInteger photoCount = photos.count;
    
    while (self.subviews.count < photoCount) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
    }
    
    // 设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *photoImg = self.subviews[i];
        
        if (i < photoCount) {
            photoImg.hidden = NO;
            [photoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,photos[i]]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
        }else{
            photoImg.hidden = YES;
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger photoCount = self.photos.count;
    
    
    for (int i = 0; i<photoCount; i++) {
        UIImageView *photoImg = self.subviews[i];
        NSInteger cols = i % maxCols;
        photoImg.x = cols * (photoImgWH + border);
        NSInteger rows = i / maxCols;
        photoImg.y = rows * (photoImgWH + border);
        photoImg.width = photoImgWH;
        photoImg.height = photoImgWH;
        
    }
    
}

+(CGSize)sizeWithCount:(NSInteger)count{
    // 列数
    NSInteger cols = (count >= maxCols)?maxCols : count;
    CGFloat photosW = cols * photoImgWH + (cols - 1) * border;
    
    // 行数
    NSInteger rows =(count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * photoImgWH + (rows - 1) * border;
    
    return CGSizeMake(photosW, photosH);
}

@end
