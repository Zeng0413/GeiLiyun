//
//  ZDXStoreMyOrderCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMyOrderCell.h"
#import "ZDXComnous.h"

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

}



@end
