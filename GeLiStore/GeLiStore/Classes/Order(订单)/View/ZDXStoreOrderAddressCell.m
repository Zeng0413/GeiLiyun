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
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
