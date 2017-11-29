//
//  ZDXTextView.m
//  ZDXweibo
//
//  Created by zdx on 2017/5/15.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "ZDXTextView.h"

@implementation ZDXTextView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textViewDidChange{
    //重绘
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) return;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor : [UIColor grayColor];
    //画文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attr];
    
    CGRect placeholderRect = CGRectMake(5, 8, rect.size.width - 10, rect.size.height - 16);
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    [self setNeedsDisplay];
}
@end
