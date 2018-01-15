//
//  WLRPushView4.h
//  WLReceive
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLRPushView4Delegate <NSObject>

@optional - (void) viewPopToRootVC;

@end

@interface WLRPushView4 : UIView

+ (instancetype)view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconX;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (nonatomic,weak) id<WLRPushView4Delegate> delegate;
@end
