//
//  ZDXStoreNoConsigneeInfoCell.h
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreNoConsigneeInfoCellDelegate <NSObject>

-(void)addNewAddress;

@end

@interface ZDXStoreNoConsigneeInfoCell : UITableViewCell

@property (weak, nonatomic) id<ZDXStoreNoConsigneeInfoCellDelegate> delegate;

@end
