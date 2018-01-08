//
//  ZDXStoreMyOrderCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMyOrderCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreOrderModel.h"
#import "ZDXStoreGoodsModel.h"

@interface ZDXStoreMyOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end

@implementation ZDXStoreMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.goodsName.textColor = colorWithString(@"#262626");
    self.goodsDetail.textColor = colorWithString(@"#8a8a8a");
    self.goodsPrice.textColor = colorWithString(@"#e63944");
    self.orderTime.textColor = colorWithString(@"#8a8a8a");
    
    
}

-(void)setOrderModel:(ZDXStoreOrderModel *)orderModel{
    _orderModel = orderModel;
    if (!self.isAppraise) {
        ZDXStoreGoodsModel *goodsModel = orderModel.list[self.row];
        
        [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
        
        self.goodsName.text = goodsModel.goodsName;
        self.goodsDetail.text = orderModel.deliverType;
        self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",goodsModel.goodsPrice];
        
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
        NSArray *strList = [orderModel.createTime componentsSeparatedByCharactersInSet:set];
        self.orderTime.text = strList[0];
    }else{
        
        
        [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,orderModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
        
        self.goodsName.text = orderModel.goodsName;
        self.goodsDetail.text = orderModel.deliverType;
        self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",orderModel.goodsMoney];
        
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
        NSArray *strList = [orderModel.createTime componentsSeparatedByCharactersInSet:set];
        self.orderTime.text = strList[0];
    }
    
    
        
}

@end
