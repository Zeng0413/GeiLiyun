//
//  ZDXStoreCommdityDetailInfoCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreCommdityDetailInfoCell : UITableViewCell

+(instancetype)initWithCommdityDetailWithTableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) NSInteger cellH;
@end
