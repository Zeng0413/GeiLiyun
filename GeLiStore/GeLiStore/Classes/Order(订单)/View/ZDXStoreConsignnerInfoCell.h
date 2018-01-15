//
//  ZDXStoreConsignnerInfoCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreConsigneeInfoModel.h"

@protocol ZDXStoreConsignnerInfoCellDelegate <NSObject>

-(void)consigneeInfoOperationType:(NSString *)typeStr consigneeInfoModel:(ZDXStoreConsigneeInfoModel *)model;

@end

@interface ZDXStoreConsignnerInfoCell : UITableViewCell

+(instancetype)initWithConsigneeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) ZDXStoreConsigneeInfoModel *model;

@property (assign, nonatomic) CGFloat cellH;

@property (weak, nonatomic) id<ZDXStoreConsignnerInfoCellDelegate> delegate;

@end
