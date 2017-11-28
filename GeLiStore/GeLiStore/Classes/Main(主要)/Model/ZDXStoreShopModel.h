//
//  ZDXStoreShopModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/28.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreShopModel : NSObject

@property (assign, nonatomic) BOOL isSelected; // 记录相应section是否全选（自定义）
@property (strong, nonatomic) NSArray *selectedArray;

@property (assign, nonatomic) NSInteger goodsMoney;
@property (assign, nonatomic) NSInteger shopId;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *shopQQ;
@property (copy, nonatomic) NSArray *list;
@end
