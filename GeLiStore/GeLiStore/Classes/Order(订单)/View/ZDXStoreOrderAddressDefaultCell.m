//
//  ZDXStoreOrderAddressDefaultCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderAddressDefaultCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreOrderAddressDefaultCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation ZDXStoreOrderAddressDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title.textColor = colorWithString(@"#262626");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
