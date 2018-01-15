//
//  ZDXStoreAppraiseRemarkCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/5.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreAppraiseRemarkCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreAppraiseRemarkCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation ZDXStoreAppraiseRemarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textView = [[ZDXTextView alloc] init];
    self.textView.y = 35;
    self.textView.width = SCREEN_WIDTH - 20;
    self.textView.x = 10;
    self.textView.height = self.textView.width / (355 / 83);
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.delegate = self;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.masksToBounds = YES;
    // 垂直方向上永远可以退拽
    self.textView.alwaysBounceVertical = YES;
    self.textView.placeholder = @"亲，您的评价对其他买家很有帮助";
    self.textView.placeholderColor = [UIColor colorWithHexString:@"#8a8a8a"];
    [self.contentView addSubview:self.textView];
    
    self.cellH = CGRectGetMaxY(self.textView.frame);
}

- (IBAction)startBtnClick:(UIButton *)sender {
    for (UIButton *startBtn in self.containView.subviews) {
        if (startBtn.tag >0 && startBtn.tag<=sender.tag) {
            [startBtn setImage:[UIImage imageNamed:@"星星评分后"] forState:UIControlStateNormal];
        }
        if (startBtn.tag > sender.tag) {
            [startBtn setImage:[UIImage imageNamed:@"星星评分前"] forState:UIControlStateNormal];
        }
    }
    
    if (self.block) {
        self.block(sender.tag);
    }
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

