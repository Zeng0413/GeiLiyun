//
//  ZDXStoreOrderPayAddressCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreConsigneeInfoModel.h"
@interface ZDXStoreOrderPayAddressCell : UITableViewCell

+(instancetype)initWithTableView:(UITableView *)tableView cellWithAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) CGFloat cellH;

@property (strong, nonatomic) ZDXStoreConsigneeInfoModel *model;
@end
