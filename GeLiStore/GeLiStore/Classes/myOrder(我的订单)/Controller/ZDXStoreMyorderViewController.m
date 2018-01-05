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
#import "ZDXStoreNoCollectionCell.h"
#import "ZDXStoreOrderFooterView.h"
#import "ZDXStoreOrderStatusViewController.h"
#import "ZDXStoreOrderDetailModel.h"
#import "ZDXStoreRefundViewController.h"
#import "ZDXStoreOrderAppraiseViewController.h"
static NSString *noCellID = @"noCellID";
static NSString *myOrderCellID = @"MyOrderCell";
@interface ZDXStoreMyorderViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreOrderFooterViewDelegate>

@property (strong, nonatomic) ZDXStoreMyOrderTopView *topView;

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orderArr;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;

@property (assign, nonatomic) NSInteger page;

@property (copy, nonatomic) NSString *urlStr;
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
        _topView = [[ZDXStoreMyOrderTopView alloc] initWithTopViewFrame:CGRectMake(0, 64, SCREEN_WIDTH, viewH) titleName:@[@"全部订单",@"待付款",@"待发货",@"待收货",@"待评价"]];
        
        __weak typeof(self) selfVc = self;
        _topView.block = ^(NSInteger tag) {
            [selfVc.tableView.mj_header beginRefreshing];

            if (tag == 0) { // 加载全部订单
                selfVc.urlStr = @"api/v1.Orders/allOrders";
            }else if (tag == 1){ // 待付款
                selfVc.urlStr = @"api/v1.Orders/waitPayByPage";
            }else if (tag == 2){ // 待发货
                selfVc.urlStr = @"api/v1.Orders/waitReceiveByPage";
            }else if (tag == 3){ // 待收货
                selfVc.urlStr = @"api/v1.Orders/waitReceiptByPage";
            }else if (tag == 4){ // 待评价
                selfVc.urlStr = @"api/v1.Orders/waitAppraiseByPage";
            }
            [selfVc reloadOrder];
        };
    }
    return _topView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadOrder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topView];
    
    self.page = 1;
    self.userModel = [ZDXStoreUserModelTool userModel];
    
//    // 加载数据
//    [self reloadData];
    // 初始化tableView
    [self setupTableView];
    
    // 默认选中订单类型
    [self.topView selectedWithIndex:self.index];

}

//// 加载数据
//-(void)reloadData{
//    NSString *str = @"";
//    if (self.index == 0) { // 加载全部订单
//        str = @"api/v1.Orders/allOrders";
//    }else if (self.index == 1){ // 待付款
//        str = @"api/v1.Orders/waitPayByPage";
//    }else if (self.index == 2){ // 待发货
//        str = @"api/v1.Orders/waitReceiveByPage";
//    }else if (self.index == 3){ // 待收货
//        str = @"api/v1.Orders/waitReceiptByPage";
//    }else if (self.index == 4){ // 待评价
//        str = @"api/v1.Orders/waitAppraiseByPage";
//    }
//    [self reloadOrder:str];
//}

// 初始化tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + self.topView.height, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.topView.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreMyOrderCell" bundle:nil] forCellReuseIdentifier:myOrderCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreNoCollectionCell" bundle:nil] forCellReuseIdentifier:noCellID];
    [tableView registerClass:[ZDXStoreMyOrderHeaderView class] forHeaderFooterViewReuseIdentifier:@"ZDXStoreMyOrderHeaderView"];
    [tableView registerClass:[ZDXStoreOrderFooterView class] forHeaderFooterViewReuseIdentifier:@"ZDXStoreOrderFooterView"];
    tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);

    // 下拉刷新
    MJRefreshHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadOrder)];
    tableView.mj_header = header;
    
    // 上拉加载更多数据
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrder)];
    tableView.mj_footer = footer;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void)loadNewOrder{
    self.page++;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(self.userModel.userId);
    params[@"page"] = @(self.page);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",hostUrl,self.urlStr];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] integerValue] == 1) { // 数据加载成功
            NSArray *list = [ZDXStoreOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.orderArr addObjectsFromArray:list];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showSuccess:@"暂无更多订单"];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - 加载数据
-(void)reloadOrder{
    self.page = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(self.userModel.userId);
    params[@"page"] = @(self.page);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",hostUrl,self.urlStr];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        if ([responseObject[@"code"] integerValue] == 1) { // 数据加载成功
            self.orderArr = [ZDXStoreOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.orderArr.count > 0) {
        return self.orderArr.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderArr.count > 0) {
        ZDXStoreOrderModel *orderModel = self.orderArr[section];
        return orderModel.list.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.orderArr.count>0) {
        ZDXStoreMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellID];
        cell.orderModel = self.orderArr[indexPath.section];
        return cell;
    }
    ZDXStoreNoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:noCellID];
    cell.Img.image = [UIImage imageNamed:@"无订单"];
    cell.title.text = @"您还没有订单";
    cell.ImgW.constant = 187;
    cell.ImgH.constant = 180;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderArr.count>0) {
        ZDXStoreOrderModel *orderModel = self.orderArr[indexPath.section];
        [MBProgressHUD showMessage:@""];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = @(orderModel.orderId);
        params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/detail",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            ZDXStoreOrderDetailModel *model = [ZDXStoreOrderDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            ZDXStoreOrderStatusViewController *vc = [[ZDXStoreOrderStatusViewController alloc] init];
            vc.isBatch = 0;
            vc.orderDetailModel = model;
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderArr.count > 0) {
        return 128;
    }
    return SCREEN_HEIGHT - 64 - self.topView.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.orderArr.count > 0) {
        return 50;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.orderArr.count > 0) {
        
        ZDXStoreMyOrderHeaderView *view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZDXStoreMyOrderHeaderView"];
        ZDXStoreOrderModel *model = self.orderArr[section];
        view.orderModel = model;
        return view;
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.orderArr.count > 0) {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.orderArr.count > 0) {
        ZDXStoreOrderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZDXStoreOrderFooterView"];
        view.delegate = self;
        ZDXStoreOrderModel *orderModel = self.orderArr[section];
        view.orderModel = orderModel;
        return view;
    }
    return [UIView new];
    
}
#pragma mark - footerView Delegate
-(void)selectedOrderModel:(ZDXStoreOrderModel *)orderModel withType:(NSString *)type{
    if ([type isEqualToString:@"取消订单"]) {
        [MBProgressHUD showMessage:@""];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"orderNo" : orderModel.orderNo, @"userId" : @([ZDXStoreUserModelTool userModel].userId)};
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/userCancel",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 1) {
                [self.tableView.mj_header beginRefreshing];
                [self reloadOrder];
                
            }
            [MBProgressHUD hideHUD];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];

        }];
    }
    NSLog(@"%@ %@",orderModel, type);
}

-(void)toPushViewWithOrderModel:(ZDXStoreOrderModel *)orderModel{
    [MBProgressHUD showMessage:@""];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = @(orderModel.orderId);
    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/detail",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        ZDXStoreOrderDetailModel *model = [ZDXStoreOrderDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        if (model.orderStatus == 0) { // 待发货
            ZDXStoreRefundViewController *vc = [[ZDXStoreRefundViewController alloc] init];
            vc.orderDetailModel = model;
         
            [self.navigationController pushViewController:vc animated:YES];
        }else if (model.orderStatus == 1){ // 待收货
            [self confirmGoods:model];
            NSLog(@"aa");
            
        }else if (model.orderStatus == -2){
            ZDXStoreOrderStatusViewController *vc = [[ZDXStoreOrderStatusViewController alloc] init];
            vc.isBatch = 0;
            vc.orderDetailModel = model;
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if (model.isAppraise == 0) {
                ZDXStoreOrderAppraiseViewController *vc = [[ZDXStoreOrderAppraiseViewController alloc] init];
                vc.orderDetailModel = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        
    }];
    
    
    
}

// 获取订单详细信息
-(void)reloadOrderDetailInfo:(ZDXStoreOrderModel *)orderModel{
    
}

// 确认收货
-(void)confirmGoods:(ZDXStoreOrderDetailModel *)model{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"orderId" : @(model.orderId), @"userId" : @([ZDXStoreUserModelTool userModel].userId)};
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/receive",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
