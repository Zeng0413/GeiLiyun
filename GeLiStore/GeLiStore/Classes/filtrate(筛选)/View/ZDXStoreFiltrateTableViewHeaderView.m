//
//  ZDXStoreFiltrateTableViewHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/11/3.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltrateTableViewHeaderView.h"
#import "UIView+Frame.h"
#import "UIColor+ColorChange.h"
@implementation ZDXStoreFiltrateTableViewHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1)];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#e4e4e4"];
    [self addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#e4e4e4"];
    [self addSubview:lineView2];
    
    self.titleName = [[UILabel alloc] init];
    self.titleName.x = 10;
    self.titleName.width = 80;
    self.titleName.height = 15;
    self.titleName.y = self.height / 2 - self.titleName.height / 2;
    self.titleName.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    self.titleName.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleName];
}

@end
