//
//  ZDXStoreShopCarCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCellBlock)(BOOL isSelected);
typedef void(^ShopcartCellEditBlock)(NSInteger count);

@interface ZDXStoreShopCarCell : UITableViewCell

@property (nonatomic, copy) ShopcartCellBlock shopcartCellBlock;
@property (nonatomic, copy) ShopcartCellEditBlock shopcartCellEditBlock;

-(void)setupShopCarCellWithProductURL:(NSString *)productURL
                          productName:(NSString *)productName
                          productSize:(NSString *)productSize
                         productPrice:(CGFloat)productPrice
                         productCount:(NSInteger)productCount
                         productStock:(NSInteger)productStock
                      productSelected:(BOOL)productSelected;

@property (assign, nonatomic) BOOL status;

@end
