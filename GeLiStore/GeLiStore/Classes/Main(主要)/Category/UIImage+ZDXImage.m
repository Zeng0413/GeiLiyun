//
//  UIImage+ZDXImage.m
//  WLReceive
//
//  Created by zdx on 2017/9/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIImage+ZDXImage.h"

@implementation UIImage (ZDXImage)
// 封装类方法掉用：

//  颜色转换为背景图片

+ (UIImage *)imageWithColor:(UIColor *)color

{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}
@end
