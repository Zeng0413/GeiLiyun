//
//  ZDXStoreMeOrderAndServiceCell.h
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreMeOrderAndServiceCellDelegate <NSObject>

-(void)cellSelectedTypeStr:(NSString *)str;

@end

@interface ZDXStoreMeOrderAndServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)setupUIWithMaxCols:(NSInteger)maxCols imageToView:(CGFloat)imageToView imageWH:(CGFloat)imageWH lableToImage:(CGFloat)lableToImage;

@property (assign, nonatomic) CGFloat cellH;

@property (strong, nonatomic) NSArray *dataList;

@property (weak, nonatomic) id<ZDXStoreMeOrderAndServiceCellDelegate> delegate;
@end
