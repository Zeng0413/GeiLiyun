//
//  ZDXStoreRefundReasonCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreRefundReasonCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreRefundReasonCell ()
@property (strong, nonatomic) UIButton *selectedBtn;
@end

@implementation ZDXStoreRefundReasonCell

+(instancetype)initWithRefundReasonTableView:(UITableView *)tableView cellForRowAtIndexPAth:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreRefundReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ZDXStoreRefundReasonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 80, 14)];
    title.textColor = colorWithString(@"#262626");
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"退款原因";
    [self.contentView addSubview:title];
    
    
    NSArray *arr = @[@"拍错重拍",@"卖家发货慢",@"不想买了"];
    NSInteger count = arr.count;
    CGFloat border = 62;
    if (!(isPhone6)) {
        border = 62 - 15;
    }
    CGFloat width = (SCREEN_WIDTH - 20 - border * (count - 1)) / count;
    CGFloat height = 30;
    for (NSInteger i=0; i<count; i++) {
        CGFloat x = 10 + i * (width + border);
        CGFloat y = CGRectGetMaxY(title.frame) + 20;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中前"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中后"] forState:UIControlStateSelected];
        [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [btn setTitleColor:colorWithString(@"#ffffff") forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.cornerRadius = 7;
        [self.contentView addSubview:btn];
        
        self.cellH = CGRectGetMaxY(btn.frame) + 20;
    }
    
}

-(void)click:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}
@end
