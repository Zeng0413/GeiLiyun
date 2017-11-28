//
//  ZDXStoreShopCarHearView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarHearView.h"
#import "ZDXComnous.h"

@interface ZDXStoreShopCarHearView ()

@property (nonatomic, strong) UIView *shopcartHeaderBgView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *brandLable;
@property (strong, nonatomic) UIImageView *imageView;


@end

@implementation ZDXStoreShopCarHearView

-(UIView *)shopcartHeaderBgView{
    if (_shopcartHeaderBgView == nil) {
        _shopcartHeaderBgView = [[UIView alloc] init];
        _shopcartHeaderBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartHeaderBgView;
}


-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"右箭头"];
    }
    return _imageView;
}

-(UIButton *)allSelectButton{
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)brandLable {
    if (_brandLable == nil){
        _brandLable = [[UILabel alloc] init];
        _brandLable.font = [UIFont systemFontOfSize:16];
        _brandLable.textColor = [UIColor colorWithHexString:@"#262626"];
    }
    return _brandLable;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    [self addSubview:self.shopcartHeaderBgView];
    
    [self.shopcartHeaderBgView addSubview:self.allSelectButton];
    [self.shopcartHeaderBgView addSubview:self.brandLable];
    [self.shopcartHeaderBgView addSubview:self.imageView];
}

-(void)setupShopCarHeaderViewWithBrandName:(NSString *)brandName brandSelect:(BOOL)brandSelected{
    self.allSelectButton.selected = brandSelected;
    self.brandLable.text = brandName;
}

// 选中按钮点击
-(void)allSelectButtonAction{
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    if (self.shopCarHeaderViewBlock) {
        self.shopCarHeaderViewBlock(self.allSelectButton.selected);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.shopcartHeaderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartHeaderBgView).offset(4);
        make.centerY.equalTo(self.shopcartHeaderBgView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.brandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allSelectButton.mas_right).offset(18);
        make.top.bottom.equalTo(self.shopcartHeaderBgView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.brandLable.mas_right).offset(16);
        make.centerY.equalTo(self.shopcartHeaderBgView);
        make.size.mas_equalTo(CGSizeMake(10, 13));
    }];
}
@end
