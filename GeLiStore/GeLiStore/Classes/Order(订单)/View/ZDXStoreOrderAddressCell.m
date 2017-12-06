//
//  ZDXStoreOrderAddressCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderAddressCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreOrderAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation ZDXStoreOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.name.textColor = blackLabelColor;
    self.phone.textColor = blackLabelColor;
    self.address.textColor = blackLabelColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


-(void)setModel:(ZDXStoreConsigneeInfoModel *)model{
    _model = model;
    
    self.name.text = [NSString stringWithFormat:@"收货人：%@",model.userName];
    self.phone.text = model.userPhone;
    self.address.text = [NSString stringWithFormat:@"%@,%@",model.areaName,model.userAddress];    
}

@end
