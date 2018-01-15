//
//  ZDXStoreAppraiseModel.h
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreAppraiseModel : NSObject

@property (assign, nonatomic) NSInteger goodsId;
@property (assign, nonatomic) NSInteger goodsScore;
@property (assign, nonatomic) NSInteger serviceScore;
@property (assign, nonatomic) NSInteger timeScore;
@property (copy, nonatomic) NSString *goodsImg;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *images;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *orderNo;
@property (copy, nonatomic) NSString *userPhoto;
@property (assign, nonatomic) NSArray *imagesArray;

@property (copy, nonatomic) NSString *createTime;
@end
