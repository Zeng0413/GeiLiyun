//
//  ZDXStoreShopCarFormat.h
//  GeLiStore
//
//  Created by user99 on 2017/10/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZDXStoreShopCarFormatDelegate <NSObject>

@required

-(void)shopCarFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;

-(void)shopcartFormatAccountForTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected;

-(void)shopCarFormatSettleForSelectedProduct:(NSArray *)selectedProducts;

-(void)shopCarFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts;

-(void)shopCartFormatHasDeleteAllProduct;

@end

@interface ZDXStoreShopCarFormat : NSObject

@property (weak, nonatomic) id<ZDXStoreShopCarFormatDelegate> delegate;
//加载数据
-(void)requestShopCarProductList;

// 点击选择其中一row的商品
-(void)selectedProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;

// 点击选择其中一种品牌
-(void)selectedBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;

// 商品个数
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

// 删除一行的商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;

- (void)beginToDeleteSelectedProducts;

// 删除选中的全部商品
- (void)deleteSelectedProducts:(NSArray *)selectedArray;

// 收藏商品
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)starSelectedProducts;

// 判断是否全选
- (void)selectAllProductWithStatus:(BOOL)isSelected;
// 结算商品
- (void)settleSelectedProducts;


@end
