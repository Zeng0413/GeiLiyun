//
//  ZDXStoreShopCarCountView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCountViewEditBlock)(NSInteger count);

@interface ZDXStoreShopCarCountView : UIView

@property (nonatomic, copy) ShopcartCountViewEditBlock shopcartCountViewEditBlock;

-(void)setupShopCarCountViewWithProductCount:(NSInteger)productCount productStock:(NSInteger)productStock;
@end
