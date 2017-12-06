//
//  ZDXStoreDeliveryInstallCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreDeliveryInstallCell.h"
#import "UIColor+ColorChange.h"

@interface ZDXStoreDeliveryInstallCell ()
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *deliveryType;
@property (weak, nonatomic) IBOutlet UILabel *installType;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ZDXStoreDeliveryInstallCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.title1.textColor = [UIColor colorWithHexString:@"#262626"];
    self.title2.textColor = [UIColor colorWithHexString:@"#262626"];
    self.deliveryType.textColor = [UIColor colorWithHexString:@"#262626"];
    self.installType.textColor = [UIColor colorWithHexString:@"#262626"];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
}



@end
