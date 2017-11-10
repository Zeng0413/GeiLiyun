//
//  ZDXStoreCommodityClassifyCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommodityClassifyCell.h"
#import "ZDXStoreClassifyView.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsClassifyModel.h"
@interface ZDXStoreCommodityClassifyCell ()


@end

@implementation ZDXStoreCommodityClassifyCell

+(instancetype)initWithCommodityClassifyTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreCommodityClassifyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ZDXStoreCommodityClassifyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    [self setupUI:dataList];
}


-(void)setupUI:(NSArray *)dataList{
    NSInteger maxCols = 4;
    for (int i = 0; i<dataList.count; i++) {
        ZDXStoreGoodsClassifyModel *goodsClassifyModel = dataList[i];
        ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
        [view setupUI];
        view.imageStr = goodsClassifyModel.catImg;
        view.titleStr = goodsClassifyModel.catName;
        view.imageToView = 12.0;
        view.imageWH = 49;
        view.labelToImage = 6;
        view.labelH = 12;
        
        
        CGFloat width = SCREEN_WIDTH / maxCols;
        CGFloat heigth = 79;
        
        NSInteger cols = i % maxCols;
        NSInteger row = i / maxCols;
        view.x = cols * width;
        view.y = row * heigth;
        view.width = width;
        view.heigth = heigth;
        [self.contentView addSubview:view];

        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(cols * width, row * heigth, width, heigth);
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedCommodity:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    self.cellH = 2 * 79;
}


-(void)selectedCommodity:(UIButton *)button{
    ZDXStoreGoodsClassifyModel *model = self.dataList[button.tag];
    if ([self.delegate respondsToSelector:@selector(selectedCommodityClassifyModel:)]) {
        [self.delegate selectedCommodityClassifyModel:model];
    }
}
@end
