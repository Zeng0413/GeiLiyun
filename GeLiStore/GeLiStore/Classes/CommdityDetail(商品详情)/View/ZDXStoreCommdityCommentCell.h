//
//  ZDXStoreCommdityCommentCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreCommdityCommentCellDelegate <NSObject>

-(void)selectedCommentClick;

@end

@interface ZDXStoreCommdityCommentCell : UITableViewCell

@property (weak, nonatomic) id<ZDXStoreCommdityCommentCellDelegate> delegate;

@end
