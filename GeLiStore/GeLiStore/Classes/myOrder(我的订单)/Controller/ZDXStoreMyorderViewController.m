//
//  ZDXStoreMyorderViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/22.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMyorderViewController.h"
#import "ZDXStoreMyOrderTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreMyOrderCell.h"
#import "ZDXStoreShopModel.h"
#import "ZDXStoreMyOrderHeaderView.h"
static NSString *myOrderCellID = @"MyOrderCell";
@interface ZDXStoreMyorderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ZDXStoreMyOrderTopView *topView;

@property (weak, nonatomic) UITableView *tableView;
@end

@implementation ZDXStoreMyorderViewController

-(ZDXStoreMyOrderTopView *)topView{
    if (!_topView) {
        CGFloat viewH;
        if (isPhone6) {
            viewH = 55;
        }else{
            viewH = 45;
        }
        _topView = [[ZDXStoreMyOrderTopView alloc] initWithTopViewFrame:CGRectMake(0, 64, SCREEN_WIDTH, viewH) titleName:@[@"全部订单",@"待付款",@"待收货",@"待评价",@"退款／售后"]];
        
        _topView.block = ^(NSInteger tag) {
            
        };
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topView];
    
    // 默认选中订单类型
    [self.topView selectedWithIndex:self.index];
    
    // 初始化tableView
    [self setupTableView];
}

// 初始化tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + self.topView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.topView.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreMyOrderCell" bundle:nil] forCellReuseIdentifier:myOrderCellID];
    [tableView registerClass:[ZDXStoreMyOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"ZDXStoreMyOrderHeaderView"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDXStoreMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellID];
    return cell;
    
//    static NSString *indenifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indenifier];
//    }
//    
//    cell.textLabel.text = @"zdx";
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZDXStoreMyOrderHeaderView *view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZDXStoreMyOrderHeaderView"];
    ZDXStoreShopModel *model = [[ZDXStoreShopModel alloc] init];
    model.shopName = @"海尔旗舰店";
    view.shopModel = model;
    return view;
}

@end
