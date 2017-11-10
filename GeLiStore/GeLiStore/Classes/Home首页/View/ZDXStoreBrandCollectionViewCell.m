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
    _brandImage.layer.masksToBounds = YES;
    _brandImage.layer.cornerRadius = 7;
//    _brandImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_brandImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _brandImage.frame = CGRectMake(0, self.frame.size.height / 2 - 30 / 2, self.frame.size.width, 30);
}
@end
