//
//  ZDXStoreClassifyLeftCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/30.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreClassifyLeftCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreClassifyLeftCell ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZDXStoreClassifyLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.name = [[UILabel alloc] init];
        self.name.x = 0;
        self.name.y = 0;
        self.name.width = SCREEN_WIDTH / 4;
        self.name.height = 57;
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = [UIColor colorWithHexString:@"#444444"];
        self.name.highlightedTextColor = [UIColor colorWithHexString:@"#e93644"];
        [self.name setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.name];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 57)];
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f95865"];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#f4f4f4"];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.lineView.hidden = !selected;
}

@end
