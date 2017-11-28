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
#import "ZDXStoreShopCartNoCell.h"
#import "ZDXComnous.h"

@implementation ZDXStoreShopCarTableViewProxy


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
        ZDXStoreShopModel *brandModel = self.dataArray[section];
        NSArray *productArr = brandModel.list;
        return productArr.count;
    }
    return 1;
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
    
    
    ZDXStoreShopCartNoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noCell"];
    if (!cell) {
        cell = [[ZDXStoreShopCartNoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noCell"];
    }
    
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 0) {
        UITabBarController *tabBarVC = [[UITabBarController alloc] init];
        CGFloat tabBarHeight = tabBarVC.tabBar.frame.size.height;
        
        return SCREEN_HEIGHT - 64 - tabBarHeight;
    }else{
        return 100;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
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
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count != 0) {
        return 40;
    }else{
        return 0;
    }
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count != 0) {
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
    }else{
        return 0;
    }
    
}



@end
