//
//  ZDXStoreRecylingInNewViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreRecylingInNewViewController.h"
#import "ZDXComnous.h"
@interface ZDXStoreRecylingInNewViewController ()

@end

@implementation ZDXStoreRecylingInNewViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回收";
    self.view.backgroundColor = ZDXRandomColor;
    // Do any additional setup after loading the view.
}




@end
