//
//  ZDXStoreOrderModel.m
//  GeLiStore
//
//  Created by user99 on 2017/12/26.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderModel.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"

@implementation ZDXStoreOrderModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [ZDXStoreGoodsModel class]};
}

@end
