//
//  ZDXStoreMyOrderCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreGoodsModel;
@class ZDXStoreOrderModel;

@interface ZDXStoreMyOrderCell : UITableViewCell

@property (strong, nonatomic) ZDXStoreOrderModel *orderModel;
@property (strong, nonatomic) ZDXStoreGoodsModel *goodsModel;

@property (assign, nonatomic) BOOL isAppraise;

@property (assign, nonatomic) NSInteger row;
@end
