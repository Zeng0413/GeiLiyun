//
//  ZDXStoreCollectionStoreCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCollectionStoreCell.h"
#import "UIColor+ColorChange.h"

@interface ZDXStoreCollectionStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *storeImg;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeDetail;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation ZDXStoreCollectionStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.topLine.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"#cdcdcd"];
    
    self.storeImg.layer.masksToBounds = YES;
    self.storeImg.layer.cornerRadius = 30;
    
    self.storeName.textColor = [UIColor colorWithHexString:@"#262626"];
    
    self.storeDetail.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    
    self.storeBtn.layer.cornerRadius = 7;
    self.storeBtn.layer.borderColor = [UIColor colorWithHexString:@"#e63944"].CGColor;
    self.storeBtn.layer.borderWidth = 1.0;
    [self.storeBtn setTitle:@"进店" forState:UIControlStateNormal];
    [self.storeBtn setTitleColor:[UIColor colorWithHexString:@"e63944"] forState:UIControlStateNormal];
}



@end
