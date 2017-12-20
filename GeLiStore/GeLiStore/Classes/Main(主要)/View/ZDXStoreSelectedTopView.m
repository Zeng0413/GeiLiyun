//
//  ZDXStoreSelectedTopView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSelectedTopView.h"
#import "ZDXComnous.h"

@interface ZDXStoreSelectedTopView ()

@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation ZDXStoreSelectedTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setList:(NSArray *)list{
    _list = list;
    
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topLineView.backgroundColor = colorWithString(@"#cdcdcd");
    [self addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH, 1)];
    bottomLineView.backgroundColor = colorWithString(@"#cdcdcd");
    [self addSubview:bottomLineView];
    
    NSInteger count = list.count;
    CGFloat btnW = SCREEN_WIDTH / count;
    
    for (int i = 0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [btn setTitleColor:colorWithString(@"#e63944") forState:UIControlStateDisabled];
        
        [btn setTitle:list[i] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.x = i * btnW;
        btn.y = 1;
        btn.width = SCREEN_WIDTH / count;
        btn.height = self.height - 2;
        [self addSubview:btn];
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}


-(void)btnClick:(UIButton *)button{
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(selectedTopViewSelected:)]) {
        [self.delegate selectedTopViewSelected:button.tag];
    }
    
}
@end
