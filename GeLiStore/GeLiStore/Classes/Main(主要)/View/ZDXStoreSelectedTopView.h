//
//  ZDXStoreSelectedTopView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDXStoreSelectedTopViewDelegate <NSObject>

-(void)selectedTopViewSelected:(NSInteger)type;

@end
@interface ZDXStoreSelectedTopView : UIView

@property (weak, nonatomic) id<ZDXStoreSelectedTopViewDelegate> delegate;

@property (strong, nonatomic) NSArray *list;

@property (strong, nonatomic) UIColor *btnDisableColor;
@end
