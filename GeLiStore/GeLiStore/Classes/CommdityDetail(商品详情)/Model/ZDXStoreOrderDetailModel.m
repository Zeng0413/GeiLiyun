//
//  ZDXStoreOrderDetailModel.m
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreOrderDetailModel.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
@implementation ZDXStoreOrderDetailModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"goods" : [ZDXStoreGoodsModel class]};
}
@end
