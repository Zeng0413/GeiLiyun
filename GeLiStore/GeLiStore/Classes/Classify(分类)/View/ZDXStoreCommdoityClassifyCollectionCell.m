//
//  ZDXStoreCommdoityClassifyCollectionCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdoityClassifyCollectionCell.h"
#import "UIColor+ColorChange.h"
#import "ZDXStoreProductModel.h"
@interface ZDXStoreCommdoityClassifyCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *commdityImage;
@property (weak, nonatomic) IBOutlet UILabel *commdityName;

@end


@implementation ZDXStoreCommdoityClassifyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commdityName.textColor = [UIColor colorWithHexString:@"#444444"];
}

-(void)setModel:(ZDXStoreProductModel *)model{
    _model = model;
    self.commdityImage.image = [UIImage imageNamed:model.productPicUri];
    self.commdityName.text = model.productName;
}
@end
