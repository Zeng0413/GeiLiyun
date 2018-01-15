//
//  ZDXStoreShareGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/18.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShareGoodsCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreShareGoodsCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *certification; // 认证
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice; // 原价

@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg1;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg2;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg3;
@property (weak, nonatomic) IBOutlet UILabel *placeStr;
@property (weak, nonatomic) IBOutlet UIImageView *placeImg;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img1W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img2W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img3W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img3H;

@end

@implementation ZDXStoreShareGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topView.backgroundColor = colorWithString(@"#f4f4f4");
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 20;
    
    self.title.textColor = blackLabelColor;
    
    self.price.textColor = colorWithString(@"#e63944");
    
    self.certification.textColor = colorWithString(@"#444444");
    
    self.originalPrice.textColor = colorWithString(@"#444444");
    
    self.goodsName.textColor = colorWithString(@"#262626");
    
    self.placeStr.textColor = colorWithString(@"#444444");
    
    CGFloat imgWH = (SCREEN_WIDTH - 30) / 3;
    self.img1W.constant = imgWH;
    self.img1H.constant = imgWH;
    self.img2W.constant = imgWH;
    self.img2H.constant = imgWH;
    self.img3W.constant = imgWH;
    self.img3H.constant = imgWH;
    
    self.cellH = self.goodsImg1.y + imgWH + 40 + 17;
}


@end
