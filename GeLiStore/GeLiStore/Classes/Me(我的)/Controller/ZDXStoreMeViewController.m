//
//  ZDXStoreMeViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreMeHeaderView.h"
#import "ZDXStoreMeOrderAndServiceCell.h"
#import "ZDXStoreMeInfoViewController.h"
#import "ZDXStoreSettingViewController.h"
#import "ZDXStoreLoginViewController.h"

static NSString *meOrderAndServiceCellID = @"meOrderAndServiceCell";
@interface ZDXStoreMeViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreMeHeaderViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreMeHeaderView *headerView;

@property (strong, nonatomic) ZDXStoreMeOrderAndServiceCell *meOrderCell;

@property (strong, nonatomic) ZDXStoreMeOrderAndServiceCell *meServiceCell;

@end

@implementation ZDXStoreMeViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = ZDXRandomColor;
    
    // 设置tableView
    [self setupTableView];
    // Do any additional setup after loading the view.
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headerView = [[ZDXStoreMeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 122)];
    self.headerView.delegate = self;
    [tableView setTableHeaderView:self.headerView];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreMeOrderAndServiceCell" bundle:nil] forCellReuseIdentifier:meOrderAndServiceCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSArray *arr = @[@"待付款",@"待收货",@"待评价",@"退货／售后",@"全部订单"];
        ZDXStoreMeOrderAndServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:meOrderAndServiceCellID];
        cell.dataList = arr;
        cell.title.text = @"我的订单";
        [cell setupUIWithMaxCols:5 imageToView:13 imageWH:35 lableToImage:7];
        self.meOrderCell = cell;
        return cell;
        
    }
    
    if (indexPath.row == 1) {
        NSArray *arr = @[@"我的钱包",@"现金劵",@"我的评价",@"我的收藏",@"我的回收",@"我的共享"];
        ZDXStoreMeOrderAndServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:meOrderAndServiceCellID];
        cell.dataList = arr;
        cell.title.text = @"我的服务";
        [cell setupUIWithMaxCols:3 imageToView:25 imageWH:41 lableToImage:9];
        self.meServiceCell = cell;
        return cell;
    }
    static NSString *indenifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indenifier];
    }
    
    cell.textLabel.text = @"zdx";
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.meOrderCell.cellH;
    }else if (indexPath.row == 1){
        return self.meServiceCell.cellH;
    }
    return 50;
}


#pragma mark - headerView delegate
-(void)headerViewHeaderClick{
    
//    [self.navigationController pushViewController:[[ZDXStoreMeInfoViewController alloc] init] animated:YES];
    [self.navigationController pushViewController:[[ZDXStoreLoginViewController alloc] init] animated:YES];
    
}

-(void)settingClick{
    [self.navigationController pushViewController:[[ZDXStoreSettingViewController alloc] init] animated:YES];
}

@end
