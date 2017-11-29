//
//  ZDXStoreNoConsigneeInfoCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreNoConsigneeInfoCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreNoConsigneeInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZDXStoreNoConsigneeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    
    
}

- (IBAction)addNewAddress:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addNewAddress)]) {
        [self.delegate addNewAddress];
    }
}


@end
