
//
//  ZDXStoreCommdityDetailController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/31.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreCommdityDetailController.h"
#import "ZDXComnous.h"
#import "ZDXStoreTableViewHeaderView.h"
#import "ZDXStoreCommdityDetailInfoCell.h"
#import "ZDXStoreCommdityCommentCell.h"
#import "ZDXStoreFooterView.h"
#import "ZDXStoreShopModel.h"
#import "ZDXStoreGoodsDescCell.h"
#import "ZDXStoreShopViewController.h"
#import "ZDXStoreFillInOrderViewController.h"
#import "ZDXStoreLoginViewController.h"
#import "ZDXStoreCommentViewController.h"

static NSString *commdityCommentCellID = @"commdityCommentCell";
static NSString *goodsDescCellID = @"goodsDescCell";
@interface ZDXStoreCommdityDetailController ()<UITableViewDataSource, UITableViewDelegate, ZDXStoreFooterViewDelegate, ZDXStoreCommdityCommentCellDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ZDXStoreTableViewHeaderView *headerView;

@property (strong, nonatomic)ZDXStoreCommdityDetailInfoCell *commdityInfoCell;

@property (strong, nonatomic)ZDXStoreGoodsDescCell *goodsDescCell;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;

@end

@implementation ZDXStoreCommdityDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品页";
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.userModel = [ZDXStoreUserModelTool userModel];
    
    // 加载数据
    [self reloadData];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置tableView
    [self setupTableView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewLoadFinish) name:@"NSNotificationWebViewDidFinishLoad" object:nil];
}

-(void)webViewLoadFinish{
    [self.tableView reloadData];
}

// 加载数据
-(void)reloadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"goodsId" : [NSString stringWithFormat:@"%ld",self.goodsModel.goodsId]};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Goods/goodsDetails",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject[@"data"];
        self.goodsModel = [ZDXStoreGoodsModel mj_objectWithKeyValues:data];
        self.headerView.dataList = self.goodsModel.gallery;

        NSString *htmlStr = data[@"goodsDesc"];
//        NSLog(@"%@",htmlStr);
        NSData *data1 = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
        
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data1];
        NSArray *elements  = [xpathParser searchWithXPathQuery:@"//img"];
//        NSLog(@"%@",elements);
        for (TFHppleElement *hppleElement in elements) {
//            NSArray *imageArr = [hppleElement searchWithXPathQuery:@"//img"];
//            for (TFHppleElement *tempElement in imageArr) {
            NSString *imgStr = [hppleElement objectForKey:@"src/"];
//            NSLog(@"%@",imgStr);
//            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setHeaderView:[ZDXStoreTableViewHeaderView headerView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2 - 80)]];

    [tableView setTableHeaderView:self.headerView];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreCommdityCommentCell" bundle:nil] forCellReuseIdentifier:commdityCommentCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreGoodsDescCell" bundle:nil] forCellReuseIdentifier:goodsDescCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    ZDXStoreFooterView *footerView = [[ZDXStoreFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_HEIGHT, 49)];
    footerView.delegate = self;
    [self.view addSubview:footerView];
}

// 设置导航栏
-(void)setupNav{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"客服标志"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarClick)];
}

// 客服点击
-(void)rightBarClick{
    
}


#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ZDXStoreCommdityDetailInfoCell *cell = [ZDXStoreCommdityDetailInfoCell initWithCommdityDetailWithTableView:tableView cellForRowAtIndexPath:indexPath];
        cell.goodsModel = self.goodsModel;
        self.commdityInfoCell = cell;
        return cell;
    }
    
    if (indexPath.row == 1) {
        ZDXStoreCommdityCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commdityCommentCellID];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.row == 2) {
        ZDXStoreGoodsDescCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsDescCellID];
        cell.htmlStr = self.goodsModel.goodsDesc;
        self.goodsDescCell = cell;
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
    if (indexPath.row == 0) {
        return self.commdityInfoCell.cellH;
    }else if (indexPath.row == 1){
        return 155;
    }else if (indexPath.row == 2){
        return self.goodsDescCell.cellH;
    }
    return 0;
}

#pragma mark - footerView delegate
// 加入购物车
-(void)addShopcar{
    if (self.userModel) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = [NSString stringWithFormat:@"%ld",self.userModel.userId];
        params[@"goodsId"] = [NSString stringWithFormat:@"%ld",self.goodsModel.goodsId];
        params[@"buyNum"] = @1;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Carts/addCart",hostUrl];
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        ZDXStoreLoginViewController *vc = [[ZDXStoreLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

// 立即购买
-(void)buyGoods{
    [MBProgressHUD showMessage:@"正在提交"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"userId"] = @(self.userModel.userId);
    parmas[@"num"] = @1;
    parmas[@"goodsId"] = @(self.goodsModel.goodsId);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Goods/purchaseImmediately",hostUrl];
    [manager POST:urlStr parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",responseObject);
        NSArray *arr = [ZDXStoreShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carts"][@"carts"]];
        ZDXStoreFillInOrderViewController *vc = [[ZDXStoreFillInOrderViewController alloc] init];
        vc.dataList = arr;
        vc.isCarts = 0;
        vc.goodsTotalMoney = [responseObject[@"data"][@"carts"][@"goodsTotalMoney"] integerValue];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

    }];
    
    
}

// 收藏
-(void)addCollection:(BOOL)isSelected{
    if (self.userModel) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"type"] = @"0";
        params[@"id"] = [NSString stringWithFormat:@"%ld",self.goodsModel.goodsId];
        params[@"userId"] = [NSString stringWithFormat:@"%ld",self.userModel.userId];
        
        if (isSelected) { // 收藏
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/add",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }else{ // 取消收藏
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/cancel",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }
    
}

// footerLeftClick
-(void)footerViewLeftClickType:(NSInteger)type collectIsSelected:(BOOL)isSelected{
    // 用户信息

    if (type == 1) { // 店铺
        ZDXStoreShopViewController *vc = [[ZDXStoreShopViewController alloc] init];
        vc.goodsModel = self.goodsModel;
        [self.navigationController pushViewController:vc animated:YES];
        
        NSLog(@"店铺");
    }else if (type == 2){ // 购物车
        NSLog(@"购物车");
    }else{
        
        [self addCollection:isSelected];
        NSLog(@"收藏");
    }
}

#pragma mark - cell Delegate
// 查看全部评论
-(void)selectedCommentClick{
    ZDXStoreCommentViewController *vc = [[ZDXStoreCommentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
