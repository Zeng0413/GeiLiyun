//
//  ZDXStoreSetupDefaultAddressCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSetupDefaultAddressCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreSetupDefaultAddressCell ()

@end

@implementation ZDXStoreSetupDefaultAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    UIButton *defaultBtn = [[UIButton alloc]init];
    defaultBtn.width = 22;
    defaultBtn.height = 22;
    defaultBtn.x = SCREEN_WIDTH - 10 - defaultBtn.width;
    defaultBtn.y = self.contentView.height - 19 - defaultBtn.height;
    
    [defaultBtn setImage:[UIImage imageNamed:@"未选中商品"] forState:UIControlStateNormal];
    [defaultBtn setImage:[UIImage imageNamed:@"选中商品"] forState:UIControlStateSelected];
    [defaultBtn addTarget:self action:@selector(defaultAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:defaultBtn];
    
}

-(void)defaultAddressClick:(UIButton *)button{
    button.selected = !button.isSelected;
    NSInteger num;
    if (button.selected) {
        num = 1;
    }else{
        num = 2;
    }
    
    if (self.block) {
        self.block(num);
    }
}



@end
