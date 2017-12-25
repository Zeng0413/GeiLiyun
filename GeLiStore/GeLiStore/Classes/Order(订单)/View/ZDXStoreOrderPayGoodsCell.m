//
//  ZDXStoreOrderPayGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderPayGoodsCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
@interface ZDXStoreOrderPayGoodsCell ()
@property (weak, nonatomic) UILabel *shopName;
@property (weak, nonatomic) UIImageView *img;
@property (weak, nonatomic) UIImageView *goodsImg;
@property (weak, nonatomic) UILabel *goodsName;
@property (weak, nonatomic) UILabel *goodsPrice;
@property (weak, nonatomic) UILabel *goodsCount;
@end

@implementation ZDXStoreOrderPayGoodsCell

+(instancetype)initWithPayGoodsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreOrderPayGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ZDXStoreOrderPayGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *shopName = [[UILabel alloc] init];
        shopName.font = [UIFont systemFontOfSize:15];
        shopName.textColor = colorWithString(@"#262626");
        [self.contentView addSubview:shopName];
        self.shopName = shopName;
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"右箭头"];
        [self.contentView addSubview:img];
        self.img = img;
        
        UIImageView *goodsImg = [[UIImageView alloc] init];
        [self.contentView addSubview:goodsImg];
        self.goodsImg = goodsImg;
        
        UILabel *goodsName = [[UILabel alloc] init];
        goodsName.font = [UIFont systemFontOfSize:13];
        goodsName.textColor = colorWithString(@"#8a8a8a");
        [self.contentView addSubview:goodsName];
        self.goodsName = goodsName;
        
        UILabel *goodsPrice = [[UILabel alloc] init];
        goodsPrice.font = [UIFont systemFontOfSize:13];
        goodsPrice.textColor = colorWithString(@"#262626");
        [self.contentView addSubview:goodsPrice];
        self.goodsPrice = goodsPrice;
        
        UILabel *goodsCount = [[UILabel alloc]init];
        goodsCount.font = [UIFont systemFontOfSize:13];
        goodsCount.textColor = colorWithString(@"#262626");
        [self.contentView addSubview:goodsCount];
        self.goodsCount = goodsCount;
    }
    return self;
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    
    CGSize shopNameSize = [goodsModel.shopName sizeWithFont:[UIFont systemFontOfSize:15]];
    self.shopName.frame = CGRectMake(10, 14, shopNameSize.width, shopNameSize.height);
    self.shopName.text = goodsModel.shopName;
    
    self.img.frame = CGRectMake(CGRectGetMaxX(self.shopName.frame) + 15, 30, 10, 13);
    self.img.centerY = self.shopName.centerY;
    
    self.goodsImg.frame = CGRectMake(10, CGRectGetMaxY(self.shopName.frame) + 7, 80, 80);
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    
    CGSize goodsNameSize = [goodsModel.goodsName sizeWithFont:[UIFont systemFontOfSize:13] maxW:SCREEN_WIDTH - CGRectGetMaxX(self.goodsImg.frame) + 18 - 150];
    self.goodsName.x = CGRectGetMaxX(self.goodsImg.frame) + 18;
    self.goodsName.width = goodsNameSize.width;
    self.goodsName.height = goodsNameSize.height;
    self.goodsName.centerY = self.goodsImg.centerY;
    self.goodsName.text = goodsModel.goodsName;
    
    NSString *goodsPrice = [NSString stringWithFormat:@"¥%@",goodsModel.shopPrice];
    CGSize priceSize = [goodsPrice sizeWithFont:[UIFont systemFontOfSize:13]];
    self.goodsPrice.frame = CGRectMake(SCREEN_WIDTH - 10 - priceSize.width, self.goodsName.y + 3, priceSize.width, priceSize.height);
    self.goodsPrice.text = goodsPrice;
    
    NSString *count = [NSString stringWithFormat:@"X %ld",goodsModel.cartNum];
    CGSize cartNumSize = [count sizeWithFont:[UIFont systemFontOfSize:13]];
    self.goodsCount.frame = CGRectMake(SCREEN_WIDTH - 10 - cartNumSize.width, CGRectGetMaxY(self.goodsPrice.frame) + 9, cartNumSize.width, cartNumSize.height);
    self.goodsCount.text = count;
                        
    self.cellH = CGRectGetMaxY(self.goodsImg.frame) + 7;
}

@end
