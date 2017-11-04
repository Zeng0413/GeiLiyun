//
//  ZDXStoreShopCarBottomView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartBotttomViewAllSelectBlock)(BOOL isSelected); // 选择全部
typedef void(^ShopcartBotttomViewSettleBlock)(void); //结算
typedef void(^ShopcartBotttomViewStarBlock)(void); //收藏
typedef void(^ShopcartBotttomViewDeleteBlock)(void); //删除

@interface ZDXStoreShopCarBottomView : UIView

@property (nonatomic, copy) ShopcartBotttomViewAllSelectBlock shopcartBotttomViewAllSelectBlock;
@property (nonatomic, copy) ShopcartBotttomViewSettleBlock shopcartBotttomViewSettleBlock;
@property (nonatomic, copy) ShopcartBotttomViewStarBlock shopcartBotttomViewStarBlock;
@property (nonatomic, copy) ShopcartBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;


-(void)setupShopCarBottomViewWithTotalPrice:(CGFloat)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected;


// 改变编辑状态
-(void)changeShopCarBottomViewWithStatus:(BOOL)status;

@end
