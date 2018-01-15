//
//  ZDXStoreShopHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopHeaderView.h"
#import "ZDXComnous.h"
#import "ZDXStoreShopModel.h"
#import "ZDXStoreUserModel.h"
@interface ZDXStoreShopHeaderView ()

@property (weak, nonatomic) UIImageView *shopImg;
@property (weak, nonatomic) UILabel *shopName;

@property (weak, nonatomic) UIImageView *startImg1;
@property (weak, nonatomic) UIImageView *startImg2;
@property (weak, nonatomic) UIImageView *startImg3;
@property (weak, nonatomic) UIImageView *startImg4;
@property (weak, nonatomic) UIImageView *startImg5;

@property (weak, nonatomic) UILabel *shopScore;
@property (weak, nonatomic) UIButton *shopCollectionBtn;
@property (weak, nonatomic) UILabel *collectionCount;

@end

@implementation ZDXStoreShopHeaderView

+(instancetype)shopHeaderView:(CGRect)frame{
    
    ZDXStoreShopHeaderView *headerView = [[ZDXStoreShopHeaderView alloc] init];
    headerView.frame = frame;

    [headerView setupUI:frame];
    
    return headerView;
}

-(void)setupUI:(CGRect)frame{
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:frame];
    backImg.image = [UIImage imageNamed:@"店铺背景"];
    [self addSubview:backImg];
    
    // 店铺图片
    UIImageView *shopImg = [[UIImageView alloc] init];
    shopImg.layer.masksToBounds = YES;
    shopImg.layer.cornerRadius = 7.0;
    shopImg.x = 10;
    shopImg.height = 40;
    shopImg.width = 40;
    shopImg.y = self.height - shopImg.height - 9;
    [self addSubview:shopImg];
    self.shopImg = shopImg;
    
    // 店铺名称
    UILabel *shopName = [[UILabel alloc] init];
    shopName.font = [UIFont systemFontOfSize:15];
    shopName.textColor = [UIColor whiteColor];
    shopName.x = CGRectGetMaxX(shopImg.frame) + 15;
    shopName.y = shopImg.y;
    shopName.width = 150;
    shopName.height = 15;
    [self addSubview:shopName];
    self.shopName = shopName;
    
    // 星星图片
    for (int i = 0; i < 5; i++) {
        UIImageView *startImg = [[UIImageView alloc] init];
        startImg.width = 10;
        startImg.height = 10;
        startImg.x = shopName.x + (3 + startImg.width) * i;
        startImg.y = CGRectGetMaxY(shopName.frame) + 15;
        
        startImg.image = [UIImage imageNamed:@"收藏后"];
        [self addSubview:startImg];
        if (i == 0) {
            self.startImg1 = startImg;
        }else if (i == 1){
            self.startImg2 = startImg;
        }else if (i == 2){
            self.startImg3 = startImg;
        }else if (i == 3){
            self.startImg4 = startImg;
        }else if (i == 4){
            self.startImg5 = startImg;
        }
    }
    
    // 店铺评分
    UILabel *shopScore = [[UILabel alloc] init];
    shopScore.font = [UIFont systemFontOfSize:13];
    shopScore.textColor = [UIColor whiteColor];
    shopScore.x = CGRectGetMaxX(self.startImg5.frame) + 5;
    shopScore.y = self.startImg5.y - 1;
    shopScore.width = 50;
    shopScore.height = 13;
    [self addSubview:shopScore];
    self.shopScore = shopScore;
    
    // 店铺收藏按钮
    UIButton *shopCollectionBtn = [[UIButton alloc] init];
    shopCollectionBtn.width = 60;
    shopCollectionBtn.height = 25;
    shopCollectionBtn.y = shopName.y;
    shopCollectionBtn.x = SCREEN_WIDTH - shopCollectionBtn.width - 10;
    
    [shopCollectionBtn setBackgroundColor:colorWithString(@"#e63944")];
    [shopCollectionBtn setTitle:@"收藏店铺" forState:UIControlStateNormal];
    
    [shopCollectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    shopCollectionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [shopCollectionBtn addTarget:self action:@selector(shopCollectionClick:) forControlEvents:UIControlEventTouchUpInside];
    shopCollectionBtn.layer.cornerRadius = 7.0;
    [self addSubview:shopCollectionBtn];
    self.shopCollectionBtn = shopCollectionBtn;
    
    // 店铺收藏人数
    UILabel *collectionCount = [[UILabel alloc] init];
    collectionCount.text = @"200人已收藏";
    collectionCount.font = [UIFont systemFontOfSize:13];
    collectionCount.textColor = [UIColor whiteColor];
    [collectionCount setTextAlignment:NSTextAlignmentRight];
    collectionCount.width = 150;
    collectionCount.height = 13;
    collectionCount.x = SCREEN_WIDTH - collectionCount.width - 10;
    collectionCount.y = CGRectGetMaxY(shopCollectionBtn.frame) + 5;
    [self addSubview:collectionCount];
    self.collectionCount = collectionCount;
}

-(void)setShopModel:(ZDXStoreShopModel *)shopModel{
    _shopModel = shopModel;
    
    [self.shopImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,shopModel.shopImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    
    self.shopName.text = shopModel.shopName;

    NSInteger totalScore = [shopModel.scores[@"totalScore"] integerValue];
    
    self.shopScore.text = [NSString stringWithFormat:@"%ld分",totalScore];
    
    UIImage *collectionBefore = [UIImage imageNamed:@"收藏前"];
    UIImage *collectionAfter = [UIImage imageNamed:@"收藏后"];

    
    if (totalScore > 0 && totalScore < 1) {
        self.startImg1.image = collectionBefore;
        self.startImg2.image = collectionBefore;
        self.startImg3.image = collectionBefore;
        self.startImg4.image = collectionBefore;
        self.startImg5.image = collectionBefore;
    }else if (totalScore >= 1 && totalScore < 2){
        self.startImg1.image = collectionAfter;
        self.startImg2.image = collectionBefore;
        self.startImg3.image = collectionBefore;
        self.startImg4.image = collectionBefore;
        self.startImg5.image = collectionBefore;
    }else if (totalScore >= 2 && totalScore < 3){
        self.startImg1.image = collectionAfter;
        self.startImg2.image = collectionAfter;
        self.startImg3.image = collectionBefore;
        self.startImg4.image = collectionBefore;
        self.startImg5.image = collectionBefore;
    }else if (totalScore >= 3 && totalScore < 4){
        self.startImg1.image = collectionAfter;
        self.startImg2.image = collectionAfter;
        self.startImg3.image = collectionAfter;
        self.startImg4.image = collectionBefore;
        self.startImg5.image = collectionBefore;
    }else if (totalScore >= 4 && totalScore < 5){
        self.startImg1.image = collectionAfter;
        self.startImg2.image = collectionAfter;
        self.startImg3.image = collectionAfter;
        self.startImg4.image = collectionAfter;
        self.startImg5.image = collectionBefore;
    }else{
        self.startImg1.image = collectionAfter;
        self.startImg2.image = collectionAfter;
        self.startImg3.image = collectionAfter;
        self.startImg4.image = collectionAfter;
        self.startImg5.image = collectionAfter;
    }
    
    if (shopModel.favShop != 0) {
        self.shopCollectionBtn.backgroundColor = [UIColor whiteColor];
        [self.shopCollectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.shopCollectionBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    }
}

-(void)shopCollectionClick:(UIButton *)button{
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    if (userModel) {
        self.isSelected = !self.isSelected;
        self.shopCollectionBtn.selected = self.isSelected;
        if (self.isSelected) {
            self.shopCollectionBtn.backgroundColor = [UIColor whiteColor];
            [self.shopCollectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            [self.shopCollectionBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        }else{
            [self.shopCollectionBtn setBackgroundColor:colorWithString(@"#e63944")];
            
            [self.shopCollectionBtn setTitle:@"收藏店铺" forState:UIControlStateNormal];
            [self.shopCollectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
       
    }
    if ([self.delegate respondsToSelector:@selector(addCollectionShopIsSelected:)]) {
        [self.delegate addCollectionShopIsSelected:self.isSelected];
    }
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    self.shopCollectionBtn.selected = self.isSelected;
    if (self.isSelected) {
        self.shopCollectionBtn.backgroundColor = [UIColor whiteColor];
    }else{
        [self.shopCollectionBtn setBackgroundColor:colorWithString(@"#e63944")];
    }
}
@end
