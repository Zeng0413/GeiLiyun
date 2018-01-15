//
//  ZDXStoreMyAppraiseCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreMyAppraiseFrames.h"
@interface ZDXStoreMyAppraiseCell : UITableViewCell

+(instancetype)cellWithAppraiseTableView:(UITableView *)tableView;

@property (strong, nonatomic) ZDXStoreMyAppraiseFrames *myAppraiseFrames;
@end
