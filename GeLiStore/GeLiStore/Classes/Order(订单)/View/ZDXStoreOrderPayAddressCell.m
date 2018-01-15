//
//  ZDXStoreOrderPayAddressCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderPayAddressCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreOrderPayAddressCell ()

@property (weak, nonatomic) UILabel *consignnerLabel; // 收货人
@property (weak, nonatomic) UILabel *telNum;  // 收货人电话号码
@property (weak, nonatomic) UIImageView *addressImg; // 收货地址图标
@property (weak, nonatomic) UILabel *addressStr; // 收货地址

@property (weak, nonatomic) UIView *bottomView;
@end

@implementation ZDXStoreOrderPayAddressCell

+(instancetype)initWithTableView:(UITableView *)tableView cellWithAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    
    ZDXStoreOrderPayAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ZDXStoreOrderPayAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 收货人
        UILabel *consignnerLabel = [[UILabel alloc] init];
        consignnerLabel.textColor = blackLabelColor;
        consignnerLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:consignnerLabel];
        self.consignnerLabel = consignnerLabel;
        
        // 收货人电话号码
        UILabel *telNum = [[UILabel alloc] init];
        telNum.textColor = blackLabelColor;
        telNum.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:telNum];
        self.telNum = telNum;
        
        // 收货地址图标
        UIImageView *addressImg = [[UIImageView alloc] init];
        addressImg.image = [UIImage imageNamed:@"订单地址图标"];
        [self.contentView addSubview:addressImg];
        self.addressImg = addressImg;
        
        // 收货地址
        UILabel *addressStr = [[UILabel alloc] init];
        addressStr.textColor = blackLabelColor;
        addressStr.numberOfLines = 0;
        addressStr.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:addressStr];
        self.addressStr = addressStr;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = colorWithString(@"#f4f4f4");
        [self.contentView addSubview:bottomView];
        self.bottomView = bottomView;
    }
    
    return self;
}

-(void)setOrderDetailModel:(ZDXStoreOrderDetailModel *)orderDetailModel{
    _orderDetailModel = orderDetailModel;
    NSString *consignner = [NSString stringWithFormat:@"收货人：%@",orderDetailModel.userName];
    CGSize consignnerL = [consignner sizeWithFont:[UIFont systemFontOfSize:15]];
    self.consignnerLabel.frame = CGRectMake(32, 10, consignnerL.width, consignnerL.height);
    self.consignnerLabel.text = consignner;
    
    CGSize phoneSize = [orderDetailModel.userPhone sizeWithFont:[UIFont systemFontOfSize:15]];
    self.telNum.frame = CGRectMake(SCREEN_WIDTH - 10 - phoneSize.width, 10, phoneSize.width, phoneSize.height);
    self.telNum.text = orderDetailModel.userPhone;
    
    NSString *consignnerAdd = [NSString stringWithFormat:@"收货地址：%@",orderDetailModel.userAddress];
    CGSize consignnerAddSize = [consignnerAdd sizeWithFont:[UIFont systemFontOfSize:15] maxW:SCREEN_WIDTH - self.consignnerLabel.x - 10];
    self.addressStr.frame = CGRectMake(self.consignnerLabel.x, CGRectGetMaxY(self.consignnerLabel.frame) + 15, consignnerAddSize.width, consignnerAddSize.height);
    self.addressStr.text = consignnerAdd;
    
    self.addressImg.width = 12;
    self.addressImg.height = 17;
    self.addressImg.x = CGRectGetMinX(self.addressStr.frame) - 10 - self.addressImg.width;
    self.addressImg.centerY = self.addressStr.centerY;
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.addressStr.frame) + 18, SCREEN_WIDTH, 20);
    self.cellH = CGRectGetMaxY(self.bottomView.frame);
}

-(void)setModel:(ZDXStoreConsigneeInfoModel *)model{
    _model = model;
    
    NSString *consignner = [NSString stringWithFormat:@"收货人：%@",model.userName];
    CGSize consignnerL = [consignner sizeWithFont:[UIFont systemFontOfSize:15]];
    self.consignnerLabel.frame = CGRectMake(32, 10, consignnerL.width, consignnerL.height);
    self.consignnerLabel.text = consignner;
    
    CGSize phoneSize = [model.userPhone sizeWithFont:[UIFont systemFontOfSize:15]];
    self.telNum.frame = CGRectMake(SCREEN_WIDTH - 10 - phoneSize.width, 10, phoneSize.width, phoneSize.height);
    self.telNum.text = model.userPhone;
    
    NSString *consignnerAdd = [NSString stringWithFormat:@"收货地址：%@%@",model.areaName,model.userAddress];
    CGSize consignnerAddSize = [consignnerAdd sizeWithFont:[UIFont systemFontOfSize:15] maxW:SCREEN_WIDTH - self.consignnerLabel.x - 10];
    self.addressStr.frame = CGRectMake(self.consignnerLabel.x, CGRectGetMaxY(self.consignnerLabel.frame) + 15, consignnerAddSize.width, consignnerAddSize.height);
    self.addressStr.text = consignnerAdd;
    
    self.addressImg.width = 12;
    self.addressImg.height = 17;
    self.addressImg.x = CGRectGetMinX(self.addressStr.frame) - 10 - self.addressImg.width;
    self.addressImg.centerY = self.addressStr.centerY;
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.addressStr.frame) + 18, SCREEN_WIDTH, 20);
    self.cellH = CGRectGetMaxY(self.bottomView.frame);
}

@end
