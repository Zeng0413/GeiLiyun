//
//  ZDXStoreShopCarBottomView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarBottomView.h"
#import "ZDXComnous.h"
@interface ZDXStoreShopCarBottomView ()

@property (nonatomic, strong) UIButton *allSelectButton; //选择按钮
@property (nonatomic, strong) UILabel *totalPriceLable;  //总共价格
@property (nonatomic, strong) UIButton *settleButton;    //结算按钮
@property (nonatomic, strong) UIButton *starButton;      //收藏按钮
@property (nonatomic, strong) UIButton *deleteButton;    //删除按钮
@property (nonatomic, strong) UIView *separateLine;      //线

@end

@implementation ZDXStoreShopCarBottomView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}


-(void)setupView{
    [self addSubview:self.allSelectButton];
    [self addSubview:self.totalPriceLable];
    [self renderWithTotalPrice:@"￥0"];
    [self addSubview:self.settleButton];
    [self addSubview:self.starButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.separateLine];
}

// 设置价格字体
-(void)renderWithTotalPrice:(NSString *)totalPrice{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.totalPriceLable.text];
    [attrString addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#e93644"]} range:[self.totalPriceLable.text rangeOfString:totalPrice]];
    self.totalPriceLable.attributedText = attrString;
    self.totalPriceLable.textAlignment = NSTextAlignmentCenter;
}


-(void)changeShopCarBottomViewWithStatus:(BOOL)status{
    self.starButton.hidden = !status;
    self.deleteButton.hidden = !status;
    self.totalPriceLable.hidden = status;
}

-(void)setupShopCarBottomViewWithTotalPrice:(CGFloat)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected{
    self.allSelectButton.selected = isAllSelected;
    
    self.totalPriceLable.text = [NSString stringWithFormat:@"合计：￥%.2f",totalPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.2f", totalPrice]];
    
    [self.settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)", totalCount] forState:UIControlStateNormal];
    if (totalCount > 0) {
        self.settleButton.enabled = YES;
    }else{
        self.settleButton.enabled = NO;
    }
//    self.settleButton.enabled = totalCount && totalPrice;
    self.starButton.enabled = totalCount && totalPrice;
    self.deleteButton.enabled = totalCount && totalPrice;
    if (self.settleButton.isEnabled) { // 能点击结算按钮
        [self.settleButton setBackgroundColor:ZDXColor(255, 88, 104)];
        [self.deleteButton setBackgroundColor:[UIColor whiteColor]];
        [self.starButton setBackgroundColor:[UIColor whiteColor]];
    }else{
        [self.settleButton setBackgroundColor:ZDXColor(255, 130, 142)];
        [self.deleteButton setBackgroundColor:ZDXColor(180, 180, 180)];
        [self.starButton setBackgroundColor:ZDXColor(180, 180, 180)];
    }
}

#pragma mark - 控件初始化
-(UIButton *)allSelectButton{
    if (_allSelectButton == nil) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_allSelectButton setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
        [_allSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 19, 0, 0)];
        _allSelectButton.imageView.size = CGSizeMake(22, 22);
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)totalPriceLable {
    if (_totalPriceLable == nil){
        _totalPriceLable = [[UILabel alloc] init];
        _totalPriceLable.font = [UIFont systemFontOfSize:15];
        _totalPriceLable.textColor = [UIColor colorWithHexString:@"#464646"];
        _totalPriceLable.text = @"合计：￥0";
    }
    return _totalPriceLable;
}

- (UIButton *)settleButton {
    if (_settleButton == nil){
        _settleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _settleButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_settleButton setBackgroundColor:ZDXColor(255, 130, 142)];
        [_settleButton addTarget:self action:@selector(settleButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _settleButton.enabled = NO;
    }
    return _settleButton;
}

- (UIButton *)starButton {
    if (_starButton == nil){
        _starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_starButton setTitle:@"移入收藏" forState:UIControlStateNormal];
        [_starButton setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:UIControlStateNormal];
        _starButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_starButton setBackgroundColor:ZDXColor(180, 180, 180)];
        [_starButton addTarget:self action:@selector(starButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _starButton.enabled = NO;
        _starButton.hidden = YES;
    }
    return _starButton;
}


- (UIButton *)deleteButton {
    if (_deleteButton == nil){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexString:@"#464646"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_deleteButton setBackgroundColor:ZDXColor(180, 180, 180)];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIView *)separateLine {
    if (_separateLine == nil){
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _separateLine;
}

#pragma mark - 按钮点击事件

// 商品全选按钮
-(void)allSelectButtonAction{
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    
    if (self.shopcartBotttomViewAllSelectBlock) {
        self.shopcartBotttomViewAllSelectBlock(self.allSelectButton.isSelected);
    }
}


// 结算按钮
-(void)settleButtonAction{
    if (self.shopcartBotttomViewSettleBlock) {
        self.shopcartBotttomViewSettleBlock();
    }
}

// 收藏按钮
-(void)starButtonAction{
    if (self.shopcartBotttomViewStarBlock) {
        self.shopcartBotttomViewStarBlock();
    }
}


// 删除按钮
-(void)deleteButtonAction{
    if (self.shopcartBotttomViewDeleteBlock) {
        self.shopcartBotttomViewDeleteBlock();
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(4);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(75, 30));
    }];
    
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@93);
    }];
    
    [self.starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.deleteButton.mas_left);
        make.width.equalTo(@93);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@93);
    }];
    
    [self.totalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.allSelectButton.mas_right);
        make.right.equalTo(self.settleButton.mas_left).offset(-5);
    }];
    
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@1);
    }];
}







@end
