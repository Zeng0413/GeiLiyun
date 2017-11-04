//
//  ZDXStoreShopCarTableViewProxy.m
//  GeLiStore
//
//  Created by user99 on 2017/10/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarTableViewProxy.h"
#import "ZDXStoreProductModel.h"
#import "ZDXStoreBrandModel.h"
#import "ZDXStoreShopCarHearView.h"
#import "ZDXStoreShopCarCell.h"


@implementation ZDXStoreShopCarTableViewProxy


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZDXStoreBrandModel *brandModel = self.dataArray[section];
    NSArray *productArr = brandModel.products;
    return productArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDXStoreShopCarCell"];
    ZDXStoreBrandModel *brandModel = self.dataArray[indexPath.section];
    NSArray *productArr = brandModel.products;
    if (productArr.count > indexPath.row) {
        ZDXStoreProductModel *productModel = productArr[indexPath.row];
        NSString *productName = [NSString stringWithFormat:@"%@%@%@", brandModel.brandName, productModel.productStyle, productModel.productType];
        NSString *productSize = [NSString stringWithFormat:@"W:%ld H:%ld D:%ld", productModel.specWidth, productModel.specHeight, productModel.specLength];
        
        [cell setupShopCarCellWithProductURL:productModel.productPicUri productName:productName productSize:productSize productPrice:productModel.productPrice productCount:productModel.productQty productStock:productModel.productStocks productSelected:productModel.isSelected];
        
    }
    
    cell.status = self.status;
    
    __weak __typeof(self) weakSelf = self;
    cell.shopcartCellBlock = ^(BOOL isSelected) {
        if (weakSelf.shopcartProxyProductSelectBlock) {
            weakSelf.shopcartProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    
    cell.shopcartCellEditBlock = ^(NSInteger count) {
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZDXStoreShopCarHearView *shopCarHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZDXStoreShopCarHearView"];
    if (self.dataArray.count > section) {
        ZDXStoreBrandModel *brandModel = self.dataArray[section];
        [shopCarHeaderView setupShopCarHeaderViewWithBrandName:brandModel.brandName brandSelect:brandModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    shopCarHeaderView.shopCarHeaderViewBlock = ^(BOOL isSelected) {
        if (weakSelf.shopcartProxyBrandSelectBlock) {
            weakSelf.shopcartProxyBrandSelectBlock(isSelected, section);
        }
    };
    
    return shopCarHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }];
    
    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyStarBlock) {
            self.shopcartProxyStarBlock(indexPath);
        }
    }];
    
    return @[deleteAction, starAction];
}



@end
