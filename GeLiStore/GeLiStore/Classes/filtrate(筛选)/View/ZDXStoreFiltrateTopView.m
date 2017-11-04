//
//  ZDXStoreFiltrateTopView.m
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltrateTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreTitleLeftImageRight.h"
@interface ZDXStoreFiltrateTopView ()

@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation ZDXStoreFiltrateTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *arr = @[@"所有",@"价格",@"抵扣",@"筛选"];
        NSInteger count = arr.count;
        for (int i = 0; i<count; i++) {
            CGFloat width = SCREEN_WIDTH / count;
            ZDXStoreTitleLeftImageRight *btn = [[ZDXStoreTitleLeftImageRight alloc] initWithFrame:CGRectMake(i * width, 0, width, self.height - 10)];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
            [btn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 1) {
                [btn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
            }
            
            if (i == 3) {
                [btn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
            }
        
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.width + 2.5, 0, -btn.titleLabel.width - 2.5);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.currentImage.size.width, 0, btn.currentImage.size.width);
            
            [self addSubview:btn];
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 10, SCREEN_WIDTH, 10)];
        view.backgroundColor = colorWithString(@"#f4f4f4");
        [self addSubview:view];
        
    }
    return self;
}

-(void)btnClick:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(selectedFiltrateType:)]) {
        [self.delegate selectedFiltrateType:button.titleLabel.text];
    }
}

@end
