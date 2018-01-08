//
//  ZDXStorePhotos.m
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStorePhotos.h"
#import "ZDXComnous.h"

@interface ZDXStorePhotos ()
@property (weak, nonatomic) UIButton *addImageBtn;

@end

@implementation ZDXStorePhotos

+(instancetype)initWithPhotosView{
    ZDXStorePhotos *view = [[self alloc] init];
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addImageBtn.layer.borderWidth = 1.0f;
        addImageBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addImageBtn.width = 68;
        addImageBtn.height = 68;
        addImageBtn.x = 0;
        addImageBtn.y = 0;
        [addImageBtn setImage:[UIImage imageNamed:@"上传物流凭证"] forState:UIControlStateNormal];
        [addImageBtn addTarget:self action:@selector(addImageClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addImageBtn];
        self.addImageBtn = addImageBtn;
    }
    return self;
}

-(void)addImageClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addImageNotification" object:nil];
}


-(void)setPhoto:(UIImage *)photo{
    NSInteger photoCount = self.subviews.count;
    if (photoCount != 9) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = photo;
        [self addSubview:imageView];
    }
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger photoCount = self.subviews.count;
    //
    NSInteger maxCols = 4; // 最大列数
    CGFloat photoMargin = kMargin;
    CGFloat photoWH = (self.width - photoMargin * (maxCols - 1)) / maxCols;
    
    self.photoWH = photoWH;
    
    if (photoCount == 9) {
        self.addImageBtn.hidden = YES;
    }
    
    if (photoCount > 1) {
        for (int i = 0; i<photoCount; i++) {
            if ([self.subviews[i] isKindOfClass:[UIImageView class]]) {
                UIImageView *photoImageView = self.subviews[i];
                
                NSInteger cols = (i-1) % maxCols;
                photoImageView.x = cols * (photoWH + photoMargin);
                
                NSInteger rows = (i-1) / maxCols;
                photoImageView.y = rows * (photoWH + photoMargin);
                
                photoImageView.width = photoWH;
                photoImageView.height = photoWH;
                
                NSInteger num = i-1;
                NSInteger addImageCols = (num + 1) % maxCols;
                
                
                self.addImageBtn.x = addImageCols * (photoWH + photoMargin);
                NSInteger addImageRows = (num + 1) / maxCols;
                self.addImageBtn.y = addImageRows * (photoWH + photoMargin);
                self.addImageBtn.width = photoWH;
                self.addImageBtn.height = photoWH;
                self.photoWH = photoWH;
            }
            
        }
    }
}
@end
