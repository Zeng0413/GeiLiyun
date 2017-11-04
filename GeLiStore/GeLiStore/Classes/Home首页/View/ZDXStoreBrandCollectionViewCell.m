//
//  ZDXStoreBrandCollectionViewCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreBrandCollectionViewCell.h"
#import "UIColor+ColorChange.h"
@implementation ZDXStoreBrandCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
//    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    _brandImage = [[UIImageView alloc] init];
    _brandImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_brandImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _brandImage.frame = self.bounds;
}
@end
