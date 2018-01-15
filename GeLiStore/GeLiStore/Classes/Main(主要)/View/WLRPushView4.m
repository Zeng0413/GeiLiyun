//
//  WLRPushView4.m
//  WLReceive
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WLRPushView4.h"
#import "ZDXComnous.h"
@implementation WLRPushView4

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6];
    self.iconX.constant = SCREEN_WIDTH/2 - 70 - 45/2;
    
    _timer =[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(action) userInfo:nil repeats:YES];
    //    [timer ];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
    _count = 0;
}


- (void) action
{
    _count ++;
    if (_count ==1) {
        [_timer invalidate];
        if ([_delegate respondsToSelector:@selector(viewPopToRootVC)]) {
            [_delegate viewPopToRootVC];
        };
        [self removeFromSuperview];
    }
    
}
+ (instancetype)view
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WLRPushView4" owner:nil options:nil] firstObject];
}

@end
