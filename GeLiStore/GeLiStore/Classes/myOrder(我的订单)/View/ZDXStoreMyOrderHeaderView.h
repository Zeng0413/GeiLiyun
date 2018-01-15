//
//  ZDXStoreMyOrderHeaderView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreOrderModel;

@interface ZDXStoreMyOrderHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) ZDXStoreOrderModel *orderModel;

@end
