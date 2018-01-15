//
//  ZDXStoreOrderStatusViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderStatusViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreOrderPayAddressCell.h"
#import "ZDXStoreOrderPayGoodsCell.h"
#import "ZDXStoreOrderPaySendTypeCell.h"
#import "ZDXStoreUserModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZDXStorePayTypePushView.h"
#import "WLRPushView4.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import "ZDXStoreRefundViewController.h"
#import "ZDXStoreOrderAppraiseViewController.h"

static NSString *paySendTypeCellID = @"PaySendTypeCell";
@interface ZDXStoreOrderStatusViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStorePayTypePushViewDelegate, WLRPushView4Delegate>

@property (strong, nonatomic) UIView *tableViewTopView;

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreOrderPayAddressCell *payAddressCell;
@property (strong, nonatomic) ZDXStoreOrderPayGoodsCell *payGoodsCell;

@property (strong, nonatomic) ZDXStorePayTypePushView *pushView;

@property (strong, nonatomic) UIView *coverView;

@property (strong, nonatomic) AppDelegate *appDelegate;
@end

@implementation ZDXStoreOrderStatusViewController
- (void) viewDidDisappear:(BOOL)animated
{
    [_appDelegate removeObserver:self forKeyPath:@"ZDXPayStatusCount"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    监听微信支付回调结果
    _appDelegate = [AppDelegate sharedApplicationDelegate];
    [_appDelegate addObserver:self forKeyPath:@"ZDXPayStatusCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    self.view.backgroundColor = colorWithString(@"#f4f4f4");
    
    // 支付方式弹出视图
    self.pushView = [ZDXStorePayTypePushView payTypePushView];
    self.pushView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 212);
    self.pushView.delegate = self;
    if (self.orderDetailModel) {
        self.pushView.payPrice = [self.orderDetailModel.totalMoney floatValue];
    }else{
        self.pushView.payPrice = self.totalMoney;
    }
    
    // 遮盖View
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.coverView.backgroundColor = colorWithString(@"#333333");
    self.coverView.alpha = 0.6;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.coverView addGestureRecognizer:tapGesture];
    
    
    
    // 设置tableView
    [self setupTableView];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 2;

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    if (self.orderDetailModel) { // 订单状态(-5:门店不同意退款；-4:门店同意退款；-3:用户拒收 -2:待付款 -1：用户取消 0:待发货 1:配送中 2:用户确认收货;3:申请退款；4:申请退货)
        if (self.orderDetailModel.orderStatus == -2) {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 1, btnW, bottomView.height)];
            payBtn.backgroundColor = colorWithString(@"#f95865");
            [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
            payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:payBtn];
            
            UIButton *cancelOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW * 2, 1, btnW, bottomView.height)];
            cancelOrderBtn.backgroundColor = colorWithString(@"#f4f4f4");
            [cancelOrderBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
            [cancelOrderBtn addTarget:self action:@selector(cancelOrderClick) forControlEvents:UIControlEventTouchUpInside];
            [cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [bottomView addSubview:cancelOrderBtn];
            
        }else if (self.orderDetailModel.orderStatus == 0){
            UIButton *refundBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 1, btnW, bottomView.height)];
            refundBtn.layer.borderWidth = 1.0;
            refundBtn.layer.borderColor = colorWithString(@"#f4f4f4").CGColor;
            refundBtn.backgroundColor = [UIColor whiteColor];
            [refundBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
            [refundBtn setTitle:@"退款" forState:UIControlStateNormal];
            [refundBtn addTarget:self action:@selector(refundClick) forControlEvents:UIControlEventTouchUpInside];
            refundBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [bottomView addSubview:refundBtn];
    
        }else if (self.orderDetailModel.orderStatus == 1){
            UIButton *confirmCargoBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 1, btnW, bottomView.height)];
            confirmCargoBtn.backgroundColor = colorWithString(@"#f95865");
            [confirmCargoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [confirmCargoBtn addTarget:self action:@selector(confirmSH) forControlEvents:UIControlEventTouchUpInside];
            [confirmCargoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            confirmCargoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//            [confirmCargoBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:confirmCargoBtn];
            
            UIButton *cancelCargoBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW * 2, 1, btnW, bottomView.height)];
            cancelCargoBtn.backgroundColor = colorWithString(@"#f4f4f4");
            [cancelCargoBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
            [cancelCargoBtn setTitle:@"退货" forState:UIControlStateNormal];
            cancelCargoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [bottomView addSubview:cancelCargoBtn];
        }else{
            if (self.orderDetailModel.isAppraise == 0) {
                UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 1, btnW, bottomView.height)];
                commentBtn.backgroundColor = colorWithString(@"#f95865");
                [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [commentBtn setTitle:@"去评价" forState:UIControlStateNormal];
                commentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                [commentBtn addTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:commentBtn];
            }
        }
    }else{
        CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 2;
        UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 1, btnW, bottomView.height)];
        payBtn.backgroundColor = colorWithString(@"#f95865");
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
        payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:payBtn];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = colorWithString(@"#f6f6f6");
    [bottomView addSubview:lineView];
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderPaySendTypeCell" bundle:nil] forCellReuseIdentifier:paySendTypeCellID];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5)];
    if (self.orderDetailModel.orderStatus == 0){
        imageView.image = [UIImage imageNamed:@"等待发货"];

    }else if (self.orderDetailModel.orderStatus == 1){
        imageView.image = [UIImage imageNamed:@"商家已发货"];

    }else if (self.orderDetailModel.orderStatus == -2){
        imageView.image = [UIImage imageNamed:@"等待付款图片"];
    }else{
        if (self.orderDetailModel.isAppraise == 0) {
            // 待评价
            imageView.image = [UIImage imageNamed:@"交易成功"];
        }
    }
    [tableView setTableHeaderView:imageView];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


#pragma mark - payPushView delegate
-(void)hidePayTypePushView{
    [UIView animateWithDuration:0.5 animations:^{
        self.pushView.y += self.pushView.height;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.pushView removeFromSuperview];
    }];
}


// 去评价
-(void)toComment{
    ZDXStoreOrderAppraiseViewController *vc = [[ZDXStoreOrderAppraiseViewController alloc] init];
    vc.orderDetailModel = self.orderDetailModel;
    [self.navigationController pushViewController:vc animated:YES];
}
// 退款
-(void)refundClick{
    ZDXStoreRefundViewController *vc = [[ZDXStoreRefundViewController alloc] init];
    vc.orderDetailModel = self.orderDetailModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickPayType:(NSInteger)type{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @(self.type);
    params[@"payFrom"] = @(type);
    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
    params[@"isBatch"] = @(self.isBatch);
    if (self.orderDetailModel) {
        params[@"orderId"] = @(self.orderDetailModel.orderId);
    }else{
        params[@"orderId"] = self.orderId;
    }
    if (type == 1) { // 支付宝
        [MBProgressHUD showMessage:@""];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        NSString *urlStr = [NSString stringWithFormat:@"%@api/Pay/tunePay",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            if ([responseObject[@"code"] integerValue] == 1) {
                NSString *payStr = responseObject[@"data"][@"data"][@"pay"];

                NSString *schemeSre = @"GeLiStoreAliPay";
                if (payStr.length > 0) {
                    [[AlipaySDK defaultService] payOrder:payStr fromScheme:schemeSre callback:^(NSDictionary *resultDic) {
                        if ([resultDic[@"resultStatus"] intValue] == 9000) {
                            WLRPushView4 *view = [WLRPushView4 view];
                            view.delegate = self;
                            view.frame = self.view.bounds;
                            [self.view addSubview:view];
                            view.statusImage.image = [UIImage imageNamed:@"接单成功"];
                            view.statusLabel.text = @"支付成功";
                        }else{
                            WLRPushView4 *view = [WLRPushView4 view];
                            view.frame = self.view.bounds;
                            [self.view addSubview:view];
                            view.statusImage.image = [UIImage imageNamed:@"接单失败"];
                            view.statusLabel.text = @"支付失败";
                        }
                    }];
                }
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
        }];
    }else{ // 微信
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/Pay/tunePay",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = responseObject[@"data"][@"data"];
                
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = dict[@"partnerid"];
                request.prepayId = dict[@"prepayid"];
                request.package = dict[@"package"];
                request.nonceStr = dict[@"noncestr"];
                request.timeStamp= [dict[@"timestamp"] intValue];
                request.sign = dict[@"sign"];
                [WXApi sendReq:request];
                
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }];
    }
}

#pragma mark -- 监听微信回调计数变化

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"ZDXPayStatusCount"]) {
        
        
        if (_appDelegate.ZDXPayStatusCount == 1) {
            WLRPushView4 *view = [WLRPushView4 view];
            view.delegate =self;
            view.frame = self.view.bounds;
            [self.view addSubview:view];
            view.statusImage.image = [UIImage imageNamed:@"接单成功"];
            view.statusLabel.text = @"支付成功";
            
            
        }
        else if (_appDelegate.ZDXPayStatusCount == 2)
        {
            WLRPushView4 *view = [WLRPushView4 view];
            view.frame = self.view.bounds;
            [self.view addSubview:view];
            view.statusImage.image = [UIImage imageNamed:@"接单失败"];
            view.statusLabel.text = @"取消支付";
        }
        else
        {
            WLRPushView4 *view = [WLRPushView4 view];
            view.frame = self.view.bounds;
            [self.view addSubview:view];
            view.statusImage.image = [UIImage imageNamed:@"接单失败"];
            view.statusLabel.text = @"支付失败";
        }
        
    }
}

-(void)tapGesture{
    [UIView animateWithDuration:0.5 animations:^{
        self.pushView.y += self.pushView.height;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.pushView removeFromSuperview];
    }];
}

-(void)confirmSH{
    if (self.orderDetailModel) {
        [MBProgressHUD showMessage:@""];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *params = @{@"orderId" : @(self.orderDetailModel.orderId), @"userId" : @([ZDXStoreUserModelTool userModel].userId)};
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/receive",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 1) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            [MBProgressHUD hideHUD];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];

        }];
    }
    
}

-(void)cancelOrderClick{
    if (self.orderDetailModel) {
        [MBProgressHUD showMessage:@""];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"orderNo" : self.orderDetailModel.orderNo, @"userId" : @([ZDXStoreUserModelTool userModel].userId)};
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/userCancel",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 1) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            [MBProgressHUD hideHUD];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            
        }];
    }
    
}

// 去付款
-(void)payClick{
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.pushView];
    
    [UIView animateWithDuration:0.5 animations:^{
//        self.pushView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT - self.pushView.height);
        self.pushView.y -= self.pushView.height;
    }];

}
#pragma mark WLRPushView4代理
-(void)viewPopToRootVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        if (self.orderDetailModel) {
            return self.orderDetailModel.goods.count;
        }else{
            return self.dataList.count;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreOrderPayAddressCell *cell = [ZDXStoreOrderPayAddressCell initWithTableView:tableView cellWithAtIndexPath:indexPath];
        if (self.orderDetailModel) {
            cell.orderDetailModel = self.orderDetailModel;
        }else{
            cell.model = self.consigneeInfoModel;
        }
        self.payAddressCell = cell;
        return cell;
    }
    if (indexPath.section == 1){
        ZDXStoreOrderPayGoodsCell *cell = [ZDXStoreOrderPayGoodsCell initWithPayGoodsTableView:tableView cellForRowAtIndexPath:indexPath];
        if (self.orderDetailModel) {
            cell.goodsModel = self.orderDetailModel.goods[indexPath.row];
        }else{
            cell.goodsModel = self.dataList[indexPath.row];
        }
        self.payGoodsCell = cell;
        return cell;
    }else{
        ZDXStoreOrderPaySendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:paySendTypeCellID];
        if (self.orderDetailModel) {
            cell.orderId.text = [NSString stringWithFormat:@"订单编号：%@",self.orderDetailModel.orderNo];
            cell.price.text = [NSString stringWithFormat:@"¥%@",self.orderDetailModel.totalMoney];
        }else{
            cell.orderId.text = [NSString stringWithFormat:@"订单编号：%@",self.orderId];
            cell.price.text = [NSString stringWithFormat:@"¥%.2f",self.totalMoney];
        }
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.payAddressCell.cellH;
    }else if (indexPath.section == 1){
        return self.payGoodsCell.cellH;
    }else{
        return 223;
    }
    
}


@end
