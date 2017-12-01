//
//  ZDXStoreConsigneeInfoModel.h
//  GeLiStore
//
//  Created by user99 on 2017/12/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreConsigneeInfoModel : NSObject

@property (assign, nonatomic) NSInteger areaId;
@property (copy, nonatomic) NSString *areaName1;
@property (copy, nonatomic) NSString *userAddress;
@property (assign, nonatomic) NSInteger isDefault;
@property (copy, nonatomic) NSString *userPhone;
@property (assign, nonatomic) NSInteger addressId;
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *userName;
@property (assign, nonatomic) NSInteger dataFlag;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *areaIdPath;
@property (copy, nonatomic) NSString *areaId2;
@property (copy, nonatomic) NSString *areaName;

@end
