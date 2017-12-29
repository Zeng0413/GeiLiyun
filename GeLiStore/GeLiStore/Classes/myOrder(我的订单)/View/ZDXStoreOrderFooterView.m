//
//  ZDXStoreOrderFooterView.m
//  GeLiStore
//
//  Created by user99 on 2017/12/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderFooterView.h"
#import "ZDXComnous.h"

@interface ZDXStoreOrderFooterView ()
@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@end

@implementation ZDXStoreOrderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 7.0;
    self.btn1.layer.borderColor = colorWithString(@"#959595").CGColor;
    self.btn1.layer.borderWidth = 1.0;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.btn1 setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
}

@end
