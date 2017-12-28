//
//  ZDXStoreCollectionStoreCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCollectionStoreCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreShopModel.h"

@interface ZDXStoreCollectionStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *storeImg;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeDetail;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeImgX;
@end

@implementation ZDXStoreCollectionStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultBtn setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
    [self.defaultBtn setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
    [self.defaultBtn addTarget:self action:@selector(defaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.defaultBtn.x = 10;
    self.defaultBtn.centerY = self.storeImg.centerY;
    self.defaultBtn.width = 22;
    self.defaultBtn.height = 22;
    self.defaultBtn.hidden = YES;
    [self.contentView addSubview:self.defaultBtn];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topLine.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    
    self.storeImg.layer.masksToBounds = YES;
    self.storeImg.layer.cornerRadius = 30;
    
    self.storeName.textColor = [UIColor colorWithHexString:@"#262626"];
    
    self.storeDetail.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    
    self.storeBtn.layer.cornerRadius = 7;
    self.storeBtn.layer.borderColor = [UIColor colorWithHexString:@"#e63944"].CGColor;
    self.storeBtn.layer.borderWidth = 1.0;
    [self.storeBtn setTitle:@"进店" forState:UIControlStateNormal];
    [self.storeBtn setTitleColor:[UIColor colorWithHexString:@"e63944"] forState:UIControlStateNormal];
}

-(void)setShopModel:(ZDXStoreShopModel *)shopModel{
    _shopModel = shopModel;
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,shopModel.shopImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    
    self.storeName.text = shopModel.shopName;
    
    if (shopModel.isSelected) {
        self.defaultBtn.selected = YES;
    }else{
        self.defaultBtn.selected = NO;
    }
    
}

-(void)isEditCollectionStore:(BOOL)isEdit{
    if (isEdit) {
        self.storeImgX.constant = 42;
        self.defaultBtn.hidden = NO;
    }else{
        self.storeImgX.constant = 10;
        self.defaultBtn.hidden = YES;
    }
}
- (IBAction)btnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(toShopBtnClick:)]) {
        [self.delegate toShopBtnClick:self.shopModel];
    }
}


-(void)defaultBtnClick{
    [self.delegate collectionStoreClick:self];
    
    if ([self.delegate respondsToSelector:@selector(selectedStoreWithShopModel:selectedStatus:)]) {
        [self.delegate selectedStoreWithShopModel:self.shopModel selectedStatus:!self.defaultBtn.isSelected];
    }
}
@end
