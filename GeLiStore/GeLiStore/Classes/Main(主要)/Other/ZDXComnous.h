//
//  ZDXComnous.h
//  GeLiStore
//
//  Created by user99 on 2017/10/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#ifndef ZDXComnous_h
#define ZDXComnous_h

#define hostUrl @"http://glys.wuliuhangjia.com/"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATE_HEIGHT [[UIApplication sharedApplication]statusBarFrame].size.height

// RGB颜色
#define ZDXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ZDXFont(f) [UIFont systemFontOfSize:(f)]

#define blackLabelColor colorWithString(@"262626")

// 随机色
#define ZDXRandomColor ZDXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 手机型号
#define isPhone6 SCREEN_HEIGHT > 568 ? YES : NO


#define colorWithString(s) [UIColor colorWithHexString:(s)]

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
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "ZDXStoreUserModelTool.h"

#import "XPathQuery.h"

#import "TFHpple.h"

#import "TFHppleElement.h"





#endif /* ZDXComnous_h */


