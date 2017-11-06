//
//  ZDXStoreMeHeaderView.h
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStoreMeHeaderViewDelegate <NSObject>

-(void)headerViewHeaderClick;

-(void)settingClick;

@end

@interface ZDXStoreMeHeaderView : UIView

@property (weak, nonatomic) id<ZDXStoreMeHeaderViewDelegate> delegate;

@end
