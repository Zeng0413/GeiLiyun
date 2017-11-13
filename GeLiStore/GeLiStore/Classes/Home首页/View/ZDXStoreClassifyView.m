//
//  ZDXStoreClassifyView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreClassifyView.h"
#import "ZDXComnous.h"
@interface ZDXStoreClassifyView ()

@end

@implementation ZDXStoreClassifyView

+(instancetype)initWithClassifyView{
    ZDXStoreClassifyView *view = [[self alloc] init];
    return view;
}

-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,imageStr]] placeholderImage:[UIImage imageNamed:@"商品分类"]];
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.label.text = titleStr;
}

-(void)setupUI{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.label = titleLabel;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.imageToView);
        make.size.mas_equalTo(CGSizeMake(self.imageWH, self.imageWH));
        make.centerX.equalTo(self);
    }];
    
    self.label.font = [UIFont systemFontOfSize:self.labelH];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(self.labelToImage);
        make.height.equalTo(@(self.labelH));
    }];
}

@end
