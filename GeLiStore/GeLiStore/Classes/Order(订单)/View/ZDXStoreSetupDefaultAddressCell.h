//
//  ZDXStoreSetupDefaultAddressCell.h
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^defaultAddressSelectBlock)(NSInteger type);
@interface ZDXStoreSetupDefaultAddressCell : UITableViewCell

@property (copy, nonatomic) defaultAddressSelectBlock block;

@end
