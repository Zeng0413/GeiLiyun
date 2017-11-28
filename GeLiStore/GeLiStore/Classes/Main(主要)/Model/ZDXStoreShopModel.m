//
//  ZDXStoreShopModel.m
//  GeLiStore
//
//  Created by user99 on 2017/11/28.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopModel.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"

@implementation ZDXStoreShopModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [ZDXStoreGoodsModel class]};
}

@end
