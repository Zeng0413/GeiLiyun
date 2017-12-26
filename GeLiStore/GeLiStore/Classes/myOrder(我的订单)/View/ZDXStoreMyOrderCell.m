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
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW3;
@end

@implementation ZDXStoreMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.goodsName.textColor = colorWithString(@"#262626");
    self.goodsDetail.textColor = colorWithString(@"#8a8a8a");
    self.goodsPrice.textColor = colorWithString(@"#e63944");
    self.orderTime.textColor = colorWithString(@"#8a8a8a");
    
    self.btn1.layer.masksToBounds = YES;
    self.btn2.layer.masksToBounds = YES;
    self.btn3.layer.masksToBounds = YES;
    
    self.btn1.layer.cornerRadius = 7.0;
    self.btn1.layer.borderColor = colorWithString(@"#959595").CGColor;
    self.btn1.layer.borderWidth = 1.0;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn1 setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    
    self.btn2.layer.cornerRadius = 7.0;
    self.btn2.layer.borderColor = colorWithString(@"#959595").CGColor;
    self.btn2.layer.borderWidth = 1.0;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn2 setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    
    self.btn3.layer.cornerRadius = 7.0;
    self.btn3.layer.borderColor = colorWithString(@"#e63944").CGColor;
    self.btn3.layer.borderWidth = 1.0;
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn3 setTitleColor:colorWithString(@"#e63944") forState:UIControlStateNormal];
    
    CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 3;
    self.btnW1.constant = btnW;
    self.btnW2.constant = btnW;
    self.btnW3.constant = btnW;

    [self.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(orderSelected:)]) {
        [self.delegate orderSelected:button.titleLabel.text];
    }
}

-(void)setOrderModel:(ZDXStoreOrderModel *)orderModel{
    _orderModel = orderModel;
    ZDXStoreGoodsModel *goodsModel = [orderModel.list firstObject];
    
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    
    self.goodsName.text = goodsModel.goodsName;
    self.goodsDetail.text = orderModel.deliverType;
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",goodsModel.goodsPrice];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\" "];
    NSArray *strList = [orderModel.createTime componentsSeparatedByCharactersInSet:set];
    self.orderTime.text = strList[0];
    
    if (orderModel.isAppraise != 0) { // 待评价
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.btn3.hidden = NO;
        [self.btn1 setTitle:@"退货" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.btn3 setTitle:@"去评价" forState:UIControlStateNormal];
    }else if (orderModel.isRefund != 0){ // 退款中
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
        self.btn3.hidden = YES;
    }else if (orderModel.orderStatus == -2){ // 待付款
        self.btn1.hidden = YES;
        self.btn2.hidden = NO;
        self.btn3.hidden = NO;
        [self.btn2 setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.btn3 setTitle:@"去付款" forState:UIControlStateNormal];
    }else if (orderModel.orderStatus == 0){ // 待发货
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
        self.btn3.hidden = NO;
        [self.btn3 setTitle:@"退款" forState:UIControlStateNormal];
    }else if (orderModel.orderStatus == 1){ // 待收货
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.btn3.hidden = NO;
        [self.btn1 setTitle:@"退货" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.btn3 setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    
}

@end
