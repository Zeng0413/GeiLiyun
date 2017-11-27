//
//  ZDXStoreUserModel.m
//  GeLiStore
//
//  Created by user99 on 2017/11/27.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreUserModel.h"
#import <objc/runtime.h>

@implementation ZDXStoreUserModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *strName = [NSString stringWithUTF8String:name];
        
        // 利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}
@end
