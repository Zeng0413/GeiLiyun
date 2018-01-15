//
//  ZDXStoreAppraiseScoreCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreAppraiseScoreCell.h"
#import "UIColor+ColorChange.h"

@interface ZDXStoreAppraiseScoreCell ()
@property (weak, nonatomic) IBOutlet UIView *containView;

@end
@implementation ZDXStoreAppraiseScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
}


- (IBAction)click:(UIButton *)sender {
    for (UIButton *startBtn in self.containView.subviews) {
        if (startBtn.tag >0 && startBtn.tag<=sender.tag) {
            [startBtn setImage:[UIImage imageNamed:@"星星评分后"] forState:UIControlStateNormal];
        }
        if (startBtn.tag > sender.tag) {
            [startBtn setImage:[UIImage imageNamed:@"星星评分前"] forState:UIControlStateNormal];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(goodsScoreTypeCell:appraiseScore:)]) {
        [self.delegate goodsScoreTypeCell:self appraiseScore:sender.tag];
    }
}


@end
