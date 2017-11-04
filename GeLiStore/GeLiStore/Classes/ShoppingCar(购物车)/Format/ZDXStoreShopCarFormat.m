//
//  ZDXStoreShopCarFormat.m
//  GeLiStore
//
//  Created by user99 on 2017/10/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarFormat.h"
#import "ZDXComnous.h"
#import "ZDXStoreBrandModel.h"
#import <UIKit/UIKit.h>

@interface ZDXStoreShopCarFormat ()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;    /**< 购物车数据源 */

@end

@implementation ZDXStoreShopCarFormat
-(NSMutableArray *)shopcartListArray{
    if (!_shopcartListArray) {
        _shopcartListArray = [NSMutableArray array];
    }
    return _shopcartListArray;
}
//加载数据
-(void)requestShopCarProductList{
    //在这里请求数据 当然我直接用本地数据模拟的
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.shopcartListArray = [ZDXStoreBrandModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    // 成功后回调
    [self.delegate shopCarFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
}

// 点击选择其中一row的商品
-(void)selectedProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected{
    
    ZDXStoreBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    ZDXStoreProductModel *productModel = brandModel.products[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (ZDXStoreProductModel *aProductModel in brandModel.products) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 点击选择其中一种品牌
-(void)selectedBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected{
    ZDXStoreBrandModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (ZDXStoreProductModel *aProductModel in brandModel.products) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}


// 商品个数
-(void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    ZDXStoreBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    ZDXStoreProductModel *productModel = brandModel.products[indexPath.row];
    if (count <= 0) {
        count = 1;
    }
//    } else if (count > productModel.productStocks){
//        count = productModel.productStocks;
//    }
    
    // 根据请求结果决定是否改变数据
    productModel.productQty = count;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 全选
-(void)selectAllProductWithStatus:(BOOL)isSelected{
    for (ZDXStoreBrandModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (ZDXStoreProductModel *productModel in brandModel.products) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 结算
-(void)settleSelectedProducts{
    NSMutableArray *settleArray = [NSMutableArray array];
    for (ZDXStoreBrandModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [NSMutableArray array];
        for (ZDXStoreProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
        
        brandModel.selectedArray = selectedArray;
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
    }
    
    [self.delegate shopCarFormatSettleForSelectedProduct:settleArray];
}

#pragma mark - private methods
-(float)accountTotalPrice{
    float totalPrice = 0.f;
    for (ZDXStoreBrandModel *brandModel in self.shopcartListArray) {
        for (ZDXStoreProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalPrice += productModel.productPrice * productModel.productQty;
            }
        }
    }
    return totalPrice;
}

-(NSInteger)accountTotalCount{
    NSInteger totalCount = 0;
    
    for (ZDXStoreBrandModel *brandModel in self.shopcartListArray) {
        for (ZDXStoreProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalCount += productModel.productQty;
            }
        }
    }
    
    return totalCount;
}


-(BOOL)isAllSelected{
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (ZDXStoreBrandModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}


@end
