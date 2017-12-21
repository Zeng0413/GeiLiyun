//
//  ZDXStoreShareViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShareViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreShareHeaderView.h"
#import "ZDXStoreShareClassifyCell.h"
#import "ZDXStoreShareGoodsCell.h"

static NSString *shareGoodsCellID = @"ShareGoodsCell";
@interface ZDXStoreShareViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreShareClassifyCell *shareClassifyCell;

@property (strong, nonatomic) ZDXStoreShareGoodsCell *shareGoodsCell;
@end

@implementation ZDXStoreShareViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"共享";
    self.view.backgroundColor = ZDXRandomColor;
    
    // 设置tableView
    [self setupTableView];
}

// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.height) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ZDXStoreShareHeaderView *shareHeaderView = [ZDXStoreShareHeaderView shareHeaderView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    [tableView setTableHeaderView:shareHeaderView];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreShareGoodsCell" bundle:nil] forCellReuseIdentifier:shareGoodsCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZDXStoreShareClassifyCell *cell = [ZDXStoreShareClassifyCell initWithShareTableView:tableView cellForAtIndexPath:indexPath];
        self.shareClassifyCell = cell;
        return cell;
    }else{
        ZDXStoreShareGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:shareGoodsCellID];
        self.shareGoodsCell = cell;
        return cell;
    }
    
    
//    static NSString *indentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
//    }
//    cell.backgroundColor = [UIColor redColor];
//    cell.textLabel.text = @"zdx";
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.shareClassifyCell.cellH;
    }
    
    return self.shareGoodsCell.cellH;
}

@end
