//
//  ZDXStoreMyOrderHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMyOrderHeaderView.h"
#import "ZDXComnous.h"
#import "ZDXStoreOrderModel.h"

@interface ZDXStoreMyOrderHeaderView ()
@property (weak, nonatomic) UILabel *shopName;
@property (weak, nonatomic) UIImageView *img;
@property (weak, nonatomic) UILabel *orderStatus;
@end

@implementation ZDXStoreMyOrderHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    topView.backgroundColor = colorWithString(@"#f4f4ff");
    [self addSubview:topView];
    
    UILabel *shopName = [[UILabel alloc] init];
    shopName.font = [UIFont systemFontOfSize:15];
    shopName.textColor = colorWithString(@"#262626");
    [self addSubview:shopName];
    self.shopName = shopName;
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"右箭头"];
    [self addSubview:img];
    self.img = img;
    
    UILabel *orderStatus = [[UILabel alloc] init];
    [orderStatus setTextAlignment:NSTextAlignmentRight];
    orderStatus.font = [UIFont systemFontOfSize:15];
    orderStatus.textColor = colorWithString(@"#e63944");
    [self addSubview:orderStatus];
    self.orderStatus = orderStatus;
}

-(void)setOrderModel:(ZDXStoreOrderModel *)orderModel{
    _orderModel = orderModel;
    
    CGSize shopNameSize = [orderModel.shopName sizeWithFont:[UIFont systemFontOfSize:15]];
    self.shopName.frame = CGRectMake(10, 14 + 10, shopNameSize.width, shopNameSize.height);
    self.shopName.text = orderModel.shopName;
    
    self.img.frame = CGRectMake(CGRectGetMaxX(self.shopName.frame) + 15, 30 + 10, 10, 13);
    self.img.centerY = self.shopName.centerY;
    
    self.orderStatus.frame = CGRectMake(SCREEN_WIDTH - 10 - 80, 28 + 10, 80, 15);
    self.orderStatus.centerY = self.shopName.centerY;
    if (orderModel.isRefund != 0){ // 退款中
        self.orderStatus.text = @"退款中";
    }else if (orderModel.orderStatus == -2){ // 待付款
        self.orderStatus.text = @"待付款";

    }else if (orderModel.orderStatus == 0){ // 待发货
        self.orderStatus.text = @"待发货";

    }else if (orderModel.orderStatus == 1){ // 待收货
        self.orderStatus.text = @"待收货";
    }else{
        if (orderModel.isAppraise == 0) { // 待评价
            self.orderStatus.text = @"待评价";
        }else{
            self.orderStatus.text = @"已评价";
        }
    }
    
}
@end
