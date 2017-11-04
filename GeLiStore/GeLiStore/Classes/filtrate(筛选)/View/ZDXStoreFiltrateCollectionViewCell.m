//
//  ZDXStoreFiltrateCollectionViewCell.m
//  GeLiStore
//
//  Created by zdx on 2017/11/2.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltrateCollectionViewCell.h"
#import "UIColor+ColorChange.h"
#import "ZDXStoreProductModel.h"
@interface ZDXStoreFiltrateCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *commdityImage;
@property (weak, nonatomic) IBOutlet UILabel *commdityName;
@property (weak, nonatomic) IBOutlet UILabel *commdityPrice;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;



@end

@implementation ZDXStoreFiltrateCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commdityName.textColor = [UIColor colorWithHexString:@"#444444"];
    self.commdityPrice.textColor = [UIColor colorWithHexString:@"#e93644"];
    
    self.buyBtn.layer.borderColor = [UIColor colorWithHexString:@"#e93644"].CGColor;
    self.buyBtn.layer.borderWidth = 1;
    self.buyBtn.layer.cornerRadius = 7;
    [self.buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor colorWithHexString:@"#e93644"] forState:UIControlStateNormal];
    
}

-(void)setProductModel:(ZDXStoreProductModel *)productModel{
    _productModel = productModel;
    
    self.commdityImage.image = [UIImage imageNamed:productModel.productPicUri];
    
    NSString *productName = [NSString stringWithFormat:@"  %@",productModel.productName];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:productName];
    CGFloat attchWH = self.commdityName.font.lineHeight;
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"参与抵扣"];
    attch.bounds = CGRectMake(0, -4, 45, attchWH - 2);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.commdityName.attributedText = attri;
    
    self.commdityPrice.text = [NSString stringWithFormat:@"¥%ld",productModel.productPrice];
    
}
@end
