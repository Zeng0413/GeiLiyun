//
//  ZDXStoreCommdoityClassifyCollectionCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdoityClassifyCollectionCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsClassifySubModel.h"
@interface ZDXStoreCommdoityClassifyCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *commdityImage;
@property (weak, nonatomic) IBOutlet UILabel *commdityName;

@end


@implementation ZDXStoreCommdoityClassifyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commdityName.textColor = [UIColor colorWithHexString:@"#444444"];
}

-(void)setModel:(ZDXStoreGoodsClassifySubModel *)model{
    _model = model;
    [self.commdityImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,model.catImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    self.commdityName.text = model.catName;
}
@end
