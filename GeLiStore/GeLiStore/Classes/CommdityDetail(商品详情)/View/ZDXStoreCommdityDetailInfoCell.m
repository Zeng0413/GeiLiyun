//
//  ZDXStoreCommdityDetailInfoCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdityDetailInfoCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
@interface ZDXStoreCommdityDetailInfoCell ()
@property (weak, nonatomic) UILabel *commdityInfoLabel;
@property (weak, nonatomic) UILabel *commdityPricelabel;
@property (weak, nonatomic) UILabel *monthSellLabel;
@property (weak, nonatomic) UILabel *sendCommdityPlaceLabel;
@end

@implementation ZDXStoreCommdityDetailInfoCell

+(instancetype)initWithCommdityDetailWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreCommdityDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ZDXStoreCommdityDetailInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    // 商品详情
    UILabel *commdityInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 37)];
    commdityInfoLabel.numberOfLines = 0;
    commdityInfoLabel.font = [UIFont systemFontOfSize:15];
    commdityInfoLabel.textColor = [UIColor colorWithHexString:@"#262626"];
    [self.contentView addSubview:commdityInfoLabel];
    self.commdityInfoLabel = commdityInfoLabel;
    
    // 商品价格
    UILabel *commdityPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(commdityInfoLabel.frame) + 10, 100, 20)];
    commdityPricelabel.textColor = [UIColor colorWithHexString:@"#e93644"];
    commdityPricelabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:commdityPricelabel];
    self.commdityPricelabel = commdityPricelabel;
    
    // 月销售
    UILabel *monthSellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(commdityPricelabel.frame) + 5, 100, 12)];
    monthSellLabel.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    monthSellLabel.font = [UIFont systemFontOfSize:12];
    
    monthSellLabel.text = @"月销 200笔";
    [self.contentView addSubview:monthSellLabel];
    self.monthSellLabel = monthSellLabel;
    
    // 发货地址
    UILabel *sendCommdityPlaceLabel = [[UILabel alloc] init];
    sendCommdityPlaceLabel.width = 100;
    sendCommdityPlaceLabel.x = SCREEN_WIDTH - sendCommdityPlaceLabel.width - 10;
    sendCommdityPlaceLabel.y = CGRectGetMidY(monthSellLabel.frame);
    sendCommdityPlaceLabel.height = 12;
    sendCommdityPlaceLabel.textAlignment = NSTextAlignmentRight;
    sendCommdityPlaceLabel.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    sendCommdityPlaceLabel.font = [UIFont systemFontOfSize:12];
    
    sendCommdityPlaceLabel.text = @"发货地 重庆";
    [self.contentView addSubview:sendCommdityPlaceLabel];
    self.sendCommdityPlaceLabel = sendCommdityPlaceLabel;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sendCommdityPlaceLabel.frame) + 10, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [self.contentView addSubview:view];
    
    self.cellH = CGRectGetMaxY(view.frame);
}

-(void)setGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    // 商品名
    NSString *productName = [NSString stringWithFormat:@"  %@",goodsModel.goodsName];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:productName];
    CGFloat attchWH = self.commdityInfoLabel.font.lineHeight;
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"参与抵扣"];
    attch.bounds = CGRectMake(0, -3, 45, attchWH - 3);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.commdityInfoLabel.attributedText = attri;
    
    // 商品价格
    self.commdityPricelabel.text = [NSString stringWithFormat:@"¥%@",goodsModel.shopPrice];
    
}

@end
