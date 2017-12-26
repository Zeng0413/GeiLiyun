//
//  ZDXStoreCommdityCommentCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdityCommentCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreCommdityCommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *commentScore;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIButton *lookAllCommentBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation ZDXStoreCommdityCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentCount.textColor = colorWithString(@"#444444");
    self.commentScore.textColor = colorWithString(@"#e93644");
    self.username.textColor = colorWithString(@"#444444");
    self.comment.textColor = colorWithString(@"#444444");
    
    self.lookAllCommentBtn.layer.masksToBounds = YES;
    self.lookAllCommentBtn.layer.borderColor = colorWithString(@"#e93644").CGColor;
    self.lookAllCommentBtn.layer.borderWidth = 1.0;
    self.lookAllCommentBtn.layer.cornerRadius = 4.0;
    [self.lookAllCommentBtn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateNormal];
    self.lookAllCommentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.lineView.backgroundColor = colorWithString(@"#f4f4f4");
}

- (IBAction)lookCommentClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedCommentClick)]) {
        [self.delegate selectedCommentClick];
    }
}


@end
