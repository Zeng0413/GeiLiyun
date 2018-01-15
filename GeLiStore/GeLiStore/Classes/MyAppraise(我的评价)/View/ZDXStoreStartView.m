//
//  ZDXStoreStartView.m
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreStartView.h"
#import "ZDXComnous.h"

@implementation ZDXStoreStartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    int border = 4;
    CGFloat btnWH = 10;
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.width = btnWH;
        btn.height = btnWH;
        btn.x = i * (btnWH + border);
        btn.y = 0;
        [btn setImage:[UIImage imageNamed:@"星星评分前"] forState:UIControlStateNormal];
        btn.tag = i + 1;
        if (i == 4) {
            self.ViewW = CGRectGetMaxX(btn.frame);
        }
        [self addSubview:btn];
    }
}


-(void)setScore:(NSInteger)score{
    _score = score;
    for (UIButton *startBtn in self.subviews) {
        if (startBtn.tag<=score) {
            [startBtn setImage:[UIImage imageNamed:@"星星评分后"] forState:UIControlStateNormal];
        }
    }
    
}

@end
