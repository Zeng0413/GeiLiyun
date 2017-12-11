//
//  ZDXStoreNoCollectionCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreNoCollectionCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreNoCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZDXStoreNoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
