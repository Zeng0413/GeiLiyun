//
//  ZDXStoreCommodityClassifyCell.h
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreCommodityClassifyCellDelegate <NSObject>

-(void)selectedCommodityClassifyString:(NSString *)string;

@end

@interface ZDXStoreCommodityClassifyCell : UITableViewCell

+(instancetype)initWithCommodityClassifyTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (assign, nonatomic) CGFloat cellH;

@property (weak, nonatomic) id<ZDXStoreCommodityClassifyCellDelegate> delegate;

@end
