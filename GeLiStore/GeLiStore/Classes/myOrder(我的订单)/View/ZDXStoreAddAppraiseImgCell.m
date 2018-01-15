//
//  ZDXStoreAddAppraiseImgCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreAddAppraiseImgCell.h"
#import "ZDXStorePhotos.h"
#import "ZDXComnous.h"
@interface ZDXStoreAddAppraiseImgCell ()
@property (weak, nonatomic) ZDXStorePhotos *photosView;

@end

@implementation ZDXStoreAddAppraiseImgCell

+(instancetype)cellWithAppraiseImgTableView:(UITableView *)tableView{
    static NSString *identifier = @"cell";
    ZDXStoreAddAppraiseImgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZDXStoreAddAppraiseImgCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _photos = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    ZDXStorePhotos *photosView = [ZDXStorePhotos initWithPhotosView];
    [self.contentView addSubview:photosView];
    self.photosView = photosView;
    self.photosView.x = 10;
    self.photosView.y = 23;
    self.photosView.width = SCREEN_WIDTH - 20;
    self.photosView.height = 68 + 15;
    
    self.cellH = 23 + self.photosView.height;
}


-(void)addPhoto:(UIImage *)photo{
    //    UIImageView *imageView = [[UIImageView alloc] init];
    //    imageView.image = photo;
    //    [self addSubview:imageView];
    
    // 存储图片
    [self.photos addObject:photo];
    
    if (self.photos.count>3) {
        
        self.photosView.height = self.photosView.photoWH * 2 + kMargin;
        self.cellH = 23 + self.photosView.height+20;
    }
    
    
    self.photosView.photo = photo;
}
@end
