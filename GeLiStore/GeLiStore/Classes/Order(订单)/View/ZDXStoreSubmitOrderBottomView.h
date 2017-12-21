//
//  ZDXStoreSubmitOrderBottomView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^submitOrderBlock)();

@interface ZDXStoreSubmitOrderBottomView : UIView

+(instancetype)view;

@property (copy, nonatomic) NSString *goodsPrice;

@property (copy, nonatomic) submitOrderBlock block;

@property (assign, nonatomic) BOOL submitBtnIsSelected;
@end
