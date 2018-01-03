//
//  ZDXStoreOrderFooterView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreOrderModel;
@protocol ZDXStoreOrderFooterViewDelegate <NSObject>

-(void)selectedOrderModel:(ZDXStoreOrderModel *)orderModel withType:(NSString *)type;
-(void)toPushViewWithOrderModel:(ZDXStoreOrderModel *)orderModel;

@end

@interface ZDXStoreOrderFooterView : UITableViewHeaderFooterView

@property (strong, nonatomic) ZDXStoreOrderModel *orderModel;

@property (weak, nonatomic) id<ZDXStoreOrderFooterViewDelegate> delegate;
@end
