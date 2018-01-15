//
//  WLRPushView1.h
//  WLReceive
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blo) (NSString *titleParam);

@interface WLRPushView1 : UIView

@property (nonatomic,copy) blo block;

- (instancetype) initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
