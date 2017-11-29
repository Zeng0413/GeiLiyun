//
//  ZDXStoreShopCartNoGoodsView.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCartNoGoodsView.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreShopCartNoGoodsView ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZDXStoreShopCartNoGoodsView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
}

+(instancetype)view{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZDXStoreShopCartNoGoodsView" owner:nil options:nil] firstObject];
}
@end
