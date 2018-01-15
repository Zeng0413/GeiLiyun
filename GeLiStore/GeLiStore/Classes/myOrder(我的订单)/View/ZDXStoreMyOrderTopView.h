//
//  ZDXStoreMyOrderTopView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^orderTopBlock)(NSInteger tag);

@interface ZDXStoreMyOrderTopView : UIView

-(instancetype)initWithTopViewFrame:(CGRect)frame titleName:(NSArray *)titles;

@property (copy, nonatomic) orderTopBlock block;

-(void)selectedWithIndex:(NSInteger)index;
@end
