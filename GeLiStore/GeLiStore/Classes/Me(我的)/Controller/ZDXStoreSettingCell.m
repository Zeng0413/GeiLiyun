//
//  ZDXStoreSettingCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSettingCell.h"
#import "UIColor+ColorChange.h"
@interface ZDXStoreSettingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ZDXStoreSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#262626"];

}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.image.image = [UIImage imageNamed:dict[@"image"]];
    self.titleLabel.text = dict[@"title"];
}

@end
