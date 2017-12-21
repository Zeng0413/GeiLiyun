//
//  ZDXStoreShopCarFormat.m
//  GeLiStore
//
//  Created by user99 on 2017/10/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarFormat.h"
#import "ZDXComnous.h"
#import "ZDXStoreUserModel.h"
#import "ZDXStoreBrandModel.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreShopModel.h"
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
    ZDXStoreUserModel *model = [ZDXStoreUserModelTool userModel];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userId" : @(model.userId)};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/cartList",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) { // 请求成功
            self.shopcartListArray = [ZDXStoreShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carts"]];
            
            // 成功后回调
            [self.delegate shopCarFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
        }else{
            [self.delegate shopCartNoData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    //在这里请求数据 当然我直接用本地数据模拟的
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart" ofType:@"plist"];
//    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
}

// 点击选择其中一row的商品
-(void)selectedProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected{
    
    ZDXStoreShopModel *brandModel = self.shopcartListArray[indexPath.section];
    ZDXStoreGoodsModel *productModel = brandModel.list[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (ZDXStoreShopModel *aProductModel in brandModel.list) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 点击选择其中一种品牌
-(void)selectedBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected{
    ZDXStoreShopModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (ZDXStoreShopModel *aProductModel in brandModel.list) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}


// 商品个数
-(void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    ZDXStoreShopModel *brandModel = self.shopcartListArray[indexPath.section];
    ZDXStoreGoodsModel *productModel = brandModel.list[indexPath.row];
    if (count <= 0) {
        count = 1;
    }
//    } else if (count > productModel.productStocks){
//        count = productModel.productStocks;
//    }
    
    // 根据请求结果决定是否改变数据
    productModel.cartNum = count;
    
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(userModel.userId);
    params[@"id"] = @(productModel.cartId);
    params[@"buyNum"] = @(count);
    params[@"isCheck"] = @1;
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/addCart",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 全选
-(void)selectAllProductWithStatus:(BOOL)isSelected{
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (ZDXStoreShopModel *productModel in brandModel.list) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

// 结算
-(void)settleSelectedProducts{
    NSMutableArray *settleArray = [NSMutableArray array];
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
//        NSMutableArray *selectedArray = [NSMutableArray array];
        for (ZDXStoreGoodsModel *productModel in brandModel.list) {
            if (productModel.isSelected) {
                [settleArray addObject:productModel];
            }
        }
        
//        brandModel.selectedArray = selectedArray;
//        if (selectedArray.count) {
//            [settleArray addObject:brandModel];
//        }
    }
    
    [self.delegate shopCarFormatSettleForSelectedProduct:settleArray];
}

#pragma mark - private methods
-(float)accountTotalPrice{
    float totalPrice = 0.f;
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
        for (ZDXStoreGoodsModel *productModel in brandModel.list) {
            if (productModel.isSelected) {
                totalPrice += productModel.shopPrice.integerValue * productModel.cartNum;
            }
        }
    }
    return totalPrice;
}

-(NSInteger)accountTotalCount{
    NSInteger totalCount = 0;
    
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
        for (ZDXStoreGoodsModel *productModel in brandModel.list) {
            if (productModel.isSelected) {
                totalCount += productModel.cartNum;
            }
        }
    }
    
    return totalCount;
}


-(BOOL)isAllSelected{
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}


@end
