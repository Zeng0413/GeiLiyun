//
//  ZDXStoreMeInfoViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeInfoViewController.h"
#import "ZDXComnous.h"
@interface ZDXStoreMeInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ZDXStoreMeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

    self.lineView.backgroundColor = colorWithString(@"#f5f5f5");
    self.username.textColor = colorWithString(@"#8a8a8a");
    self.backView.backgroundColor = colorWithString(@"#f4f4f4");
    
}

- (IBAction)clickHeader:(UIButton *)sender {
}

- (IBAction)clickHeaderName:(UIButton *)sender {
}


@end
