//
//  ZDXStoreFillInOrderViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFillInOrderViewController.h"
#import "ZDXStoreOrderAddressDefaultCell.h"
#import "ZDXStoreOrderGoodsShowCell.h"
#import "ZDXStoreConsignnnerInfoViewController.h"
#import "ZDXStoreUserModelTool.h"
#import "ZDXComnous.h"
#import "ZDXStoreConsigneeInfoModel.h"
#import "ZDXStoreOrderAddressCell.h"
#import "ZDXStoreDeliveryInstallCell.h"
#import "ZDXStoreRebateCell.h"
#import "ZDXStoreOrderGoodsCountTableViewCell.h"
#import "ZDXStoreSubmitOrderBottomView.h"
#import "ZDXStoreOrderStatusViewController.h"

#import "ZDXStoreShopModel.h"

static NSString *orderAddressCellID = @"orderAddressCell";
static NSString *orderAddressDefaultCellID = @"orderAddressDefaultCell";
static NSString *orderGoodsShowCellID = @"OrderGoodsShowCell";
static NSString *deliveryInstallCellID = @"DeliveryInstallCell";
static NSString *rebateCellID = @"rebateCell";
static NSString *orderGoodsCountCellID = @"orderGoodsCountCell";

@interface ZDXStoreFillInOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong ,nonatomic) ZDXStoreConsigneeInfoModel *consigneeInfoModel;

@property (strong, nonatomic) NSMutableArray *goodsArr;

@property (weak, nonatomic) ZDXStoreSubmitOrderBottomView *bottomView;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;
@end

@implementation ZDXStoreFillInOrderViewController

-(NSMutableArray *)goodsArr{
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 获取默认地址
    [self setupDefaultAddress];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    
    // 用户信息
    self.userModel = [ZDXStoreUserModelTool userModel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (ZDXStoreShopModel *shopModel in self.dataList) {
        for (ZDXStoreGoodsModel *goodsModel in shopModel.list) {
            goodsModel.shopName = shopModel.shopName;
            [self.goodsArr addObject:goodsModel];
        }
    }
    
    [self setupTableView];

    [self setupBottomView];
}

-(void)setupBottomView{
    ZDXStoreSubmitOrderBottomView *view = [ZDXStoreSubmitOrderBottomView view];
    view.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    view.goodsPrice = [NSString stringWithFormat:@"%ld",self.goodsTotalMoney];
    
    view.block = ^{
        [MBProgressHUD showMessage:@"正在提交..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]
        ;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"s_addressId"] = @(self.consigneeInfoModel.addressId);
        params[@"deliverType"] = @0;
        params[@"payType"] = @1;
        params[@"userId"] = @(self.userModel.userId);
        params[@"isCarts"] = @(self.isCarts);
        
        NSString *ids = @"";
        for (int i = 0; i < self.goodsArr.count; i++) {
            ZDXStoreGoodsModel *goodsModel = self.goodsArr[i];
            ids = [ids stringByAppendingString:[NSString stringWithFormat:@"%ld,",goodsModel.goodsId]];
        }
        ids = [ids substringToIndex:([ids length] - 1)];
        
        params[@"goodsId"] = ids;
        params[@"num"] = @(self.dataList.count);
        params[@"orderSrc"] = @3;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/submit",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            if ([responseObject[@"code"] integerValue] == 1) { // 订单提交成功
                
                ZDXStoreOrderStatusViewController *vc = [[ZDXStoreOrderStatusViewController alloc] init];
                vc.orderId = responseObject[@"data"][@"data"];
                vc.consigneeInfoModel = self.consigneeInfoModel;
                vc.dataList = self.goodsArr;
                vc.type = 1;
                vc.isBatch = 1;
                vc.totalMoney = self.goodsTotalMoney;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:responseObject[@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];

        }];
        
        
    };
    
    [self.view addSubview:view];
    self.bottomView = view;
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = colorWithString(@"#f5f5f5");
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressDefaultCell" bundle:nil] forCellReuseIdentifier:orderAddressDefaultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderGoodsShowCell" bundle:nil] forCellReuseIdentifier:orderGoodsShowCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressCell" bundle:nil] forCellReuseIdentifier:orderAddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreDeliveryInstallCell" bundle:nil] forCellReuseIdentifier:deliveryInstallCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRebateCell" bundle:nil] forCellReuseIdentifier:rebateCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderGoodsCountTableViewCell" bundle:nil] forCellReuseIdentifier:orderGoodsCountCellID];
    
    [self.view addSubview:self.tableView];
}

// 获取默认地址
-(void)setupDefaultAddress{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userId" : @(self.userModel.userId)};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/getUserDefaultAddress",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            self.bottomView.submitBtnIsSelected = YES;
            self.consigneeInfoModel = [ZDXStoreConsigneeInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.goodsArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.consigneeInfoModel) {
            ZDXStoreOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressCellID];
            cell.model = self.consigneeInfoModel;
            return cell;
        }else{
            ZDXStoreOrderAddressDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressDefaultCellID];
            return cell;
        }
        
    }
    if (indexPath.section == 1) {
        ZDXStoreOrderGoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsShowCellID];
        cell.goodsModel = self.goodsArr[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 2) {
        ZDXStoreDeliveryInstallCell *cell = [tableView dequeueReusableCellWithIdentifier:deliveryInstallCellID];
        return cell;
    }
    
    if (indexPath.section == 3) {
        ZDXStoreRebateCell *cell = [tableView dequeueReusableCellWithIdentifier:rebateCellID];
        return cell;
    }
    
    if (indexPath.section == 4) {
        ZDXStoreOrderGoodsCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsCountCellID];
        cell.goodsPrice = [NSString stringWithFormat:@"%ld件 ¥%ld",self.goodsArr.count,self.goodsTotalMoney];
        cell.originPrice = [NSString stringWithFormat:@"¥%ld",self.goodsTotalMoney];
        return cell;
    }
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    cell.textLabel.text = @"zdx";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.consigneeInfoModel) {
            return 99;
        }else{
            return 59;
        }
    }else if (indexPath.section == 1){
        return 107;
    }else if (indexPath.section == 2){
        return 146;
    }else if (indexPath.section == 3){
        return 68;
    }else if (indexPath.section == 4){
        return 87;
    }
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreConsignnnerInfoViewController *vc = [[ZDXStoreConsignnnerInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
