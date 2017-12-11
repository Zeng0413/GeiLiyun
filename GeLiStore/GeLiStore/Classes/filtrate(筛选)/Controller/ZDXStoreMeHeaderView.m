//
//  ZDXStoreMeHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeHeaderView.h"
#import "ZDXComnous.h"
#import "ZDXStoreClassifyView.h"
@interface ZDXStoreMeHeaderView ()

@property (weak, nonatomic) UIButton *settingBtn;

@property (weak, nonatomic) ZDXStoreClassifyView *view;

@property (weak, nonatomic) UIButton *headerBtn;
@end

@implementation ZDXStoreMeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.frame];
    backImage.image = [UIImage imageNamed:@"头像背景"];
    [self addSubview:backImage];
    
    UIButton *settingBtn = [[UIButton alloc] init];
    [settingBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingBtn];
    self.settingBtn = settingBtn;
    
    ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
    [view setupUI];
    view.label.textColor = colorWithString(@"#ffffff");
    view.imageView.image = [UIImage imageNamed:@"头像"];
    view.titleStr = @"";
    view.imageToView = 25;
    view.imageWH = 50;
    view.labelToImage = 15;
    view.labelH = 15;
    
    view.imageView.layer.masksToBounds = YES;
    view.imageView.layer.cornerRadius = 25;
    [self addSubview:view];
    self.view = view;
    
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [headerBtn addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headerBtn];
    self.headerBtn = headerBtn;
}

-(void)setUserModel:(ZDXStoreUserModel *)userModel{
    _userModel = userModel;
    if (userModel) {
        self.view.imageStr = userModel.userPhoto;
        self.view.titleStr = userModel.userName;
    }else{
        self.view.imageView.image = [UIImage imageNamed:@"头像"];
        self.view.titleStr = @"立即登录";
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(self.height - 15));
    }];
    
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

-(void)settingBtnClick{
    if ([self.delegate respondsToSelector:@selector(settingClick)]) {
        [self.delegate settingClick];
    }
}

-(void)headerClick{
    if ([self.delegate respondsToSelector:@selector(headerViewHeaderClick)]) {
        [self.delegate headerViewHeaderClick];
    }
}

@end
