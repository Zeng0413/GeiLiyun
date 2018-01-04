//
//  ZDXStoreRefundReasonCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreRefundReasonCell : UITableViewCell

+(instancetype)initWithRefundReasonTableView:(UITableView *)tableView cellForRowAtIndexPAth:(NSIndexPath *)indexPath;

@property (assign, nonatomic) CGFloat cellH;
@end
