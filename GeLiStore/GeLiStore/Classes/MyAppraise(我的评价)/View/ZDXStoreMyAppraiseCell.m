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
#import "ZDXStoreAppraiseModel.h"
@interface ZDXStoreMyAppraiseCell ()

// 用户头像
@property (weak, nonatomic) UIImageView *headerImg;
// 用户名称
@property (weak, nonatomic) UILabel *userName;
// 评星View
@property (strong, nonatomic) ZDXStoreStartView *appraiseStartView;
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


@property (weak, nonatomic) UIView *lineView;
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
        self.backgroundColor = [UIColor whiteColor];
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
    userName.font = ZDXStoreCellNameFont;
    [self.contentView addSubview:userName];
    self.userName = userName;
    
    // 评星View
    self.appraiseStartView = [[ZDXStoreStartView alloc]init];
    [self.contentView addSubview:self.appraiseStartView];
    
    // 评价时间
    UILabel *time = [[UILabel alloc] init];
    time.font = ZDXStoreCellTimeFont;
    time.textColor = colorWithString(@"#444444");
    [self.contentView addSubview:time];
    self.time = time;
    
    // 评价内容
    UILabel *content = [[UILabel alloc] init];
    content.font = ZDXStoreCellContentFont;
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
    goodsName.font = ZDXStoreCellGoodsNameFont;
    goodsName.numberOfLines = 2;
    [self.contentView addSubview:goodsName];
    self.goodsName = goodsName;
    
    // 商品规格
    UILabel *goodsDetail = [[UILabel alloc] init];
    goodsDetail.textColor = colorWithString(@"#444444");
    goodsDetail.font = ZDXStoreCellGoodsDetailFont;
    [self.contentView addSubview:goodsDetail];
    self.goodsDetail = goodsDetail;
    
    // 商品价格
    UILabel *goodsPrice = [[UILabel alloc] init];
    goodsPrice.textColor = colorWithString(@"#262626");
    goodsPrice.font = ZDXStoreCellGoodsPriceFont;
    [self.contentView addSubview:goodsPrice];
    self.goodsPrice = goodsPrice;

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = colorWithString(@"#f4f4f4");
    [self.contentView addSubview:topView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorWithString(@"#8a8a8a");
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

-(void)setMyAppraiseFrames:(ZDXStoreMyAppraiseFrames *)myAppraiseFrames{
    _myAppraiseFrames = myAppraiseFrames;
    
    ZDXStoreAppraiseModel *appraiseModel = myAppraiseFrames.appraiseModel;
    // 用户头像
    self.headerImg.frame = myAppraiseFrames.headerImgF;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,appraiseModel.userPhoto]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    // 用户名称
    self.userName.frame = myAppraiseFrames.userNameF;
    self.userName.text = appraiseModel.userName;
    // 评星View
    self.appraiseStartView.x = myAppraiseFrames.appraiseStartViewF.origin.x;
    self.appraiseStartView.y = myAppraiseFrames.appraiseStartViewF.origin.y;
    self.appraiseStartView.size = CGSizeMake(self.appraiseStartView.ViewW, 10);
    
    self.appraiseStartView.score = appraiseModel.goodsScore;

    // 评价时间
    self.time.frame = myAppraiseFrames.timeF;
    self.time.text = appraiseModel.createTime;
    // 评价内容
    self.content.frame = myAppraiseFrames.contentF;
    self.content.text = appraiseModel.content;
    // 图片
    if (appraiseModel.imagesArray.count>0) {
        self.appraisePhotos.frame = myAppraiseFrames.appraisePhotosF;
        self.appraisePhotos.photos = appraiseModel.imagesArray;
        self.appraisePhotos.hidden = NO;
         
    }else{
        self.appraisePhotos.hidden = YES;
    }
    
    self.lineView.frame = CGRectMake(0, myAppraiseFrames.goodsImgF.origin.y - 15, SCREEN_WIDTH, 1);
    
    // 商品图片
    self.goodsImg.frame = myAppraiseFrames.goodsImgF;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,appraiseModel.goodsImg]] placeholderImage:[UIImage imageNamed:@"商品图加载"]];
    // 商品名
    self.goodsName.frame = myAppraiseFrames.goodsNameF;
    self.goodsName.text = appraiseModel.goodsName;
    // 商品规格
    self.goodsDetail.frame = myAppraiseFrames.goodsDetailF;
    self.goodsDetail.text = @"重量 80kg";
    // 商品价格
    self.goodsPrice.frame = myAppraiseFrames.goodsPriceF;
    self.goodsPrice.text = @"¥3559.00";

}

@end
