//
//  ZDXStoreFiltrateTopView.h
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDXStoreFiltrateTopViewDelegate <NSObject>

-(void)selectedFiltrateType:(NSString *)type;

@end

@interface ZDXStoreFiltrateTopView : UIView

@property (weak, nonatomic) id<ZDXStoreFiltrateTopViewDelegate> delegate;

@end
