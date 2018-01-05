//
//  ZDXStoreRefundReasonCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXTextView.h"

@protocol ZDXStoreRefundReasonCellDelegate <NSObject>

-(void)selectedRefundReasonTag:(NSInteger)reasonTag;

@end

@interface ZDXStoreRefundReasonCell : UITableViewCell

+(instancetype)initWithRefundReasonTableView:(UITableView *)tableView cellForRowAtIndexPAth:(NSIndexPath *)indexPath;

@property (weak, nonatomic) id<ZDXStoreRefundReasonCellDelegate> delegate;

@property (strong, nonatomic) ZDXTextView *textView;

@property (assign, nonatomic) CGFloat cellH;
@end
