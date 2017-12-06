//
//  ZDXStoreSubmitOrderBottomView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSubmitOrderBottomView.h"
#import "ZDXComnous.h"

@interface ZDXStoreSubmitOrderBottomView ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *submitOrderBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ZDXStoreSubmitOrderBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lineView.backgroundColor = colorWithString(@"#f5f5f5");
    
    self.title.textColor = colorWithString(@"#262626");
    self.price.textColor = colorWithString(@"#e93644");
    
    self.submitOrderBtn.backgroundColor = colorWithString(@"#f95865");
    [self.submitOrderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    self.btnW.constant = SCREEN_WIDTH / 3 - 20;
    
}

+(instancetype)view{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZDXStoreSubmitOrderBottomView" owner:nil options:nil] firstObject];
}

-(void)setGoodsPrice:(NSString *)goodsPrice{
    _goodsPrice = goodsPrice;
    
    NSString *price = [NSString stringWithFormat:@"¥ %@",goodsPrice];
    CGSize size = [price sizeWithFont:[UIFont systemFontOfSize:14]];
    self.price.size = size;
    
    self.price.text = price;
}
- (IBAction)submitOrderBtn:(UIButton *)sender {
    
    if (self.block) {
        self.block();
    }
    
}
@end
