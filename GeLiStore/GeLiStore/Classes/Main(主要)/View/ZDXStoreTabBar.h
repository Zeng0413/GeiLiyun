//
//  ZDXStoreTabBar.h
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDXStoreTabBarDelegate <NSObject>

-(void)selectedTabBarIndex:(NSInteger)index;

@end
@interface ZDXStoreTabBar : UIView

@property (weak, nonatomic) id<ZDXStoreTabBarDelegate> delegate;

@end
