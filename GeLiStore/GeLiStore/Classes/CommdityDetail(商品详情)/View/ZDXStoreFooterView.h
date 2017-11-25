//
//  ZDXStoreFooterView.h
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreFooterViewDelegate <NSObject>

-(void)addShopcar; //加入购物车
-(void)buyGoods;   //立即购买

@end

@interface ZDXStoreFooterView : UIView

@property(weak, nonatomic) id<ZDXStoreFooterViewDelegate> delegate;

@end
