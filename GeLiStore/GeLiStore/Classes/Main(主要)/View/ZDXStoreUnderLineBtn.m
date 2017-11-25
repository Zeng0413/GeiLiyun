//
//  ZDXStoreUnderLineBtn.m
//  GeLiStore
//
//  Created by user99 on 2017/11/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreUnderLineBtn.h"

@implementation ZDXStoreUnderLineBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setColor:(UIColor *)color{
    lineColor = [color copy];
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat descender = self.titleLabel.font.descender;
    if ([lineColor isKindOfClass:[UIColor class]]) {
        CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 3);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 3);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}






@end
