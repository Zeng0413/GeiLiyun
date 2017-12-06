//
//  ZDXStoreRebateCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreRebateCell.h"
#import "UIColor+ColorChange.h"

@interface ZDXStoreRebateCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rabate; // 抵扣券

@end

@implementation ZDXStoreRebateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    self.title.textColor = [UIColor colorWithHexString:@"#262626"];
    self.rabate.textColor = [UIColor colorWithHexString:@"#ff9600"];
}



@end
