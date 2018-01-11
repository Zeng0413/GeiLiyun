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
    CGFloat headerWH = 25;
    CGFloat headerX = 10;
    CGFloat headerY = 40;
    self.headerImgF = CGRectMake(headerX, headerY, headerWH, headerWH);
    
    // 用户名称
    CGFloat nameX = CGRectGetMaxX(self.headerImgF) + 10;
    CGFloat nameY = headerY;
    CGSize nameSize = [appraiseModel.userName sizeWithFont:ZDXStoreCellNameFont];
    self.userNameF = (CGRect){{nameX, nameY}, nameSize};
    
    // 评星View
    CGFloat startViewX = nameY;
    CGFloat startViewY = CGRectGetMaxY(self.userNameF) + 4;
    self.appraiseStartViewF = CGRectMake(startViewX, startViewY, 117, 15);
    
    // 评价时间
    CGFloat timeW = 100;
    CGFloat timeH = 13;
//    self.timeF = c
//    @property (assign, nonatomic) CGRect timeF;
//    // 评价内容
//    @property (assign, nonatomic) CGRect contentF;
//    // 图片
//    @property (assign, nonatomic) CGRect appraisePhotosF;
//    // 商品图片
//    @property (assign, nonatomic) CGRect goodsImgF;
//    // 商品名
//    @property (assign, nonatomic) CGRect goodsNameF;
//    // 商品规格
//    @property (assign, nonatomic) CGRect goodsDetailF;
//    // 商品价格
//    @property (assign, nonatomic) CGRect goodsPriceF;
}

@end
