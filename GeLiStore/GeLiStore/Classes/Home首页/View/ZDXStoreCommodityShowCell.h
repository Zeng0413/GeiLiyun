//
//  ZDXStoreCommodityShowCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreGoodsModel;
@protocol ZDXStoreCommodityShowCellDelegate <NSObject>

-(void)selectedClickGoodsModel:(ZDXStoreGoodsModel *)goodsModel;

@end

@interface ZDXStoreCommodityShowCell : UITableViewCell

+(instancetype)initWithCommodityShowTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSArray *dataList;

@property (assign, nonatomic) CGFloat cellH;

@property (weak, nonatomic) id<ZDXStoreCommodityShowCellDelegate> delegate;

@end
