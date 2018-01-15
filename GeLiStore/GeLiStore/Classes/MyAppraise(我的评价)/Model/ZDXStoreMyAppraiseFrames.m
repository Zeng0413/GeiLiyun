//
//  ZDXStoreMyAppraiseFrames.m
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreMyAppraiseFrames.h"
#import "ZDXComnous.h"
#import "ZDXStorePhotosView.h"
#import "ZDXStoreAppraiseModel.h"

@implementation ZDXStoreMyAppraiseFrames

-(void)setAppraiseModel:(ZDXStoreAppraiseModel *)appraiseModel{
    _appraiseModel = appraiseModel;
    
    // 用户头像
    CGFloat headerWH = 35;
    CGFloat headerX = 10;
    CGFloat headerY = 40;
    self.headerImgF = CGRectMake(headerX, headerY, headerWH, headerWH);
    
    // 用户名称
    CGFloat nameX = CGRectGetMaxX(self.headerImgF) + 10;
    CGFloat nameY = headerY;
    CGSize nameSize = [appraiseModel.userName sizeWithFont:ZDXStoreCellNameFont];
    self.userNameF = (CGRect){{nameX, nameY}, nameSize};
    
    // 评星View
    CGFloat startViewX = nameX;
    CGFloat startViewY = CGRectGetMaxY(self.userNameF) + 4;
    self.appraiseStartViewF = CGRectMake(startViewX, startViewY, 117, 15);
    
    // 评价时间
    CGSize timeSize = [appraiseModel.createTime sizeWithFont:ZDXStoreCellTimeFont];
    
    
    self.timeF = CGRectMake(SCREEN_WIDTH - timeSize.width -10, 45, timeSize.width, timeSize.height);
 
    // 评价内容
    CGFloat contentX = headerX;
    CGFloat contentY = CGRectGetMaxY(self.headerImgF) + 15;
    CGSize contentSize = [appraiseModel.content sizeWithFont:ZDXStoreCellContentFont maxW:SCREEN_WIDTH - contentX * 2];
    self.contentF = (CGRect){{contentX, contentY}, contentSize};

    // 图片
    CGFloat goodsImgY = 0;
    if (appraiseModel.imagesArray.count>0) {
        CGFloat imagesX = contentX;
        CGFloat imagesY = CGRectGetMaxY(self.contentF) + 20;
        CGSize imageSize = [ZDXStorePhotosView sizeWithCount:appraiseModel.imagesArray.count];
        self.appraisePhotosF = (CGRect){{imagesX, imagesY}, imageSize};
        goodsImgY = CGRectGetMaxY(self.appraisePhotosF) + 30;
    }else{
        goodsImgY = CGRectGetMaxY(self.contentF) + 30;
    }
    

    // 商品图片
    CGFloat goodsImgX = contentX;
    CGFloat goodsImgWH = 80;
    
    self.goodsImgF = CGRectMake(goodsImgX, goodsImgY, goodsImgWH, goodsImgWH);
    // 商品名
    CGFloat goodsNameX = CGRectGetMaxX(self.goodsImgF) + 15;
    CGFloat goodsNameY = goodsImgY;
    CGSize goodsNameSize = [appraiseModel.goodsName sizeWithFont:ZDXStoreCellGoodsNameFont maxW:SCREEN_WIDTH - goodsNameX - 10];
    self.goodsNameF = (CGRect){{goodsNameX, goodsNameY}, goodsNameSize};
    // 商品规格
    CGFloat goodsDetailX = goodsNameX;
    CGFloat goodsDetailY = CGRectGetMaxY(self.goodsNameF) + 6;
    

    self.goodsDetailF = CGRectMake(goodsDetailX, goodsDetailY, 80, 13);
    // 商品价格
    NSString *price = @"¥3559.00";
    CGFloat priceX = goodsDetailX;
    CGFloat priceY = CGRectGetMaxY(self.goodsDetailF) + 19;
    CGSize priceSize = [price sizeWithFont:ZDXStoreCellGoodsPriceFont];
    
    self.goodsPriceF = (CGRect){{priceX, priceY},priceSize};
    
    self.cellH = CGRectGetMaxY(self.goodsPriceF) + 15;

}

@end
