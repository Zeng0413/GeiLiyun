//
//  ZDXStoreShopCarCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopCarCell.h"
#import "ZDXStoreShopCarCountView.h"
#import "ZDXComnous.h"
@interface ZDXStoreShopCarCell ()

@property (strong, nonatomic) UIButton *productSelectedBtn;
@property (strong, nonatomic) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;
@property (nonatomic, strong) UILabel *productSizeLable;
@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) ZDXStoreShopCarCountView *shopcartCountView;
@property (nonatomic, strong) UILabel *productStockLable;
@property (nonatomic, strong) UIView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;

@property (strong, nonatomic) UILabel *count;
@end

@implementation ZDXStoreShopCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectedBtn];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productSizeLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.shopcartCountView];
    [self.shopcartBgView addSubview:self.productStockLable];
    [self.shopcartBgView addSubview:self.count];
    
    self.count.hidden = NO;
    self.shopcartCountView.hidden = YES;
    [self.shopcartBgView addSubview:self.topLineView];
}

-(void)setupShopCarCellWithProductURL:(NSString *)productURL
                          productName:(NSString *)productName
                          productSize:(NSString *)productSize
                         productPrice:(CGFloat)productPrice
                         productCount:(NSInteger)productCount
                         productStock:(NSInteger)productStock
                      productSelected:(BOOL)productSelected{
//    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
//    [self.productImageView sd_setImageWithURL:encodingURL];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,productURL]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    self.productNameLable.text = productName;
    self.productSizeLable.text = productSize;
    self.productPriceLable.text = [NSString stringWithFormat:@"￥%.2f", productPrice];
    self.productSelectedBtn.selected = productSelected;
    self.count.text = [NSString stringWithFormat:@"X %ld",productCount];
    [self.shopcartCountView setupShopCarCountViewWithProductCount:productCount productStock:productStock];
    self.productStockLable.text = [NSString stringWithFormat:@"库存:%ld", productStock];
}

#pragma mark - 初始化控件
- (UIButton *)productSelectedBtn
{
    if(_productSelectedBtn == nil)
    {
        _productSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectedBtn setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
        [_productSelectedBtn setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
        [_productSelectedBtn addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectedBtn;
}

- (void)productSelectButtonAction {
    self.productSelectedBtn.selected = !self.productSelectedBtn.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectedBtn.selected);
    }
}


- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.numberOfLines = 2;
        _productNameLable.font = [UIFont systemFontOfSize:14];
        _productNameLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _productNameLable;
}

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont systemFontOfSize:13];
        _productSizeLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productSizeLable;
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:14];
        _productPriceLable.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _productPriceLable;
}

- (ZDXStoreShopCarCountView *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[ZDXStoreShopCarCountView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.shopcartCountViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock(count);
            }
        };
    }
    return _shopcartCountView;
}

- (UILabel *)productStockLable {
    if (_productStockLable == nil){
        _productStockLable = [[UILabel alloc] init];
        _productStockLable.font = [UIFont systemFontOfSize:13];
        _productStockLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productStockLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

-(UILabel *)count{
    if (_count == nil) {
        _count = [[UILabel alloc] init];
        _count.textColor = [UIColor colorWithHexString:@"#464646"];
        _count.font = [UIFont systemFontOfSize:12];
    }
    return _count;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.productSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(4);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productSelectedBtn.mas_right).offset(19);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(100, 104));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(12);
        make.top.equalTo(self.shopcartBgView).offset(33);
        make.right.equalTo(self.shopcartBgView).offset(-5);
    }];
    
    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(12);
        make.top.equalTo(self.productNameLable.mas_bottom);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(12);
        make.top.equalTo(self.productSizeLable.mas_bottom).offset(5);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    
    
    [self.shopcartCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.centerY.equalTo(self.productPriceLable);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.centerY.equalTo(self.shopcartCountView);
        make.size.mas_equalTo(CGSizeMake(30, 12));
    }];
    
    [self.productStockLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartCountView.mas_right).offset(20);
        make.centerY.equalTo(self.shopcartCountView);
    }];
    
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView);
        make.top.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@1);
    }];
}

-(void)setStatus:(BOOL)status{
    _status = status;
    
    self.count.hidden = status;
    self.shopcartCountView.hidden = !status;
    
}

@end
