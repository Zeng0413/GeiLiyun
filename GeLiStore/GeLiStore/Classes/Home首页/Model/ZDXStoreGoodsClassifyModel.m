//
//  ZDXStoreGoodsClassifyModel.m
//  GeLiStore
//
//  Created by user99 on 2017/11/10.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreGoodsClassifyModel.h"
#import "ZDXStoreGoodsClassifySubModel.h"
#import "ZDXComnous.h"
@implementation ZDXStoreGoodsClassifyModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"child":[ZDXStoreGoodsClassifySubModel class]};
}
@end
