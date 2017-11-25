//
//  ZDXStoreFiltratePushViewTypeCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/3.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltratePushViewTypeCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreFiltratePushViewTypeCell ()

@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation ZDXStoreFiltratePushViewTypeCell

+(instancetype)initWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
//    ZDXStoreFiltratePushViewTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    ZDXStoreFiltratePushViewTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ZDXStoreFiltratePushViewTypeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    NSArray *arr = @[@"壁挂式",@"中央空调",@"柜式",@"空调配件",@"空调挂饰",@"舱机"];
    NSInteger maxCols = 4;
   
    
    CGFloat width = (SCREEN_WIDTH * 4 / 5 - 20 - 10 * (maxCols - 1)) / maxCols;
    CGFloat height = 25;
    for (int i = 0; i < arr.count; i++) {
        NSInteger cols = i % maxCols;
        CGFloat x = 10 + cols * (width + 10);
        NSInteger row = i / maxCols;
        CGFloat y = 15 + row * (height + 15);
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中前"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中后"] forState:UIControlStateSelected];
        [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [btn setTitleColor:colorWithString(@"#ffffff") forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.cornerRadius = 7;
        [self.contentView addSubview:btn];
        
        if (i == arr.count - 1) {
            self.cellH = CGRectGetMaxY(btn.frame) + 15;
        }
    }
}

-(void)click:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}
@end
