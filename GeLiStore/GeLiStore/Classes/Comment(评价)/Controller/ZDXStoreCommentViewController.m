//
//  ZDXStoreCommentViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/26.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommentViewController.h"
#import "ZDXComnous.h"
@interface ZDXStoreCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ZDXStoreCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"评价";
    
    // 设置tableView
    [self setupTableView];
    
}

// 设置tableView
-(void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
@end
