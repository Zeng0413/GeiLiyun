//
//  ZDXStoreDeductionTicketCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreDeductionTicketCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreDeductionTicketCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;

@end

@implementation ZDXStoreDeductionTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    self.titleName.textColor = [UIColor colorWithHexString:@"#ffaf3c"];
    self.lable1.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.lable2.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.lable3.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
}



@end
