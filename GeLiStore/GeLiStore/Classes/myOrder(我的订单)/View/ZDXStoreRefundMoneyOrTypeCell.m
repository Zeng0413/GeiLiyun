//
//  ZDXStoreRefundMoneyOrTypeCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreRefundMoneyOrTypeCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreRefundMoneyOrTypeCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *refundMoney;
@property (weak, nonatomic) IBOutlet UILabel *refundTypeL;
@property (weak, nonatomic) IBOutlet UILabel *refundTypeR;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *refundTypeDec;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@end


@implementation ZDXStoreRefundMoneyOrTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.lineView1.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.lineView2.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.refundMoney.textColor = [UIColor colorWithHexString:@"#262626"];
    self.refundTypeL.textColor = [UIColor colorWithHexString:@"#262626"];
    self.refundTypeR.textColor = [UIColor colorWithHexString:@"#262626"];
    self.money.textColor = [UIColor colorWithHexString:@"#e93644"];
    self.refundTypeDec.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
