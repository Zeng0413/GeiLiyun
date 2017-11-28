//
//  ZDXStoreShopCartNoCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/28.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCartNoCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreShopCartNoCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZDXStoreShopCartNoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
