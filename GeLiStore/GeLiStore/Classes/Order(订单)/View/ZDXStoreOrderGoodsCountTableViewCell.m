//
//  ZDXStoreOrderGoodsCountTableViewCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderGoodsCountTableViewCell.h"
#import "UIColor+ColorChange.h"


@interface ZDXStoreOrderGoodsCountTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountPrice;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;
@property (weak, nonatomic) IBOutlet UILabel *rebatePrice;

@end

@implementation ZDXStoreOrderGoodsCountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.topView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    self.title1.textColor = [UIColor colorWithHexString:@"#262626"];
    self.goodsCountPrice.textColor = [UIColor colorWithHexString:@"#262626"];
    
    self.title2.textColor = [UIColor colorWithHexString:@"#888888"];
    self.title3.textColor = [UIColor colorWithHexString:@"#888888"];
    self.originalPrice.textColor = [UIColor colorWithHexString:@"#888888"];
    self.rebatePrice.textColor = [UIColor colorWithHexString:@"#888888"];
    
}

-(void)setGoodsPrice:(NSString *)goodsPrice{
    _goodsPrice = goodsPrice;
    
    self.goodsCountPrice.text = goodsPrice;
    
}

-(void)setOriginPrice:(NSString *)originPrice{
    _originPrice = originPrice;
    
    self.originalPrice.text = originPrice;
}
@end
