//
//  ZDXStoreCollectionTopView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCollectionTopView.h"
#import "ZDXComnous.h"

@interface ZDXStoreCollectionTopView ()

@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation ZDXStoreCollectionTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topLineView.backgroundColor = colorWithString(@"#cdcdcd");
    [self addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH, 1)];
    bottomLineView.backgroundColor = colorWithString(@"#cdcdcd");
    [self addSubview:bottomLineView];
    
    NSArray *arr = @[@"商品",@"店铺",@"共享/二手特卖"];
    CGFloat btnW = SCREEN_WIDTH / 3;
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [btn setTitleColor:colorWithString(@"#e63944") forState:UIControlStateDisabled];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.x = i * btnW;
        btn.y = 1;
        btn.width = SCREEN_WIDTH / 3;
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
    
    
}

@end
