//
//  ZDXStoreBrandModel.m
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreBrandModel.h"
#import "ZDXComnous.h"
@implementation ZDXStoreBrandModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"products":[ZDXStoreProductModel class]};
}

@end
