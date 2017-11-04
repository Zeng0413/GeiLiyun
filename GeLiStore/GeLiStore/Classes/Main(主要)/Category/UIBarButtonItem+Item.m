//
//  UIBarButtonItem+Item.m

//
//  Created by apple on 2016-1-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIBarButtonItem+Item.h"
#import "UIView+Frame.h"
@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
    [btn sizeToFit];

//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.width = 100;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
////    返回文字
//    UILabel *backLabel = [[UILabel alloc] init];
//    [btn addSubview:backLabel];
//    backLabel.text = @"返回";
//    backLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
//    backLabel.frame = CGRectMake(btn.frame.origin.x + 10, btn.frame.origin.y - 3, 40, 20);
//    backLabel.textColor = [UIColor whiteColor];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
