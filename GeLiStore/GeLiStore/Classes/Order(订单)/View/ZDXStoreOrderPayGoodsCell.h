//
//  ZDXStoreOrderPayGoodsCell.h
//  GeLiStore
//
//  Created by user99 on 2017/12/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDXStoreGoodsModel;
@interface ZDXStoreOrderPayGoodsCell : UITableViewCell

+(instancetype)initWithPayGoodsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) NSInteger cellH;

@property (strong, nonatomic) ZDXStoreGoodsModel *goodsModel;
@end
