//
//  ZDXStorePhotosView.h
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDXStorePhotosView : UIView

@property (strong, nonatomic) NSArray *photos;

+(CGSize)sizeWithCount:(NSInteger)count;

@end
