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
#import "ZDXStoreShopModel.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXComnous.h"

@implementation ZDXStoreShopCarTableViewProxy



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
        ZDXStoreShopModel *brandModel = self.dataArray[section];
        NSArray *productArr = brandModel.list;
        return productArr.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count != 0) {
        ZDXStoreShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDXStoreShopCarCell"];
        ZDXStoreShopModel *brandModel = self.dataArray[indexPath.section];
        NSArray *productArr = brandModel.list;
        if (productArr.count > indexPath.row) {
            ZDXStoreGoodsModel *productModel = productArr[indexPath.row];
            NSString *productName = [NSString stringWithFormat:@"%@%@", brandModel.shopName, productModel.goodsName];
            NSString *productSize = [NSString stringWithFormat:@"库存：%ld", productModel.goodsStock];
            
            [cell setupShopCarCellWithProductURL:productModel.goodsImg productName:productName productSize:productSize productPrice:productModel.shopPrice.integerValue productCount:productModel.cartNum productStock:productModel.cartNum productSelected:productModel.isSelected];
            
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
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZDXStoreShopCarHearView *shopCarHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZDXStoreShopCarHearView"];
    if (self.dataArray.count > section) {
        ZDXStoreShopModel *brandModel = self.dataArray[section];
        [shopCarHeaderView setupShopCarHeaderViewWithBrandName:brandModel.shopName brandSelect:brandModel.isSelected];
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
//    
//    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        if (self.shopcartProxyStarBlock) {
//            self.shopcartProxyStarBlock(indexPath);
//        }
//    }];
    return @[deleteAction];
   
}
@end
