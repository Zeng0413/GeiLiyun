//
//  ZDXStoreShareClassifyCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/18.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShareClassifyCell.h"
#import "ZDXStoreClassifyView.h"
#import "ZDXComnous.h"
@interface ZDXStoreShareClassifyCell ()



@end

@implementation ZDXStoreShareClassifyCell

+(instancetype)initWithShareTableView:(UITableView *)tableView cellForAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreShareClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ZDXStoreShareClassifyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    NSInteger maxCols = 4;
    NSArray *arr = @[@"逛同城",@"空调",@"彩电",@"洗衣机",@"烟灶热",@"厨房小电",@"生活电器",@"智能生活"];
    NSInteger count = arr.count;
    for (int i = 0; i < count; i++) {
        ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
        [view setupUI];
        
        view.label.textColor = colorWithString(@"#444444");
        view.imageView.image = [UIImage imageNamed:arr[i]];
        view.titleStr = arr[i];
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
        
    }
    
    self.cellH = 2 * 79 + 11;
}

@end
