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
    self.shopName.frame = CGRectMake(10, 14, shopNameSize.width, shopNameSize.height);
    self.shopName.text = orderModel.shopName;
    
    self.img.frame = CGRectMake(CGRectGetMaxX(self.shopName.frame) + 15, 30, 10, 13);
    self.img.centerY = self.shopName.centerY;
    
    self.orderStatus.frame = CGRectMake(SCREEN_WIDTH - 10 - 80, 28, 80, 15);
    self.orderStatus.centerY = self.shopName.centerY;
    self.orderStatus.text = orderModel.status;
    
}
@end
