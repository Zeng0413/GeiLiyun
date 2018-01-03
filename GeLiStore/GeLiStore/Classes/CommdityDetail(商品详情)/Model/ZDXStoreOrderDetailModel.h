//
//  ZDXStoreOrderDetailModel.h
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreOrderDetailModel : NSObject

@property (assign, nonatomic) NSInteger orderId;
@property (copy, nonatomic) NSString *orderNo;
@property (assign, nonatomic) NSInteger shopId;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger orderStatus; // 订单状态(-5:门店不同意退款；-4:门店同意退款；-3:用户拒收 -2:未付款的订单 -1：用户取消 0:待发货 1:配送中 2:用户确认收货;3:申请退款；4:申请退货)
@property (copy, nonatomic) NSString *goodsMoney;
@property (copy, nonatomic) NSString *deliverMoney;
@property (copy, nonatomic) NSString *totalMoney;
@property (copy, nonatomic) NSString *realTotalMoney;
@property (assign, nonatomic) NSInteger deliverType;
@property (assign, nonatomic) NSInteger payType;
@property (assign, nonatomic) NSInteger payFrom;
@property (assign, nonatomic) NSInteger isPay;
@property (assign, nonatomic) NSInteger areaId;
@property (copy, nonatomic) NSString *areaIdPath;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userAddress;
@property (copy, nonatomic) NSString *userPhone;
@property (assign, nonatomic) NSInteger orderScore;
@property (assign, nonatomic) NSInteger isInvoice; // 发票
@property (assign, nonatomic) NSInteger orderSrc;
@property (copy, nonatomic) NSString *needPay;
@property (copy, nonatomic) NSString *orderunique;
@property (copy, nonatomic) NSString *receiveTime;
@property (copy, nonatomic) NSString *deliveryTime;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *shopQQ;
@property (strong, nonatomic) NSArray *goods;




@end
