//
//  ZDXStoreGoodsClassifyModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/10.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreGoodsClassifyModel : NSObject

@property (assign, nonatomic) NSInteger catId;
@property (assign, nonatomic) NSInteger parentId;
@property (assign, nonatomic) NSInteger isShow;
@property (assign, nonatomic) NSInteger isFloor;
@property (assign, nonatomic) NSInteger catSort;
@property (assign, nonatomic) NSInteger dataFlag;
@property (copy, nonatomic) NSString *catName;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *catImg;
@property (copy, nonatomic) NSString *commissionRate;

@end
