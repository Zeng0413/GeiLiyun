//
//  ZDXStoreShareClassifyCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/18.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreShareClassifyCell : UITableViewCell

+(instancetype)initWithShareTableView:(UITableView *)tableView cellForAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) CGFloat cellH;

@end
