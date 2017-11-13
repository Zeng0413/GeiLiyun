//
//  ZDXStoreCommdityClassifyBannerCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/30.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdityClassifyBannerCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreCommdityClassifyBannerCell ()


@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;


@end

@implementation ZDXStoreCommdityClassifyBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bannerImageView.layer.masksToBounds = YES;
    self.bannerImageView.layer.cornerRadius = 15;
}

-(void)setBannerUrlStr:(NSString *)bannerUrlStr{
    _bannerUrlStr = bannerUrlStr;
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,bannerUrlStr]] placeholderImage:[UIImage imageNamed:@"品牌加载"]];
    
}

@end
