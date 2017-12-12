//
//  ZDXStoreCollectionGoodsCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreGoodsModel.h"

@protocol ZDXStoreCollectionGoodsCellDelegate <NSObject>

-(void)collectionGoodsWithModel:(ZDXStoreGoodsModel *)goodsModel selectedStatus:(BOOL)selectedStatus;

-(void)myTabClick:(UITableViewCell *)cell;

@end

@interface ZDXStoreCollectionGoodsCell : UITableViewCell

@property (weak, nonatomic) id<ZDXStoreCollectionGoodsCellDelegate> delegate;

@property (strong, nonatomic) ZDXStoreGoodsModel *goodsModel;

@property (strong, nonatomic) UIButton *defaultBtn;

-(void)isEditStatus:(BOOL)isEdit;
@end
