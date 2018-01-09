//
//  ZDXStoreGoodsAppraiseBottomView.m
//  GeLiStore
//
//  Created by user99 on 2018/1/8.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreGoodsAppraiseBottomView.h"
#import "ZDXComnous.h"
@implementation ZDXStoreGoodsAppraiseBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIButton *defaultBtn = [[UIButton alloc]init];
    defaultBtn.width = 22;
    defaultBtn.height = 22;
    defaultBtn.x = 10;
    defaultBtn.y = 20;
    
    [defaultBtn setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
    [defaultBtn setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
    [defaultBtn addTarget:self action:@selector(defaultAppraiseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:defaultBtn];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"匿名评价";
    title.textColor = colorWithString(@"#262626");
    title.font = [UIFont systemFontOfSize:13];
    
    title.width = 80;
    title.height = 13;
    title.x = CGRectGetMaxX(defaultBtn.frame) + 15;
    title.centerY = defaultBtn.centerY;
    
    [self addSubview:title];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.x = 0;
    bottomBtn.width = SCREEN_WIDTH;
    bottomBtn.height = 44;
    bottomBtn.y = CGRectGetMaxY(defaultBtn.frame) + 20;
    [bottomBtn setBackgroundColor:colorWithString(@"#f95865")];
    [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomBtn];
}


-(void)defaultAppraiseClick:(UIButton *)button{
    button.selected = !button.isSelected;

}

-(void)submit{
    if ([self.delegate respondsToSelector:@selector(submitAppraiseClick)]) {
        [self.delegate submitAppraiseClick];
    }
}
@end
