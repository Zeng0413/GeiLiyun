//
//  ZDXStoreGoodsModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/10.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreGoodsModel : NSObject

@property (assign, nonatomic) NSInteger goodsId; // 商品id
@property (copy, nonatomic) NSString *goodsName; // 商品名
@property (copy, nonatomic) NSString *goodsImg;  // 商品图片
@property (copy, nonatomic) NSString *shopPrice; // 购买价格
@property (assign, nonatomic) NSInteger shopId;  // 购买id
@property (copy, nonatomic) NSString *marketPrice; // 市场价格
@property (assign, nonatomic) NSInteger goodsStock; // 商品库存
@property (copy, nonatomic) NSString *goodsTips; // 商品小窍门
@property (copy, nonatomic) NSString *goodsDesc; // 商品详情（html格式）
@property (assign, nonatomic) NSInteger goodsStatus; // 商品状态
@property (copy, nonatomic) NSString *saleTime;  // 销售时间
@property (strong, nonatomic) NSArray *gallery;  // 商品轮播图 数组
@property (copy, nonatomic) NSString *createTime; // 商品创建时间
@property (assign, nonatomic) NSInteger appraiseNum; // 评价数
@end
