//
//  ZDXStoreRefundGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreRefundGoodsCell.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXComnous.h"
@interface ZDXStoreRefundGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@end

@implementation ZDXStoreRefundGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.goodsName.textColor = [UIColor colorWithHexString:@"#262626"];
    self.goodsDetail.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.orderTime.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.goodsNum.textColor = [UIColor colorWithHexString:@"#464646"];
    
    // Initialization code
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    self.goodsName.text = goodsModel.goodsName;
    self.goodsDetail.text = @"重量 5kg";
    self.orderTime.text = goodsModel.createTime;
    
    self.goodsNum.text = [NSString stringWithFormat:@"X %ld",goodsModel.cartNum];
    
    
}

@end
