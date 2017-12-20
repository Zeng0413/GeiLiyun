//
//  ZDXStoreShopHeaderView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDXStoreShopModel;
@interface ZDXStoreShopHeaderView : UIView

+(instancetype)shopHeaderView:(CGRect)frame;

@property (strong, nonatomic) ZDXStoreShopModel *shopModel;
@end
