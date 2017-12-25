//
//  ZDXStoreOrderStatusViewController.h
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreConsigneeInfoModel.h"
@interface ZDXStoreOrderStatusViewController : UIViewController

@property (copy, nonatomic) NSString *orderId;

@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) ZDXStoreConsigneeInfoModel *consigneeInfoModel;

@property (assign, nonatomic) NSInteger type; // 支付类别
@property (assign, nonatomic) NSInteger isBatch; // 是否连贯支付 （1-是 0-否）
@end
