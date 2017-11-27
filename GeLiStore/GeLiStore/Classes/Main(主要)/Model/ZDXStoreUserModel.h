//
//  ZDXStoreUserModel.h
//  GeLiStore
//
//  Created by user99 on 2017/11/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDXStoreUserModel : NSObject<NSCoding>

@property (assign, nonatomic) NSInteger userId; // 用户id
@property (assign, nonatomic) NSInteger dataFlag;
@property (assign, nonatomic) NSInteger rankId;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *loginName;
@property (copy, nonatomic) NSString *userMoney;
@property (copy, nonatomic) NSString *lastIP;
@property (copy, nonatomic) NSString *userrankImg;
@property (copy, nonatomic) NSString *payPwd;
@property (copy, nonatomic) NSString *qqOpenId;
@property (assign, nonatomic) NSInteger userType;
@property (copy, nonatomic) NSString *loginPwd;
@property (copy, nonatomic) NSString *userQQ;
@property (copy, nonatomic) NSString *rankName;
@property (copy, nonatomic) NSString *trueName;

@property (assign, nonatomic) NSInteger userScore;
@property (assign, nonatomic) NSInteger userSex;
@property (assign, nonatomic) NSInteger userStatus;
@property (assign, nonatomic) NSInteger userFrom;

@property (copy, nonatomic) NSString *userPhone;
@property (copy, nonatomic) NSString *userPhoto;
@property (copy, nonatomic) NSString *wxOpenId;
@property (copy, nonatomic) NSString *userEmail;

@end
