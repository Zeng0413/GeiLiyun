//
//  ZDXComnous.h
//  GeLiStore
//
//  Created by user99 on 2017/10/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#ifndef ZDXComnous_h
#define ZDXComnous_h

#define hostUrl @"http://loc.geliyunshang.com/"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define ZDXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define ZDXRandomColor ZDXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import "AFNetWorking.h"
#import "UIView+Frame.h"
#import "UIColor+ColorChange.h"
#import "NSData+Extension.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "UIImage+ZDXImage.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIBarButtonItem+Item.h"
#import "SDCycleScrollView.h"


#define colorWithString(s) [UIColor colorWithHexString:(s)]
#endif /* ZDXComnous_h */


