//
//  ZDXStoreMeOrderAndServiceCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeOrderAndServiceCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreClassifyView.h"

@interface ZDXStoreMeOrderAndServiceCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ZDXStoreMeOrderAndServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title.textColor = colorWithString(@"#262626");
    self.lineView.backgroundColor = colorWithString(@"#f4f4f4");
    
}

-(void)setupUIWithMaxCols:(NSInteger)maxCols imageToView:(CGFloat)imageToView imageWH:(CGFloat)imageWH lableToImage:(CGFloat)lableToImage{
    
    NSInteger count = self.dataList.count;
    NSInteger hh = 0;
    
    for (int i = 0; i<count; i++) {
        ZDXStoreClassifyView *view = [ZDXStoreClassifyView initWithClassifyView];
        [view setupUI];
        view.label.textColor = colorWithString(@"#444444");
        view.imageView.image = [UIImage imageNamed:self.dataList[i]];
        view.titleStr = self.dataList[i];
        view.imageToView = imageToView;
        view.imageWH = imageWH;
        view.labelToImage = lableToImage;
        view.labelH = 12;
        
        CGFloat width = SCREEN_WIDTH / maxCols;
        CGFloat height = imageToView + imageWH + lableToImage + 12;
        NSInteger cols = i % maxCols;
        NSInteger row = i / maxCols;
        view.x = cols * width;
        view.y = 56 + row * height;
        view.width = width;
        view.height = height;
        [self.contentView addSubview:view];
        
        if (i == count - 1) {
            hh = CGRectGetMaxY(view.frame) + 30;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(cols * width, 56 + row * height, width, height);
        [btn setTitle:self.dataList[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedCommodity:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, hh, SCREEN_WIDTH, 10)];
    grayView.backgroundColor = colorWithString(@"#f4f4f4");
    [self.contentView addSubview:grayView];
    
    self.cellH = CGRectGetMaxY(grayView.frame);
}

-(void)selectedCommodity:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(cellSelectedTypeStr:)]) {
        [self.delegate cellSelectedTypeStr:button.titleLabel.text];
    }
}

@end
