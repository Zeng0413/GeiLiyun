//
//  ZDXStorePayTypePushView.h
//  GeLiStore
//
//  Created by user99 on 2017/12/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDXStorePayTypePushViewDelegate <NSObject>

-(void)hidePayTypePushView;

-(void)clickPayType:(NSInteger)type;
@end

@interface ZDXStorePayTypePushView : UIView

+(instancetype)payTypePushView;

@property (weak, nonatomic) id<ZDXStorePayTypePushViewDelegate> delegate;

@property (assign, nonatomic) NSInteger payPrice;
@end
