//
//  ZDXStoreGoodsModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/10.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreGoodsModel : NSObject

@property (assign, nonatomic) NSInteger goodsId;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *goodsImg;
@property (copy, nonatomic) NSString *shopPrice;

@end
