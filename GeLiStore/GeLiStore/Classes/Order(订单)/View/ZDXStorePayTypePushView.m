//
//  ZDXStorePayTypePushView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStorePayTypePushView.h"
#import "ZDXComnous.h"
@interface ZDXStorePayTypePushView ()
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation ZDXStorePayTypePushView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.price.textColor = colorWithString(@"#e93644");
    
}

+(instancetype)payTypePushView{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZDXStorePayTypePushView" owner:nil options:nil] firstObject];
}

- (IBAction)cancelBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(hidePayTypePushView)]) {
        [self.delegate hidePayTypePushView];
    }
    
}

-(void)setPayPrice:(CGFloat)payPrice{
    _payPrice = payPrice;
    
    self.price.text = [NSString stringWithFormat:@"¥ %.2f",payPrice];
}

// 支付宝支付
- (IBAction)alipayClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickPayType:)]) {
        [self.delegate clickPayType:1];
    }
}

// 微信支付
- (IBAction)wxPayClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickPayType:)]) {
        [self.delegate clickPayType:2];
    }
}
@end
