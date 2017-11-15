//
//  ZDXStoreCollectionViewCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCollectionViewCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreProductModel.h"
#import "ZDXStoreGoodsModel.h"
@interface ZDXStoreCollectionViewCell ()

@property (strong, nonatomic) UIImageView *commodityImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *addShopCarBtn;

@end

@implementation ZDXStoreCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 15;
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    self.commodityImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.contentView.width, 155)];
    [self.contentView addSubview:self.commodityImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.commodityImage.frame) + 21, self.contentView.width - 20, 35);
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#444444"];
    [self.contentView addSubview:self.titleLabel];
    
    
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = [UIColor colorWithHexString:@"#e93644"];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.x = 10;
    self.priceLabel.height = 18;
    self.priceLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.priceLabel.width = self.contentView.width - 10;
    [self.contentView addSubview:self.priceLabel];

    
    self.addShopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addShopCarBtn setImage:[UIImage imageNamed:@"立即购买"] forState:UIControlStateNormal];
    self.layer.masksToBounds = YES;
    self.addShopCarBtn.layer.borderColor = [UIColor colorWithHexString:@"#e93644"].CGColor;
    self.addShopCarBtn.layer.borderWidth = 1;
    self.addShopCarBtn.layer.cornerRadius = 7;
    
    [self.addShopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addShopCarBtn setTitleColor:[UIColor colorWithHexString:@"#e93644"] forState:UIControlStateNormal];
    self.addShopCarBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.addShopCarBtn.x = 25;
    self.addShopCarBtn.height = 26;
    self.addShopCarBtn.y = CGRectGetMaxY(self.priceLabel.frame) + 10;
    self.addShopCarBtn.width = self.contentView.width - 50;
    [self.contentView addSubview:self.addShopCarBtn];
    
    
    self.itemH = CGRectGetMaxY(self.addShopCarBtn.frame) + 6;
    
//    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.contentView).offset(10);
//        make.height.equalTo(@18);
//        make.bottom.equalTo(self.addShopCarBtn.mas_top).offset(-10);
//    }];
    

}

-(void)setProductModel:(ZDXStoreProductModel *)productModel{
    _productModel = productModel;
    
    self.commodityImage.image = [UIImage imageNamed:productModel.productPicUri];
    
    NSString *productName = [NSString stringWithFormat:@"  %@",productModel.productName];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:productName];
    CGFloat attchWH = self.titleLabel.font.lineHeight;
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"参与抵扣"];
    attch.bounds = CGRectMake(0, -4, 45, attchWH - 2);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.titleLabel.attributedText = attri;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%ld",productModel.productPrice];
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    
    NSLog(@"%@",goodsModel.goodsImg);
    [self.commodityImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    NSString *productName = [NSString stringWithFormat:@"  %@",goodsModel.goodsName];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:productName];
    CGFloat attchWH = self.titleLabel.font.lineHeight;
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"参与抵扣"];
    attch.bounds = CGRectMake(0, -4, 45, attchWH - 2);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.titleLabel.attributedText = attri;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsModel.shopPrice];
}
@end
