//
//  ZDXStoreAppraiseRemarkCell.h
//  GeLiStore
//
//  Created by user99 on 2018/1/5.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXTextView.h"

typedef void(^appraiseRemarkCellBlock)(NSInteger goodsScore);
@interface ZDXStoreAppraiseRemarkCell : UITableViewCell
@property (strong, nonatomic) ZDXTextView *textView;
@property (assign, nonatomic) NSInteger cellH;

@property (copy, nonatomic) appraiseRemarkCellBlock block;
@end
