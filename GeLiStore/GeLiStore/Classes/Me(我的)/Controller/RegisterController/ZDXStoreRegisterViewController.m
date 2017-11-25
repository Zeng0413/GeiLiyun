//
//  ZDXStoreRegisterViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/23.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreRegisterViewController.h"
#import "ZDXStoreUnderLineBtn.h"
#import "ZDXComnous.h"
#import "ZDXStoreCodeVerificationViewController.h"

@interface ZDXStoreRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DistrictNum;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFileld;
@property (weak, nonatomic) IBOutlet ZDXStoreUnderLineBtn *contractServerBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation ZDXStoreRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";
    // 初始化界面
    [self setupUI];
    
    [self.phoneNumberTextFileld addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
}

-(void)valueChanged:(UITextField *)textFiled{
    if (textFiled.text.length > 10) {
        self.nextBtn.backgroundColor = colorWithString(@"#eb5560");
        self.nextBtn.enabled = YES;
    }else{
        [self.nextBtn setBackgroundColor:ZDXColor(255, 164, 166)];
        self.nextBtn.enabled = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextFileld endEditing:YES];
}

// 初始化界面
-(void)setupUI{
    self.view.backgroundColor = colorWithString(@"#f2f2f2");
    
    self.DistrictNum.layer.borderWidth = 1.0;
    self.DistrictNum.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.phoneNumberTextFileld.delegate = self;
    self.phoneNumberTextFileld.layer.borderWidth= 1.0f;
    self.phoneNumberTextFileld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.contractServerBtn setTitleColor:colorWithString(@"#464646") forState:UIControlStateNormal];
    [self.contractServerBtn setColor:colorWithString(@"#464646")];
    
    [self.nextBtn setBackgroundColor:ZDXColor(255, 164, 166)];
    self.nextBtn.layer.cornerRadius = 7;
    self.nextBtn.enabled = NO;
    
}
- (IBAction)nextClick:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在加载..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"userPhone" : self.phoneNumberTextFileld.text};
    [manager POST:@"http://glys.wuliuhangjia.com/api/v1.Users/checkLoginKey" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) { // 可以注册
            [MBProgressHUD hideHUD];
            ZDXStoreCodeVerificationViewController *vc = [[ZDXStoreCodeVerificationViewController alloc] init];
            vc.phoneNumStr = self.phoneNumberTextFileld.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:responseObject[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
