//
//  ZDXStoreShopViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreNavigationViewController.h"
#import "ZDXStoreShopHeaderView.h"
#import "ZDXStoreShopModel.h"
#import "ZDXStoreSelectedTopView.h"
#import "ZDXStoreShopGoodsCell.h"
#import "ZDXStoreLoginViewController.h"
#import "ZDXStoreCommdityDetailController.h"
@interface ZDXStoreShopViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreSelectedTopViewDelegate, ZDXStoreShopGoodsCellDelegate, ZDXStoreShopHeaderViewDelegate>
@property (weak, nonatomic) UITableView *tableView;

@property (weak, nonatomic) ZDXStoreShopHeaderView *shopHeaderView;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;

@property (strong, nonatomic) ZDXStoreShopModel *shopModel;

@property (weak, nonatomic) UITextField *searchTextField;

// 商品数据
@property (strong, nonatomic) NSMutableArray *goodsDataList;

@property (strong, nonatomic) ZDXStoreShopGoodsCell *shopGoodsCell;
@end

@implementation ZDXStoreShopViewController

-(NSMutableArray *)goodsDataList{
    if (!_goodsDataList) {
        _goodsDataList = [NSMutableArray array];
    }
    return _goodsDataList;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setStatusBarBackgroundColor:ZDXColor(23, 16, 30)];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userModel = [ZDXStoreUserModelTool userModel];
    
    // 初始化tableView
    [self setupTableView];
    
    // 加载数据
    [self reloadData];
    // Do any additional setup after loading the view.
}

// 加载数据
-(void)reloadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopId"] = @(self.shopId);
    params[@"userId"] = @(self.userModel.userId);
    params[@"page"] = @1;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Shops/shopHome",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *data = responseObject[@"data"];
        self.shopModel = [ZDXStoreShopModel mj_objectWithKeyValues:data[@"shop"]];
        self.shopHeaderView.shopModel = self.shopModel;
        
        if (self.shopModel.favShop != 0) {
            self.shopHeaderView.isSelected = YES;
        }else{
            self.shopHeaderView.isSelected = NO;
        }
        
        self.goodsDataList = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //    创建弹出框
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
    
}

// 初始化tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ZDXStoreShopHeaderView *shopHeaderView = [ZDXStoreShopHeaderView shopHeaderView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4 )];
    shopHeaderView.delegate = self;
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(32, 12 + STATE_HEIGHT, SCREEN_WIDTH - 32 - 31 - 9 - 10, 30)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    searchTextField.layer.borderWidth = 1.0;                                                     
    searchTextField.layer.cornerRadius = 10.0;
    
    searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索店内商品" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    searchTextField.textColor = [UIColor whiteColor];
    
    searchTextField.font = [UIFont systemFontOfSize:14];
    
    UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 26, 30)];
    leftView.backgroundColor = [UIColor clearColor];
    //添加图片
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 21, 20)];
    headView.image = [UIImage imageNamed:@"搜索按钮"];
    [leftView addSubview:headView];
    searchTextField.leftView = leftView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    [shopHeaderView addSubview:searchTextField];
    self.searchTextField = searchTextField;
    
    UIButton *classfiyBtn = [[UIButton alloc]init];
    classfiyBtn.width = 31;
    classfiyBtn.height = 15;
    classfiyBtn.x = SCREEN_WIDTH - 10 - classfiyBtn.width;
    classfiyBtn.centerY = searchTextField.centerY;
    [classfiyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [classfiyBtn setTitle:@"分类" forState:UIControlStateNormal];
    classfiyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shopHeaderView addSubview:classfiyBtn];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.width = 13;
    backBtn.height = 21;
    backBtn.x = 10;
    backBtn.centerY = searchTextField.centerY;
    [backBtn setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [shopHeaderView addSubview:backBtn];
    
    [tableView setTableHeaderView:shopHeaderView];
    self.shopHeaderView = shopHeaderView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreShopGoodsCell *cell = [ZDXStoreShopGoodsCell initWithShopGoodsTableView:tableView cellForRowAtIndexPath:indexPath];
    if (self.goodsDataList.count > 0) {
        cell.dataList = self.goodsDataList;
    }
    cell.delegate = self;
    self.shopGoodsCell = cell;
    return cell;
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
    return self.shopGoodsCell.cellH;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZDXStoreSelectedTopView *topView = [[ZDXStoreSelectedTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    topView.list = @[@"所有",@"新品",@"热销",@"促销"];
    topView.delegate = self;
    return topView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

#pragma mark - 收藏店铺
-(void)addCollectionShopIsSelected:(BOOL)isSelected{
    if (self.userModel) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"type"] = @"1";
        params[@"userId"] = [NSString stringWithFormat:@"%ld",self.userModel.userId];
        
        if (isSelected) { // 收藏
            params[@"id"] = [NSString stringWithFormat:@"%ld",self.shopModel.shopId];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/add",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }else{ // 取消收藏
            params[@"id"] = [NSString stringWithFormat:@"%ld",self.shopModel.favShop];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/cancel",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
        }
    }else{
        ZDXStoreLoginViewController *vc = [[ZDXStoreLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 商品选择
-(void)selectedClickGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    ZDXStoreCommdityDetailController *vc = [[ZDXStoreCommdityDetailController alloc] init];
    vc.goodsModel = goodsModel;
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - topView delegate
-(void)selectedTopViewSelected:(NSInteger)type{
    
}
@end
