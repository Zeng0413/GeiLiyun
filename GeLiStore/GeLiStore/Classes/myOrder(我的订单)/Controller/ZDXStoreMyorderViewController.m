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
#import "ZDXStoreUserModel.h"
#import "ZDXStoreMyOrderHeaderView.h"
#import "ZDXStoreOrderModel.h"
static NSString *myOrderCellID = @"MyOrderCell";
@interface ZDXStoreMyorderViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreMyOrderCellDelegate>

@property (strong, nonatomic) ZDXStoreMyOrderTopView *topView;

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orderArr;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;

@property (assign, nonatomic) NSInteger page;
@end

@implementation ZDXStoreMyorderViewController

-(NSMutableArray *)orderArr{
    if (!_orderArr) {
        _orderArr = [NSMutableArray array];
    }
    return _orderArr;
}

-(ZDXStoreMyOrderTopView *)topView{
    if (!_topView) {
        CGFloat viewH;
        if (isPhone6) {
            viewH = 55;
        }else{
            viewH = 45;
        }
        _topView = [[ZDXStoreMyOrderTopView alloc] initWithTopViewFrame:CGRectMake(0, 64, SCREEN_WIDTH, viewH) titleName:@[@"全部订单",@"待付款",@"待收货",@"待评价",@"退款／售后"]];
        
        __weak typeof(self) selfVc = self;
        _topView.block = ^(NSInteger tag) {
            NSString *str = @"";
            if (tag == 0) { // 加载全部订单
                str = @"api/v1.Orders/allOrders";
            }else if (tag == 1){ // 待付款
                str = @"api/v1.Orders/waitPayByPage";
            }else if (tag == 2){ // 待收货
                str = @"api/v1.Orders/waitReceiptByPage";
            }else if (tag == 3){ // 待评价
                str = @"api/v1.Orders/waitAppraiseByPage";
            }else if (tag == 4){ // 退款／售后
                str = @"api/v1.Orders/finishByPage";
            }
            [selfVc reloadOrder:str];
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
    
    self.page = 1;
    self.userModel = [ZDXStoreUserModelTool userModel];
    
    // 加载数据
    [self reloadData];
    
    // 默认选中订单类型
    [self.topView selectedWithIndex:self.index];
    
    // 初始化tableView
    [self setupTableView];
}

// 加载数据
-(void)reloadData{
    NSString *str = @"";
    if (self.index == 0) { // 加载全部订单
        str = @"api/v1.Orders/allOrders";
    }else if (self.index == 1){ // 待付款
        str = @"api/v1.Orders/waitPayByPage";
    }else if (self.index == 2){ // 待收货
        str = @"api/v1.Orders/waitReceiptByPage";
    }else if (self.index == 3){ // 待评价
        str = @"api/v1.Orders/waitAppraiseByPage";
    }else if (self.index == 4){ // 退款／售后
        str = @"api/v1.Orders/finishByPage";
    }
    [self reloadOrder:str];
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

#pragma mark - 加载数据
-(void)reloadOrder:(NSString *)urlString{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(self.userModel.userId);
    params[@"page"] = @(self.page);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",hostUrl,urlString];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"code"] integerValue] == 1) { // 数据加载成功
            self.orderArr = [ZDXStoreOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    ZDXStoreOrderModel *orderModel = self.orderArr[section];
    return orderModel.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZDXStoreMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellID];
    cell.orderModel = self.orderArr[indexPath.section];
    cell.delegate = self;
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
    ZDXStoreOrderModel *model = self.orderArr[section];
    view.orderModel = model;
    return view;
}


#pragma mark - cell Delegate
-(void)orderSelected:(NSString *)str{
    NSLog(@"%@",str);
}
@end
