//
//  ZDXStoreMyAppraiseCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreMyAppraiseCell.h"
#import "ZDXComnous.h"
#import "ZDXStorePhotosView.h"
#import "ZDXStoreStartView.h"

@interface ZDXStoreMyAppraiseCell ()

// 用户头像
@property (weak, nonatomic) UIImageView *headerImg;
// 用户名称
@property (weak, nonatomic) UILabel *userName;
// 评星View
@property (weak, nonatomic) ZDXStoreStartView *appraiseStartView;
// 评价时间
@property (weak, nonatomic) UILabel *time;
// 评价内容
@property (weak, nonatomic) UILabel *content;
// 图片
@property (weak, nonatomic) ZDXStorePhotosView *appraisePhotos;
// 商品图片
@property (weak, nonatomic) UIImageView *goodsImg;
// 商品名
@property (weak, nonatomic) UILabel *goodsName;
// 商品规格
@property (weak, nonatomic) UILabel *goodsDetail;
// 商品价格
@property (weak, nonatomic) UILabel *goodsPrice;



@end

@implementation ZDXStoreMyAppraiseCell

+(instancetype)cellWithAppraiseTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    ZDXStoreMyAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZDXStoreMyAppraiseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = colorWithString(@"#f4f4f4");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化界面
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    // 用户头像
    UIImageView *headerImg = [[UIImageView alloc] init];
    [self.contentView addSubview:headerImg];
    self.headerImg = headerImg;
    
    // 用户名称
    UILabel *userName = [[UILabel alloc] init];
    userName.textColor = colorWithString(@"#444444");
//    userName.font =
    [self.contentView addSubview:userName];
    self.userName = userName;
    
    // 评星View
    ZDXStoreStartView *appraiseStartView = [[ZDXStoreStartView alloc] init];
    [self.contentView addSubview:appraiseStartView];
    self.appraiseStartView = appraiseStartView;
    
    // 评价时间
    UILabel *time = [[UILabel alloc] init];
//    time.font =
    time.textColor = colorWithString(@"#444444");
    [self.contentView addSubview:time];
    self.time = time;
    
    // 评价内容
    UILabel *content = [[UILabel alloc] init];
//    content.font =
    content.textColor = colorWithString(@"#444444");
    content.numberOfLines = 0;
    [self.contentView addSubview:content];
    self.content = content;
    
    // 图片
    ZDXStorePhotosView *appraisePhotos = [[ZDXStorePhotosView alloc] init];
    [self.contentView addSubview:appraisePhotos];
    self.appraisePhotos = appraisePhotos;
    
    // 商品图片
    UIImageView *goodsImg = [[UIImageView alloc] init];
    [self.contentView addSubview:goodsImg];
    self.goodsImg = goodsImg;
    
    // 商品名
    UILabel *goodsName = [[UILabel alloc] init];
    goodsName.textColor = colorWithString(@"#262626");
//    goodsName.font =
    goodsName.numberOfLines = 2;
    [self.contentView addSubview:goodsName];
    self.goodsName = goodsName;
    
    // 商品规格
    UILabel *goodsDetail = [[UILabel alloc] init];
    goodsDetail.textColor = colorWithString(@"#444444");
//    goodsDetail.font =
    [self.contentView addSubview:goodsDetail];
    self.goodsDetail = goodsDetail;
    
    // 商品价格
    UILabel *goodsPrice = [[UILabel alloc] init];
    goodsPrice.textColor = colorWithString(@"#262626");
//    goodsPrice.font =
    [self.contentView addSubview:goodsPrice];
    self.goodsPrice = goodsPrice;
    
}

-(void)setMyAppraiseFrames:(ZDXStoreMyAppraiseFrames *)myAppraiseFrames{
    _myAppraiseFrames = myAppraiseFrames;
    
}

@end
