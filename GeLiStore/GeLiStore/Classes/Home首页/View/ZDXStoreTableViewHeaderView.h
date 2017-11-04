//
//  ZDXStoreTableViewHeaderView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStoreTableViewHeaderView : UIView
+(instancetype)headerView:(CGRect)frame;

@property (strong, nonatomic) NSArray *dataList;

@end
