//
//  ZDXStoreShopHeaderView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDXStoreShopModel;

@protocol ZDXStoreShopHeaderViewDelegate <NSObject>

-(void)addCollectionShopIsSelected:(BOOL)isSelected;

@end

@interface ZDXStoreShopHeaderView : UIView

+(instancetype)shopHeaderView:(CGRect)frame;

@property (strong, nonatomic) ZDXStoreShopModel *shopModel;

@property (assign, nonatomic) BOOL isSelected;

@property (weak, nonatomic) id<ZDXStoreShopHeaderViewDelegate> delegate;

@end
