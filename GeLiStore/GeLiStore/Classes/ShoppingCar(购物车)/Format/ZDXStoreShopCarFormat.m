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
@property (assign, nonatomic) NSInteger num;
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

-(void)beginToDeleteSelectedProducts{
    NSMutableArray *selectedArray = [NSMutableArray array];
    for (ZDXStoreShopModel *shopModel in self.shopcartListArray) {
        for (ZDXStoreGoodsModel *goodsModel in shopModel.list) {
            if (goodsModel.isSelected) {
                [selectedArray addObject:goodsModel];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedProducts:selectedArray];
}


-(void)deleteSelectedProducts:(NSArray *)selectedArray{
    
    [MBProgressHUD showMessage:@""];
    self.num = 0;
    for (ZDXStoreGoodsModel *goodsModel in selectedArray) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *params = @{@"userId" : @([ZDXStoreUserModelTool userModel].userId), @"id" : @(goodsModel.cartId)};
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/delCart",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self deleteSelectedGoods:selectedArray count:self.num];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            return;
        }];
    }
    
    
}

-(void)deleteSelectedGoods:(NSArray *)selectedArray count:(NSInteger)num{
    
    self.num++;
    if (self.num == selectedArray.count) {
        [MBProgressHUD hideHUD];
        
        NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
        for (ZDXStoreShopModel *shopModel in self.shopcartListArray) {
            [shopModel.list removeObjectsInArray:selectedArray];
            
            if (shopModel.list.count == 0) {
                [emptyArray addObject:shopModel];
            }
        }
        
        if (emptyArray.count) {
            [self.shopcartListArray removeObjectsInArray:emptyArray];
        }
        
        [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
        
        if (self.shopcartListArray.count == 0) {
            [self.delegate shopCartFormatHasDeleteAllProduct];
        }
    }
    
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
    
    [MBProgressHUD showMessage:@""];
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(userModel.userId);
    params[@"id"] = @(productModel.cartId);
    params[@"buyNum"] = @(count);
    params[@"isCheck"] = @1;
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/changeCartGoods",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

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

// 删除一行
-(void)deleteProductAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreShopModel *shopModel = self.shopcartListArray[indexPath.section];
    ZDXStoreGoodsModel *goodsModel = shopModel.list[indexPath.row];
    
    [shopModel.list removeObject:goodsModel];
    if (shopModel.list.count == 0) {
        [self.shopcartListArray removeObject:shopModel];
    } else {
        if (!shopModel.isSelected) {
            BOOL isBrandSelected = YES;
            for (ZDXStoreShopModel *aProductModel in shopModel.list) {
                if (!aProductModel.isSelected) {
                    isBrandSelected = NO;
                    break;
                }
            }
            
            if (isBrandSelected) {
                shopModel.isSelected = YES;
            }
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [MBProgressHUD showMessage:@""];
    NSDictionary *params = @{@"userId" : @([ZDXStoreUserModelTool userModel].userId), @"id" : @(goodsModel.cartId)};
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/delCart",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopCartFormatHasDeleteAllProduct];
    }
}

#pragma mark - private methods
-(float)accountTotalPrice{
    float totalPrice = 0.f;
    for (ZDXStoreShopModel *brandModel in self.shopcartListArray) {
        for (ZDXStoreGoodsModel *productModel in brandModel.list) {
            if (productModel.isSelected) {
                totalPrice +=  productModel.shopPrice.floatValue * productModel.cartNum;
                
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
