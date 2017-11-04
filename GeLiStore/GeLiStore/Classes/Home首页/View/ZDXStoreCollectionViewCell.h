//
//  ZDXStoreCollectionViewCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDXStoreProductModel;
@interface ZDXStoreCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)ZDXStoreProductModel *productModel;

@property (assign, nonatomic) CGFloat itemH;

@end
