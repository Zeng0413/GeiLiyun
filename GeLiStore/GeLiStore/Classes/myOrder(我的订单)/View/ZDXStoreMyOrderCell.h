//
//  ZDXStoreMyOrderCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreOrderModel;

@protocol ZDXStoreMyOrderCellDelegate <NSObject>

-(void)orderSelected:(NSString *)str;

@end

@interface ZDXStoreMyOrderCell : UITableViewCell

@property (strong, nonatomic) ZDXStoreOrderModel *orderModel;

@property (weak, nonatomic) id<ZDXStoreMyOrderCellDelegate> delegate;
@end
