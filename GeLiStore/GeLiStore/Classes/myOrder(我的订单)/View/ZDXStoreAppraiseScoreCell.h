//
//  ZDXStoreAppraiseScoreCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreAppraiseScoreCell;
@protocol ZDXStoreAppraiseScoreCellDelegate <NSObject>

-(void)goodsScoreTypeCell:(ZDXStoreAppraiseScoreCell *)cell appraiseScore:(NSInteger)score;

@end

@interface ZDXStoreAppraiseScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) id<ZDXStoreAppraiseScoreCellDelegate> delegate;
@end
