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

static NSString *paySendTypeCellID = @"PaySendTypeCell";
@interface ZDXStoreOrderStatusViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *tableViewTopView;

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreOrderPayAddressCell *payAddressCell;
@property (strong, nonatomic) ZDXStoreOrderPayGoodsCell *payGoodsCell;

@property (weak, nonatomic) ZDXStorePayTypePushView *pushView;
@end

@implementation ZDXStoreOrderStatusViewController

//-(UIView *)tableViewTopView{
//    if (!_tableViewTopView) {
//        _tableViewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
//        
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    self.view.backgroundColor = colorWithString(@"#f4f4f4");
    
    self.pushView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 212);
    [self.view addSubview:self.pushView];
    // 设置tableView
    [self setupTableView];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 2;
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
    [cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:cancelOrderBtn];
    
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
    imageView.image = [UIImage imageNamed:@"等待付款图片"];
    [tableView setTableHeaderView:imageView];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 去付款
-(void)payClick{
    ZDXStorePayTypePushView *pushView = [ZDXStorePayTypePushView payTypePushView];
    [UIView animateWithDuration:0.5 animations:^{
        pushView.y = SCREEN_HEIGHT - 212;
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:pushView];
//    [MBProgressHUD showMessage:@""];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"type"] = @(self.type);
//    params[@"payFrom"] = @1;
//    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
//    params[@"isBatch"] = @(self.isBatch);
//    params[@"orderId"] = self.orderId;
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@api/Pay/tunePay",hostUrl];
//    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUD];
//        if ([responseObject[@"code"] integerValue] == 1) {
//            NSString *payStr = responseObject[@"data"][@"data"][@"pay"];
//            
//            NSString *schemeSre = @"GeLiStoreAliPay";
//            if (payStr.length > 0) {
//                [[AlipaySDK defaultService] payOrder:payStr fromScheme:schemeSre callback:^(NSDictionary *resultDic) {
//                    NSLog(@"%@",resultDic);
//                }];
//            }
//            
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD hideHUD];
//    }];
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.dataList.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreOrderPayAddressCell *cell = [ZDXStoreOrderPayAddressCell initWithTableView:tableView cellWithAtIndexPath:indexPath];
        cell.model = self.consigneeInfoModel;
        self.payAddressCell = cell;
        return cell;
    }
    if (indexPath.section == 1){
        ZDXStoreOrderPayGoodsCell *cell = [ZDXStoreOrderPayGoodsCell initWithPayGoodsTableView:tableView cellForRowAtIndexPath:indexPath];
        cell.goodsModel = self.dataList[indexPath.row];
        self.payGoodsCell = cell;
        return cell;
    }else{
        ZDXStoreOrderPaySendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:paySendTypeCellID];
        cell.orderId.text = [NSString stringWithFormat:@"订单编号：%@",self.orderId];
        cell.price.text = [NSString stringWithFormat:@"¥%ld",self.totalMoney];
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
