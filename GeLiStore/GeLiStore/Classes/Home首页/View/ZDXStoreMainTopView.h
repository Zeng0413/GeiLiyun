//
//  ZDXStoreMainTopView.h
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreMainTopViewDelegate <NSObject>

-(void)chooseCity;

@end

@interface ZDXStoreMainTopView : UIView

@property (weak, nonatomic) id<ZDXStoreMainTopViewDelegate> delegate;

@end
