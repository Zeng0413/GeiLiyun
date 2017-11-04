//
//  ZDXStoreBrandChooseCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreBrandChooseCell.h"
#import "ZDXStoreChooseBrandView.h"
#import "ZDXComnous.h"
@interface ZDXStoreBrandChooseCell ()

@property (strong, nonatomic) ZDXStoreChooseBrandView *chooseBrandView;

@end
@implementation ZDXStoreBrandChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    NSArray *arr = @[@"创维",@"格力",@"海尔",@"海信",@"老板",@"美的",@"sony",@"tcl",@"宝荣",@"大金",@"格米家",@"康纳",@"科龙",@"库巴",@"隆高"];
    ZDXStoreChooseBrandView *view = [[ZDXStoreChooseBrandView alloc] initWithFrame:CGRectMake(14, 142, SCREEN_WIDTH - 14, 37)];
    view.dataList = arr;
    [self.contentView addSubview:view];
    
    UIImageView *xsyhImage = [[UIImageView alloc] init];
    
    xsyhImage.y = CGRectGetMaxY(view.frame) + 6;
    xsyhImage.width = 163;
    xsyhImage.height = 22;
    xsyhImage.x = SCREEN_WIDTH / 2 - xsyhImage.width / 2;
    
    xsyhImage.image = [UIImage imageNamed:@"旧品换新抵扣现金"];
    [self.contentView addSubview:xsyhImage];
    
    self.cellH = CGRectGetMaxY(xsyhImage.frame);
    // Initialization code
}



@end
