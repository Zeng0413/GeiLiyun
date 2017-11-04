//
//  NSString+Extension.m
//  ZDXweibo
//
//  Created by zdx on 2017/5/9.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font{
    
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
