//
//  ZDXStoreGoodsAppraiseBottomView.h
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreGoodsAppraiseBottomViewDelegate <NSObject>

-(void)submitAppraiseClick;

@end

@interface ZDXStoreGoodsAppraiseBottomView : UIView

@property (weak, nonatomic) id<ZDXStoreGoodsAppraiseBottomViewDelegate>delegate;
@end
