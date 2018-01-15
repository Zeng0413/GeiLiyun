//
//  ZDXStoreCollectionStoreCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDXStoreShopModel.h"

@protocol ZDXStoreCollectionStoreCellDelegate <NSObject>

-(void)toShopBtnClick:(ZDXStoreShopModel *)shopModel;

-(void)collectionStoreClick:(UITableViewCell *)storeCell;

-(void)selectedStoreWithShopModel:(ZDXStoreShopModel *)shopModel selectedStatus:(BOOL)selectedStatus;

@end

@interface ZDXStoreCollectionStoreCell : UITableViewCell

@property (strong, nonatomic) ZDXStoreShopModel *shopModel;

@property (weak, nonatomic) id<ZDXStoreCollectionStoreCellDelegate> delegate;

@property (strong, nonatomic) UIButton *defaultBtn;

-(void)isEditCollectionStore:(BOOL)isEdit;

@end
