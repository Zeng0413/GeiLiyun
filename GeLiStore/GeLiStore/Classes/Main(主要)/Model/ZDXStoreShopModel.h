//
//  ZDXStoreShopModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/28.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDXStoreGoodsModel.h"
@interface ZDXStoreShopModel : NSObject

@property (assign, nonatomic) BOOL isSelected; // 记录相应section是否全选（自定义）
@property (strong, nonatomic) NSArray *selectedArray;

@property (assign, nonatomic) NSInteger goodsMoney;
@property (assign, nonatomic) NSInteger shopId;
@property (assign, nonatomic) NSInteger shopUserId;
@property (copy, nonatomic) NSString *shopImg;
@property (copy, nonatomic) NSString *shopAddress;
@property (copy, nonatomic) NSString *shopTel;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *shopQQ;
@property (strong, nonatomic) NSDictionary *scores;

@property (assign, nonatomic) NSInteger favoriteId; // 收藏表Id

@property (assign, nonatomic) NSInteger favShop;

@property (strong, nonatomic) NSMutableArray *list;

@end
