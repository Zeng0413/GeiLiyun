//
//  ZDXStoreOrderGoodsShowCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderGoodsShowCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreOrderGoodsShowCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@end


@implementation ZDXStoreOrderGoodsShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.goodsName.textColor = colorWithString(@"#888888");
    self.goodsPrice.textColor = colorWithString(@"e93644");
    
    self.lineView.backgroundColor = colorWithString(@"#f2f2f2");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
