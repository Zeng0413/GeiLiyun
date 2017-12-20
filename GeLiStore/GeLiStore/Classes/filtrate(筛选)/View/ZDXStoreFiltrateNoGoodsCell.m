//
//  ZDXStoreFiltrateNoGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/13.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltrateNoGoodsCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreFiltrateNoGoodsCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ZDXStoreFiltrateNoGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
}

@end
