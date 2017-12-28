//
//  ZDXStoreCollectionGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCollectionGoodsCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreCollectionGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageX;



@end

@implementation ZDXStoreCollectionGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultBtn setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
    [self.defaultBtn setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
    [self.defaultBtn addTarget:self action:@selector(defaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.defaultBtn.x = 10;
    self.defaultBtn.centerY = self.contentView.centerY;
    self.defaultBtn.width = 22;
    self.defaultBtn.height = 22;
    self.defaultBtn.hidden = YES;
    [self.contentView addSubview:self.defaultBtn];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.goodsName.textColor = blackLabelColor;
    self.goodsDetail.textColor = colorWithString(@"#8a8a8a");
    self.goodsPrice.textColor = colorWithString(@"#e63944");
    self.shadowView.backgroundColor = colorWithString(@"#f4f4f4");
    
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,goodsModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    self.goodsName.text = goodsModel.goodsName;
    self.goodsDetail.text = [NSString stringWithFormat:@"重量 %ld",goodsModel.goodsStock];
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%@",goodsModel.shopPrice];
    
    if (goodsModel.isSelected) {
        self.defaultBtn.selected = YES;
    }else{
        self.defaultBtn.selected = NO;
    }
    
}

-(void)isEditStatus:(BOOL)isEdit{
    if (isEdit) {
        self.imageX.constant = 42;
        self.defaultBtn.hidden = NO;
    }else{
        self.imageX.constant = 10;
        self.defaultBtn.hidden = YES;

    }
}

-(void)defaultBtnClick{
//    self.defaultBtn.selected = !self.defaultBtn.isSelected;
    [self.delegate myTabClick:self];
    
    if ([self.delegate respondsToSelector:@selector(collectionGoodsWithModel:selectedStatus:)]) {
        [self.delegate collectionGoodsWithModel:self.goodsModel selectedStatus:!self.defaultBtn.isSelected];
    }
    
}

@end
