//
//  ZDXStoreAddressRemakeCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreAddressRemakeCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreAddressRemakeCell ()<UITextViewDelegate>

@end

@implementation ZDXStoreAddressRemakeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView = [[ZDXTextView alloc] init];
    self.textView.y = 22;
    self.textView.width =SCREEN_WIDTH - 20;
    self.textView.x = 10;
    self.textView.height = 126;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.delegate = self;
    self.textView.showsVerticalScrollIndicator = NO;
    // 垂直方向上永远可以退拽
    self.textView.alwaysBounceVertical = YES;
    self.textView.placeholder = @"详细地址";
    self.textView.placeholderColor = [UIColor colorWithHexString:@"#8a8a8a"];
    [self.contentView addSubview:self.textView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
}


#pragma mark - UITextView Delegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.contentView endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
