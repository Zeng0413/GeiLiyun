//
//  ZDXStoreOrderFooterView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderFooterView.h"
#import "ZDXComnous.h"
#import "ZDXStoreOrderModel.h"
@interface ZDXStoreOrderFooterView ()
@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@end

@implementation ZDXStoreOrderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = colorWithString(@"#f4f4f4");
    [self addSubview:lineView];
    
    CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 3;
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3.layer.masksToBounds = YES;
    self.btn3.layer.cornerRadius = 7.0;
    self.btn3.layer.borderColor = colorWithString(@"#e63944").CGColor;
    self.btn3.layer.borderWidth = 1.0;
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn3 setTitleColor:colorWithString(@"#e63944") forState:UIControlStateNormal];
    self.btn3.width = btnW;
    self.btn3.height = 23;
    self.btn3.x = SCREEN_WIDTH - 10 - btnW;
    self.btn3.y = 40 /2 - 23 /2;
    [self addSubview:self.btn3];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 7.0;
    self.btn2.layer.borderColor = colorWithString(@"#959595").CGColor;
    self.btn2.layer.borderWidth = 1.0;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn2 setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    self.btn2.width = btnW;
    self.btn2.height = 23;
    self.btn2.x = SCREEN_WIDTH - 20 - btnW * 2;
    self.btn2.y = 40 /2 - 23 /2;
    [self addSubview:self.btn2];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 7.0;
    self.btn1.layer.borderColor = colorWithString(@"#959595").CGColor;
    self.btn1.layer.borderWidth = 1.0;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn1 setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    self.btn1.width = btnW;
    self.btn1.height = 23;
    self.btn1.x = SCREEN_WIDTH - 30 - btnW * 3;
    self.btn1.y = 40 /2 - 23 /2;
    [self addSubview:self.btn1];
    
    [self.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setOrderModel:(ZDXStoreOrderModel *)orderModel{
    _orderModel = orderModel;
    if (orderModel.isRefund != 0){ // 退款中
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
    }else{
        if (orderModel.isAppraise == 0) { // 待评价
            self.btn1.hidden = NO;
            self.btn2.hidden = NO;
            self.btn3.hidden = NO;
            [self.btn1 setTitle:@"退货" forState:UIControlStateNormal];
            [self.btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.btn3 setTitle:@"去评价" forState:UIControlStateNormal];
        }
        if (orderModel.isAppraise == 1) { // 已评价
            self.btn1.hidden = YES;
            self.btn2.hidden = YES;
            self.btn3.hidden = YES;
        }
    }
}

-(void)btnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(selectedOrderModel:withType:)]) {
        [self.delegate selectedOrderModel:self.orderModel withType:button.titleLabel.text];
    }
}

-(void)rightBtnClick{
    if ([self.delegate respondsToSelector:@selector(toPushViewWithOrderModel:)]) {
        [self.delegate toPushViewWithOrderModel:self.orderModel];
    }
}

@end
