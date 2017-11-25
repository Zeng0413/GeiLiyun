//
//  ZDXStoreFooterView.m
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFooterView.h"
#import "ZDXComnous.h"
#import "ZDXStoreClassifyView.h"

@interface ZDXStoreFooterView ()

@property (strong, nonatomic) ZDXStoreClassifyView *classifyView;
@property (assign, nonatomic) BOOL isSelected;
@end

@implementation ZDXStoreFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIView *rightView = [[UIView alloc] init];
    rightView.width = SCREEN_WIDTH * 3 / 5;
    rightView.height = self.height;
    rightView.x = SCREEN_WIDTH - rightView.width;
    rightView.y = 0;
    [self addSubview:rightView];
    
    UIButton *addShopCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rightView.width / 2, self.height)];
    [addShopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShopCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addShopCarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    addShopCarBtn.backgroundColor = colorWithString(@"#ffa810");
    [addShopCarBtn addTarget:self action:@selector(addShopcarClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:addShopCarBtn];
    
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(addShopCarBtn.width, 0, rightView.width / 2, self.height)];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buyBtn.backgroundColor = colorWithString(@"#f95865");
    [buyBtn addTarget:self action:@selector(buyGoodsClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:buyBtn];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.width = SCREEN_WIDTH * 2 / 5;
    leftView.height = self.height;
    leftView.x = 0;
    leftView.y = 0;
    [self addSubview:leftView];
    
    NSArray *arr = @[@"店铺",@"购物车",@"收藏"];
    
    for (int i = 0; i<arr.count; i++) {
        ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
        [view setupUI];
        view.label.textColor = colorWithString(@"#8a8a8a");
        
        if (i == arr.count - 1) {
            view.imageView.image = [UIImage imageNamed:@"收藏前"];
            self.classifyView = view;
        }else{
            view.imageView.image = [UIImage imageNamed:arr[i]];
        }
        view.titleStr = arr[i];
        view.imageToView = 7.0;
        view.imageWH = 20;
        view.labelToImage = 6;
        view.labelH = 9;
        
        
        CGFloat width = leftView.width / 3;
        CGFloat height = self.height;
        view.x = i * width;
        view.y = 0;
        view.width = width;
        view.height = height;
        [leftView addSubview:view];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, height);
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:btn];
    }
    
}

// 加入购物车
-(void)addShopcarClick{
    if ([self.delegate respondsToSelector:@selector(addShopcar)]) {
        [self.delegate addShopcar];
    }
}

// 立即购买
-(void)buyGoodsClick{
    if ([self.delegate respondsToSelector:@selector(buyGoods)]) {
        [self.delegate buyGoods];
    }
}

-(void)btnClick:(UIButton *)button{
    self.isSelected = !self.isSelected;
    if (button.tag == 3) {
        NSString *imageStr = self.isSelected ? @"收藏后" : @"收藏前";
        self.classifyView.imageView.image = [UIImage imageNamed:imageStr];
    }
}
@end
