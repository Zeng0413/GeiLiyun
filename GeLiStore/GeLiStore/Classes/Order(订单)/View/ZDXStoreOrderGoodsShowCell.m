//
//  ZDXStoreOrderGoodsShowCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderGoodsShowCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"

@interface ZDXStoreOrderGoodsShowCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@end


@implementation ZDXStoreOrderGoodsShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.goodsName.textColor = colorWithString(@"#888888");
    self.goodsPrice.textColor = colorWithString(@"e93644");
    
    self.lineView.backgroundColor = colorWithString(@"#f2f2f2");
    // Initialization code
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    
    self.goodsName.text = goodsModel.goodsName;
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",goodsModel.shopPrice];
    
    self.goodsNum.text = [NSString stringWithFormat:@"X %ld",goodsModel.cartNum];
}

@end
