//
//  ZDXStoreGoodsAppraiseDescCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreGoodsAppraiseDescCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreGoodsAppraiseDescCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation ZDXStoreGoodsAppraiseDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
