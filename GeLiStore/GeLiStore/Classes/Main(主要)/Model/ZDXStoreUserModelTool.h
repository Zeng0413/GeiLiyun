//
//  ZDXStoreUserModelTool.h
//  GeLiStore
//
//  Created by user99 on 2017/11/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDXStoreUserModel.h"
@interface ZDXStoreUserModelTool : NSObject

/*
 存储账号信息
 */
+(void)saveUserModel:(ZDXStoreUserModel *)userModel;

/*
 返回账号信息
 */
+(ZDXStoreUserModel *)userModel;


/*
 删除账号信息
 */
+(void)deleteFile;

@end
