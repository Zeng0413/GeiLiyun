//
//  ZDXStoreConsignnnerInfoViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/30.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreConsignnnerInfoViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreEditAddressViewController.h"
#import "ZDXStoreNoConsigneeInfoCell.h"
#import "ZDXStoreConsigneeInfoModel.h"
#import "ZDXStoreConsignnerInfoCell.h"
#import "ZDXStoreUserModelTool.h"

static NSString *NoConsigneeInfoCellID = @"NoConsigneeInfoCell";

@interface ZDXStoreConsignnnerInfoViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreNoConsigneeInfoCellDelegate, ZDXStoreConsignnerInfoCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) UIButton *bottomBtn;

@property (strong, nonatomic) ZDXStoreConsignnerInfoCell *consigneeInfoCell;
@end

@implementation ZDXStoreConsignnnerInfoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 加载数据
    [self loadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"收货人信息";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    
    [self setupNav];
    
    [self setupBottomView];
}
-(void)setupBottomView{
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.x = 0;
    self.bottomBtn.width = SCREEN_WIDTH;
    self.bottomBtn.height = 44;
    self.bottomBtn.y = SCREEN_HEIGHT - 44;
    [self.bottomBtn setBackgroundColor:colorWithString(@"#f95865")];
    [self.bottomBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [self.bottomBtn setImage:[UIImage imageNamed:@"新增地址"] forState:UIControlStateNormal];
    self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 11);
    [self.view addSubview:self.bottomBtn];
    
    self.bottomBtn.hidden = YES;
}

-(void)loadData{
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userId" : @(userModel.userId)};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/listAddress",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        
        if ([responseObject[@"code"] integerValue] == 1) {
            self.dataList = [ZDXStoreConsigneeInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            self.bottomBtn.hidden = NO;
        }else{
            self.bottomBtn.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


-(void)setupNav{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 + 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = colorWithString(@"#f5f5f5");
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreNoConsigneeInfoCell" bundle:nil] forCellReuseIdentifier:NoConsigneeInfoCellID];
    [self.view addSubview:self.tableView];

}

// 新增收获地址
-(void)addAddress{
    ZDXStoreEditAddressViewController *vc = [[ZDXStoreEditAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataList.count != 0) {
        return self.dataList.count;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataList.count != 0) {
        ZDXStoreConsignnerInfoCell *cell = [ZDXStoreConsignnerInfoCell initWithConsigneeTableView:tableView cellForRowAtIndexPath:indexPath];
        cell.model = self.dataList[indexPath.row];
        cell.delegate = self;
        self.consigneeInfoCell = cell;
        return cell;
    }
    
    ZDXStoreNoConsigneeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NoConsigneeInfoCellID];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count != 0) {
        return self.consigneeInfoCell.cellH;
    }
    
    return SCREEN_HEIGHT - 64;
}



-(void)addNewAddress{
    ZDXStoreEditAddressViewController *vc = [[ZDXStoreEditAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


// 用户操作
-(void)consigneeInfoOperationType:(NSString *)typeStr consigneeInfoModel:(ZDXStoreConsigneeInfoModel *)model{
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = @(model.addressId);
    params[@"userId"] = @(userModel.userId);
    
    if ([typeStr isEqualToString:@"默认地址"]) {
        
        [MBProgressHUD showMessage:@""];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/setDefault",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"code"] integerValue] == 1) {
                [self loadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }else if ([typeStr isEqualToString:@"编辑"]){
        ZDXStoreEditAddressViewController *vc = [[ZDXStoreEditAddressViewController alloc] init];
        vc.consigneeInfoModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [MBProgressHUD showMessage:@""];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/del",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"code"] integerValue] == 1) {
                [self loadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}
@end
