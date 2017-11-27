//
//  ZDXStoreCodeVerificationViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCodeVerificationViewController.h"
#import "ZDXStoreUnderLineBtn.h"
#import "ZDXComnous.h"
#import "ZDXStoreSetupPwdViewController.h"

@interface ZDXStoreCodeVerificationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet ZDXStoreUnderLineBtn *contractServerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

//获取验证码倒计时
@property (nonatomic,assign) NSInteger getCodeTime;

@property (nonatomic,strong) NSTimer *timer;

// 获取得到验证码
@property (copy, nonatomic) NSString *codeStr;
@end

@implementation ZDXStoreCodeVerificationViewController

- (void) viewDidDisappear:(BOOL)animated
{
    
    [self removeObserver:self forKeyPath:@"getCodeTime"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self addObserver:self forKeyPath:@"getCodeTime" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";

    // 初始化界面
    [self setupUI];
    
    //    KVO
    _getCodeTime = 120;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.codeTextField endEditing:YES];
}

-(void)setupUI{
    self.view.backgroundColor = colorWithString(@"#f2f2f2");
    
    self.codeTextField.delegate = self;
    self.codeTextField.layer.borderWidth = 1.0f;
    self.codeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.codeTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.contractServerBtn setTitleColor:colorWithString(@"#464646") forState:UIControlStateNormal];
    [self.contractServerBtn setColor:colorWithString(@"#464646")];
    
    [self.sendCodeBtn setBackgroundColor:colorWithString(@"#eb5560")];
    
    [self.nextBtn setBackgroundColor:ZDXColor(255, 164, 166)];
    self.nextBtn.layer.cornerRadius = 7;
    self.nextBtn.enabled = NO;
    
}

-(void)valueChange:(UITextField *)textFiled{
    if (textFiled.text.length > 0) {
        self.nextBtn.backgroundColor = colorWithString(@"#eb5560");
        self.nextBtn.enabled = YES;
    }else{
        [self.nextBtn setBackgroundColor:ZDXColor(255, 164, 166)];
        self.nextBtn.enabled = NO;
    }
}

- (IBAction)sendCodeClick:(UIButton *)sender {
    
    //        设置倒计时
    _getCodeTime = 120;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramDict = @{@"userPhone" : self.phoneNumStr};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Users/SendSMSAuthenticationCode",hostUrl];
    [manager POST:urlStr parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) { // 验证码发送成功
            
        }else{
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //    创建弹出框
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
    
    self.sendCodeBtn.userInteractionEnabled = NO;
    [self.sendCodeBtn setBackgroundColor:colorWithString(@"#ffa4a4")];
    [self.codeTextField becomeFirstResponder];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void) action
{
    self.getCodeTime --;
}

#pragma mark -- KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"getCodeTime"]) {
        if (_getCodeTime >0) {
            NSString *str = [NSString stringWithFormat:@"%lds",self.getCodeTime];
            [self.sendCodeBtn setTitle:str forState:UIControlStateNormal];
        }
        
        if (_getCodeTime == 0) {
            [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            self.sendCodeBtn.userInteractionEnabled = YES;
            self.sendCodeBtn.backgroundColor = colorWithString(@"#eb5560");
            [_timer invalidate];
        }
        
        
    }
    
}

- (IBAction)nextClick:(UIButton *)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userPhone" : self.phoneNumStr,@"mobileCode" : self.codeTextField.text};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Users/VerifySMSAuthenticationCode",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            ZDXStoreSetupPwdViewController *vc = [[ZDXStoreSetupPwdViewController alloc] init];
            vc.phoneNumStr = self.phoneNumStr;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.codeTextField endEditing:YES];
    return YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
