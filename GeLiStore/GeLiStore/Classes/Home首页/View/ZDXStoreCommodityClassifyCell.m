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
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    NSArray *arr = @[@"冰箱",@"空调",@"彩电",@"洗衣机",@"烟灶热",@"厨房小电",@"生活电器",@"智能生活"];
    NSInteger maxCols = 4;
    for (int i = 0; i<arr.count; i++) {
        ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
        view.imageStr = arr[i];
        view.titleStr = arr[i];
        view.imageToView = 12.0;
        view.imageWH = 49;
        view.labelToImage = 6;
        view.labelH = 12;
        [view setupUI];
        
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
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedCommodity:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    self.cellH = 2 * 79;
}


-(void)selectedCommodity:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(selectedCommodityClassifyString:)]) {
        [self.delegate selectedCommodityClassifyString:button.titleLabel.text];
    }
}
@end
