//
//  ZDXStoreRefundReasonCell.m
//  GeLiStore
//
//  Created by user99 on 2018/1/4.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreRefundReasonCell.h"
#import "ZDXComnous.h"
@interface ZDXStoreRefundReasonCell ()<UITextViewDelegate>
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    
    
    NSArray *arr = @[@"下错单",@"配送地址有误",@"其他",@"我有更好的商品想买",@"商品信息与商家描述的不一致"];
    NSInteger count = arr.count;
    CGFloat height = 30;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            btn.frame = CGRectMake(10, CGRectGetMaxY(title.frame) + 20, 50, height);
            btn.tag = 1;
        }else if (i == 1){
            btn.width = 100;
            btn.height = height;
            btn.y = CGRectGetMaxY(title.frame) + 20;
            btn.x = SCREEN_WIDTH / 2 - 50;
            btn.tag = 2;

        }else if (i == 2){
            btn.width = 50;
            btn.height = height;
            btn.x = SCREEN_WIDTH - 10 - 50;
            btn.y = CGRectGetMaxY(title.frame) + 20;
            btn.tag = 5;
        }else if (i == 3){
            btn.frame = CGRectMake(10, CGRectGetMaxY(title.frame) + 20 + height + 10, 130, height);
            btn.tag = 3;
        }else if (i == 4){
            btn.frame = CGRectMake(10, CGRectGetMaxY(title.frame) + 20 + (height + 10) * 2, 190, height);
            self.cellH = CGRectGetMaxY(btn.frame);
            btn.tag = 4;
        }
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中前"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"类别标签选中后"] forState:UIControlStateSelected];
        [btn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [btn setTitleColor:colorWithString(@"#ffffff") forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:btn];
        
        
    }
    
    self.textView = [[ZDXTextView alloc] init];
    self.textView.y = self.cellH + 20;
    self.textView.width = SCREEN_WIDTH - 20;
    self.textView.x = 10;
    self.textView.height = self.textView.width / (355 / 149);
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.delegate = self;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.masksToBounds = YES;
    // 垂直方向上永远可以退拽
    self.textView.alwaysBounceVertical = YES;
    self.textView.placeholder = @"可输入其他退款原因。";
    self.textView.placeholderColor = [UIColor colorWithHexString:@"#8a8a8a"];
    [self.contentView addSubview:self.textView];
    
    self.cellH = CGRectGetMaxY(self.textView.frame) + 45;
}

-(void)click:(UIButton *)button{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(selectedRefundReasonTag:)]) {
        [self.delegate selectedRefundReasonTag:button.tag];
    }
}

#pragma mark - UITextView Delegate Methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.contentView endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
