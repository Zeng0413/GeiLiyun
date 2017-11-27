//
//  ZDXStoreLoginViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/16.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreLoginViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreRegisterViewController.h"
#import "ZDXStoreUserModelTool.h"

@interface ZDXStoreLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MidLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHLayout;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ZDXStoreLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    if (isPhone6) {
    }else{
        self.imageTopLayout.constant = 100;
        self.imageWLayout.constant = 115;
        self.imageHLayout.constant = 105;
        self.MidLayout.constant = 60;
    }
    self.view.backgroundColor = colorWithString(@"#f2f2f2");
    
    self.phoneNumTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.loginBtn.layer.cornerRadius = 7;
    [self.loginBtn setBackgroundColor:colorWithString(@"#eb5560")];
    
    self.lineView1.backgroundColor = ZDXColor(242, 205, 207);
    self.lineView2.backgroundColor = ZDXColor(242, 205, 207);
}

// 登录
- (IBAction)loginClick:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在登录..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginName"] = self.phoneNumTextField.text;
    params[@"loginPwd"] = self.passwordTextField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Users/login",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MBProgressHUD showSuccess:@"登录成功"];
            ZDXStoreUserModel *model = [ZDXStoreUserModel mj_objectWithKeyValues:responseObject[@"data"]];
            [ZDXStoreUserModelTool saveUserModel:model];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD hideHUD];
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.passwordTextField.isFirstResponder || self.phoneNumTextField.isFirstResponder) {
        CGRect frame = self.view.frame;
        frame.origin.y +=50;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = frame;
        }];
    }
    [self.passwordTextField endEditing:YES];
    [self.phoneNumTextField endEditing:YES];
}

// 新用户注册
- (IBAction)newUesrnameRegister:(UIButton *)sender {
    ZDXStoreRegisterViewController *vc = [[ZDXStoreRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
}


#pragma mark - textFild delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;
    if (!(frame.origin.y < 0)) {
        frame.origin.y -= 50;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = frame;
        }];
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    CGRect frame = self.view.frame;
    frame.origin.y +=50;
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = frame;
    }];
    return YES;
}

@end
