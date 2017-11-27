//
//  ZDXStoreSetupPwdViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSetupPwdViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreUserModel.h"
@interface ZDXStoreSetupPwdViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PWDTextField;
@property (weak, nonatomic) IBOutlet UIButton *confireBtn;

@end

@implementation ZDXStoreSetupPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";
    self.PWDTextField.delegate = self;
    self.PWDTextField.layer.borderWidth = 1.0f;
    self.PWDTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.PWDTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.confireBtn setBackgroundColor:ZDXColor(255, 164, 166)];
    self.confireBtn.layer.cornerRadius = 7;
    self.confireBtn.enabled = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.PWDTextField endEditing:YES];
}

-(void)valueChange:(UITextField *)textFiled{
    if (textFiled.text.length > 5) {
        self.confireBtn.backgroundColor = colorWithString(@"#eb5560");
        self.confireBtn.enabled = YES;
    }else{
        [self.confireBtn setBackgroundColor:ZDXColor(255, 164, 166)];
        self.confireBtn.enabled = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.PWDTextField endEditing:YES];
    return YES;
}

- (IBAction)confireClick:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在加载..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"loginName" : self.phoneNumStr,@"loginPwd" : self.PWDTextField.text,@"reUserPwd" : self.PWDTextField.text,@"nameType" : @"3"};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Users/toRegist",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [MBProgressHUD showSuccess:@"设置成功"];
    
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}









@end
