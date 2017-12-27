//
//  ZDXStorePayTypePushView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStorePayTypePushView.h"
#import "ZDXComnous.h"

@implementation ZDXStorePayTypePushView


+(instancetype)payTypePushView{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZDXStorePayTypePushView" owner:nil options:nil] firstObject];
}

@end
