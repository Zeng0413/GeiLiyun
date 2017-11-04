//
//  ZDXStoreShopCarHearView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartHeaderViewBlock)(BOOL isSelected);

@interface ZDXStoreShopCarHearView : UITableViewHeaderFooterView

@property (copy, nonatomic) ShopcartHeaderViewBlock shopCarHeaderViewBlock;

-(void)setupShopCarHeaderViewWithBrandName:(NSString *)brandName brandSelect:(BOOL)brandSelected;

@end
