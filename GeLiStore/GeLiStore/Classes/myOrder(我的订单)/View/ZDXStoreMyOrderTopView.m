//
//  ZDXStoreMyOrderTopView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMyOrderTopView.h"
#import "ZDXComnous.h"

@interface ZDXStoreMyOrderTopView ()

@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSMutableArray *buttons;

@property (strong, nonatomic) UIButton *selectedBtn;
@end

@implementation ZDXStoreMyOrderTopView

-(NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(instancetype)initWithTopViewFrame:(CGRect)frame titleName:(NSArray *)titles{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        topLineView.backgroundColor = colorWithString(@"#cdcdcd");
        [self addSubview:topLineView];
        
        UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH, 1)];
        bottomLineView.backgroundColor = colorWithString(@"#cdcdcd");
        [self addSubview:bottomLineView];
        
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height - 1;
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
            [titleBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
            [titleBtn setTitleColor:colorWithString(@"#e63944") forState:UIControlStateDisabled];
            if (isPhone6) {
                titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }else{
                titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }
            titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            titleBtn.tag = i;
            [titleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:titleBtn];
            [self addSubview:titleBtn];
            if (i == 0) {
                CGFloat H = 2;
                CGFloat Y = CGRectGetMaxY(titleBtn.frame) - 1;
    
                [titleBtn.titleLabel sizeToFit];
                self.lineView = [[UIView alloc] init];
                self.lineView.backgroundColor = colorWithString(@"#e63944");
                self.lineView.height = H;
                self.lineView.width = titleBtn.width;
                self.lineView.y = Y;
                [self addSubview:self.lineView];
            }
        }
    }
    
    return self;
}

-(void)clickBtn:(UIButton *)button{
    
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    if (self.block) {
        self.block(button.tag);
    }
    
    [self scrolling:button.tag];
}

-(void)scrolling:(NSInteger)tag{
    UIButton *btn = self.buttons[tag];
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.centerX = btn.centerX;
    }];
}


-(void)selectedWithIndex:(NSInteger)index{
    UIButton *btn = self.buttons[index];
    [self clickBtn:btn];
}
@end
