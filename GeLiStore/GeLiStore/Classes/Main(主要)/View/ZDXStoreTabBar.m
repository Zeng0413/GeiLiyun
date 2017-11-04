//
//  ZDXStoreTabBar.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTabBar.h"
#import "ZDXStoreTabBarButton.h"
#import "ZDXComnous.h"

@interface ZDXStoreTabBar ()

@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) UIButton *selectedItem;

@end

@implementation ZDXStoreTabBar

-(NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"homeTabBar",@"shareTabBar",@"recyclingTabBar",@"shopingCarTabBar",@"meTabBar"];
    }
    return _dataList;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSInteger count = self.dataList.count;
        NSArray *titleArr = @[@"电器商城",@"共享",@"回收换新",@"购物车",@"我的"];
        for (int i = 0; i<count; i++) {
            ZDXStoreTabBarButton *item = [ZDXStoreTabBarButton buttonWithType:UIButtonTypeCustom];
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_s"]] forState:UIControlStateSelected];
            [item setTitle:titleArr[i] forState:UIControlStateNormal];
            
            // 不让图片在高亮下改变
            //            item.adjustsImageWhenHighlighted = NO;
            
            item.tag = i + 1;
            if (i == 0) {
//                [item setTitle:@"" forState:UIControlStateSelected];
                [self clickItem:item];
            }
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:item];
        }
        
    }
    return self;
}

-(void)clickItem:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(selectedTabBarIndex:)]) {
        [self.delegate selectedTabBarIndex:button.tag - 1];
    }
    self.selectedItem.selected = NO;
    button.selected = YES;
    self.selectedItem = button;
    
//    if (button.tag == 1) {
//        button.imageView.frame = CGRectZero;
//        // 设置动画
//        [UIView animateWithDuration:0.2 animations:^{
//            // 将button扩大1.2倍
//            button.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 animations:^{
//                // 恢复原始状态
//                button.transform = CGAffineTransformIdentity;
//            }];
//        }];
//    }

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width / self.dataList.count;
    
    for (NSInteger i = 0; i<self.subviews.count; i++) {
        UIView *btn = self.subviews[i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag - 1) * width, 0, width, self.frame.size.height);
        }
    }
    
}
@end
