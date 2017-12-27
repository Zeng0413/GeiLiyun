//
//  ZDXStoreOrderPaySendTypeCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderPaySendTypeCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreOrderPaySendTypeCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end

@implementation ZDXStoreOrderPaySendTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topView.backgroundColor = [ UIColor colorWithHexString:@"#f4f4f4"];
    self.bottomView.backgroundColor = [ UIColor colorWithHexString:@"#f4f4f4"];
    
    self.price.textColor = [UIColor colorWithHexString:@"#e93644"];
    self.orderId.textColor = [UIColor colorWithHexString:@"#888888"];
    self.orderTime.textColor = [UIColor colorWithHexString:@"#888888"];
    // Initialization code
}




@end
