//
//  ZDXStoreCommodityShowCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreProductModel;
@protocol ZDXStoreCommodityShowCellDelegate <NSObject>

-(void)selectedClickProductModel:(ZDXStoreProductModel *)productModel;

@end

@interface ZDXStoreCommodityShowCell : UITableViewCell

+(instancetype)initWithCommodityShowTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSArray *dataList;

@property (assign, nonatomic) CGFloat cellH;

@property (weak, nonatomic) id<ZDXStoreCommodityShowCellDelegate> delegate;

@end
