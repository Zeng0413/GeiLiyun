//
//  ZDXStoreUserModelTool.m
//  GeLiStore
//
//  Created by user99 on 2017/11/27.
//  Copyright © 2017年 user99. All rights reserved.
//


#define accountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userModel.plist"]

#import "ZDXStoreUserModelTool.h"

@implementation ZDXStoreUserModelTool

/*
 存储账号信息
 */

+(void)saveUserModel:(ZDXStoreUserModel *)userModel{
    [NSKeyedArchiver archiveRootObject:userModel toFile:accountPath];
}

+(ZDXStoreUserModel *)userModel{
    ZDXStoreUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    return model;
}

+(void)deleteFile{
    // 创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 文件目录
    NSString *filePath = accountPath;
    // 获取文件目录
    if (!filePath) {
        // 如果文件目录设置有空，默认删除Cache目录下的文件
        filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    }
    
//    // 拼接文件名
//    NSString *uniquePath = [filePath stringByAppendingPathComponent:@"userModel.plist"];
    
    // 文件是否存在
    BOOL blHave = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    // 进行逻辑判断
    if (!blHave) {
        NSLog(@"文件不存在");
        return;
    }else{
        // 文件是否被删除
        BOOL blDele = [fileManager removeItemAtPath:filePath error:nil];
        
        if (blDele) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
    
    
}

@end
