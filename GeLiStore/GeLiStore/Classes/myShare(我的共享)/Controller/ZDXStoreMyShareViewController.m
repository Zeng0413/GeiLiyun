//
//  ZDXStoreMyShareViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreMyShareViewController.h"
#import "ZDXComnous.h"
@interface ZDXStoreMyShareViewController ()

@property (weak, nonatomic) IBOutlet UILabel *moneyCount;
@property (weak, nonatomic) IBOutlet UILabel *dateMoney;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation ZDXStoreMyShareViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.moneyCount.alpha = 0.7;
    self.dateMoney.textColor = colorWithString(@"#b2b2b2");
    self.money.textColor = colorWithString(@"#8a8a8a");
    self.midView.backgroundColor = colorWithString(@"#f4f4f4");
    self.bottomView.backgroundColor = colorWithString(@"#f4f4f4");
    self.lineView.backgroundColor = colorWithString(@"#cdcdcd");
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
