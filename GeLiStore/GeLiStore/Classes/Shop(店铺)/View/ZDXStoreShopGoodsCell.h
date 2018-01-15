//
//  ZDXStoreShopGoodsCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreGoodsModel;
@protocol ZDXStoreShopGoodsCellDelegate <NSObject>

-(void)selectedClickGoodsModel:(ZDXStoreGoodsModel *)goodsModel;

@end

@interface ZDXStoreShopGoodsCell : UITableViewCell

+(instancetype)initWithShopGoodsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) NSArray *dataList;

@property (assign, nonatomic) CGFloat cellH;

@property (weak, nonatomic) id<ZDXStoreShopGoodsCellDelegate> delegate;

@end
