//
//  ZDXStoreBrandModel.h
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDXStoreProductModel.h"

@interface ZDXStoreBrandModel : NSObject

@property (copy, nonatomic) NSString *brandId;

@property (strong, nonatomic) NSArray *products;

@property (copy, nonatomic) NSString *brandName;

@property (assign, nonatomic) BOOL isSelected; // 记录相应section是否全选（自定义）

@property (strong, nonatomic) NSArray *selectedArray;

@property (copy, nonatomic) NSString *brandImg;
@end
