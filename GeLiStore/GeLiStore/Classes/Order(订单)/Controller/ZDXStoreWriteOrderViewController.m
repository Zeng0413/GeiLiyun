//
//  ZDXStoreWriteOrderViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreWriteOrderViewController.h"
#import "ZDXStoreOrderAddressDefaultCell.h"
#import "ZDXStoreOrderGoodsShowCell.h"
#import "ZDXStoreConsignnnerInfoViewController.h"
#import "ZDXStoreUserModelTool.h"
#import "ZDXComnous.h"
#import "ZDXStoreConsigneeInfoModel.h"
#import "ZDXStoreOrderAddressCell.h"

static NSString *orderAddressCellID = @"orderAddressCell";
static NSString *orderAddressDefaultCellID = @"orderAddressDefaultCell";
static NSString *orderGoodsShowCellID = @"OrderGoodsShowCell";
@interface ZDXStoreWriteOrderViewController ()

@property (strong ,nonatomic) ZDXStoreConsigneeInfoModel *consigneeInfoModel;

@end

@implementation ZDXStoreWriteOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 获取默认地址
    [self setupDefaultAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressDefaultCell" bundle:nil] forCellReuseIdentifier:orderAddressDefaultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderGoodsShowCell" bundle:nil] forCellReuseIdentifier:orderGoodsShowCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressCell" bundle:nil] forCellReuseIdentifier:orderAddressCellID];
}

// 获取默认地址
-(void)setupDefaultAddress{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userId" : @([ZDXStoreUserModelTool userModel].userId)};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/getUserDefaultAddress",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
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
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.consigneeInfoModel) {
            ZDXStoreOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressCellID];
            return cell;
        }else{
            ZDXStoreOrderAddressDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressDefaultCellID];
            return cell;
        }
        
    }
    if (indexPath.section == 1) {
        ZDXStoreOrderGoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsShowCellID];
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
            return 104;
        }else{
            return 59;
        }
    }else if (indexPath.section == 1){
        return 107;
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
