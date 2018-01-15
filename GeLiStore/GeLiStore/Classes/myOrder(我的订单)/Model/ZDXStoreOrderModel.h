//
//  ZDXStoreOrderModel.h
//  GeLiStore
//
//  Created by user99 on 2017/12/26.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreOrderModel : NSObject

@property (assign, nonatomic) NSInteger orderId;
@property (copy, nonatomic) NSString *orderNo;
@property (copy, nonatomic) NSString *shopName;
@property (assign, nonatomic) NSInteger shopId;
@property (copy, nonatomic) NSString *shopQQ;
@property (copy, nonatomic) NSString *goodsMoney;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *goodsImg;
@property (assign, nonatomic) NSInteger goodsId;
@property (assign, nonatomic) NSInteger goodsNum;


@property (copy, nonatomic) NSString *totalMoney;
@property (copy, nonatomic) NSString *realTotalMoney;
@property (assign, nonatomic) NSInteger orderStatus;
@property (copy, nonatomic) NSString *deliverType;
@property (copy, nonatomic) NSString *deliverMoney;
@property (copy, nonatomic) NSString *payType;
@property (copy, nonatomic) NSString *needPay;
@property (assign, nonatomic) NSInteger isAppraise;
@property (assign, nonatomic) NSInteger isRefund;
@property (assign, nonatomic) NSInteger orderSrc;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *status;
@property (strong, nonatomic) NSArray *list;

@end
