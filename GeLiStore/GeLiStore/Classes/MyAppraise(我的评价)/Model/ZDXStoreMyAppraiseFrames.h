//
//  ZDXStoreMyAppraiseFrames.h
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 名称
#define ZDXStoreCellNameFont [UIFont systemFontOfSize:13]
// 时间
#define ZDXStoreCellTimeFont [UIFont systemFontOfSize:13]
//正文字体
#define ZDXStoreCellContentFont [UIFont systemFontOfSize:14]

//商品名字体
#define ZDXStoreCellGoodsNameFont [UIFont systemFontOfSize:14]
//商品规格字体
#define ZDXStoreCellGoodsDetailFont [UIFont systemFontOfSize:13]
//商品价格字体
#define ZDXStoreCellGoodsPriceFont [UIFont systemFontOfSize:18]
@class ZDXStoreAppraiseModel;
@interface ZDXStoreMyAppraiseFrames : NSObject

@property (strong, nonatomic) ZDXStoreAppraiseModel *appraiseModel;

// 用户头像
@property (assign, nonatomic) CGRect headerImgF;
// 用户名称
@property (assign, nonatomic) CGRect userNameF;
// 评星View
@property (assign, nonatomic) CGRect appraiseStartViewF;
// 评价时间
@property (assign, nonatomic) CGRect timeF;
// 评价内容
@property (assign, nonatomic) CGRect contentF;
// 图片
@property (assign, nonatomic) CGRect appraisePhotosF;
// 商品图片
@property (assign, nonatomic) CGRect goodsImgF;
// 商品名
@property (assign, nonatomic) CGRect goodsNameF;
// 商品规格
@property (assign, nonatomic) CGRect goodsDetailF;
// 商品价格
@property (assign, nonatomic) CGRect goodsPriceF;

@property (assign, nonatomic) CGFloat cellH;
@end
