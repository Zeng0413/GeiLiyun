//
//  WLRPushView1.m
//  WLReceive
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WLRPushView1.h"
#import "ZDXComnous.h"
#define Wfont [UIFont systemFontOfSize:18]
#define Wcolor [UIColor colorWithHexString:@"#333333"]
#define whiteViewW SCREEN_WIDTH - 50
@interface WLRPushView1 ()<UITextFieldDelegate>

@property (strong, nonatomic)  UITextField *textField;

@property (strong, nonatomic)  UIButton *cancelBtn;
@property (strong, nonatomic)  UIButton *confirmBtn;

@property (strong, nonatomic)  UIView *whiteView;
@property (weak, nonatomic) UIView *shadowView;
@property (nonatomic,strong) NSString *titleStr;
@end
@implementation WLRPushView1

- (instancetype) initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    _titleStr = title;
    
    if (self) {
        [self creatShadowView];
        
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(25, 180, whiteViewW, 180)];
        _whiteView.alpha = 1.0;
        [self addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self whiteViewCreatSubView];

    }
    return self;
}

//创建遮罩层
- (void) creatShadowView
{
    [self creatOneShadowViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

//创建一个遮罩层
- (void) creatOneShadowViewWithFrame:(CGRect)frame
{
    UIView *shadowView =[[UIView alloc] initWithFrame:frame];
    [self addSubview:shadowView];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.6;
    self.shadowView = shadowView;
}
//白色区域创建子控件
- (void) whiteViewCreatSubView
{
//    标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, 200, 20)];
    [self.whiteView addSubview:titleLabel];
    titleLabel.font = Wfont;
    titleLabel.textColor = Wcolor;
    titleLabel.text = [NSString stringWithFormat:@"填写%@信息",_titleStr];
    
//    分界线1
    UIView *seline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, whiteViewW, 1)];
    [self.whiteView addSubview:seline1];
    seline1.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    
//    输入文本
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 65, whiteViewW - 40, 30)];
    [_whiteView addSubview:_textField];
    _textField.delegate = self;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = Wfont;
    _textField.textColor = Wcolor;
    _textField.placeholder = [NSString stringWithFormat:@"请输入%@",_titleStr];
    
    //    分界线2
    UIView *seline2 = [[UIView alloc] initWithFrame:CGRectMake(0, 105, whiteViewW, 1)];
    [self.whiteView addSubview:seline2];
    seline2.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    
//    取消按钮
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 125, (whiteViewW - 30 - 20) / 2, 30)];
    [_whiteView addSubview:_cancelBtn];
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.cornerRadius = 1;
    self.cancelBtn.layer.borderColor = [[UIColor colorWithHexString:@"#333333"] CGColor];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_cancelBtn setFont:Wfont];
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    确认按钮
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + _cancelBtn.width + 20, 125, _cancelBtn.width, 30)];
    [_whiteView addSubview:_confirmBtn];
    _confirmBtn.layer.borderWidth = 1;
    _confirmBtn.layer.cornerRadius = 1;
    _confirmBtn.layer.borderColor = [[UIColor colorWithHexString:@"#333333"] CGColor];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_confirmBtn setFont:Wfont];
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void) cancelBtnClick
{
    [self removeFromSuperview];
}

- (void) confirmBtnClick
{
    self.block(self.textField.text);
        [self removeFromSuperview];

}
//文本框在输入的时候界面上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = self.frame;
    frame.origin.y -=100;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = frame;
    }];
}

@end
