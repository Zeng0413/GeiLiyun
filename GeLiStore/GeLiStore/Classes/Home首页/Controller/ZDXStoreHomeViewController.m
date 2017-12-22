//
//  ZDXStoreHomeViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreHomeViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreMainTopView.h"
#import "ZDXStoreTableViewHeaderView.h"
#import "ZDXStoreCommodityClassifyCell.h"
#import "ZDXStoreBrandChooseCell.h"
#import "ZDXStoreCommodityShowCell.h"
#import "ZDXStoreProductModel.h"
#import "ZDXComnous.h"
#import "ZDXStoreClassifyViewController.h"
#import "ZDXStoreCommdityDetailController.h"
#import "ZDXStoreBrandModel.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreGoodsClassifyModel.h"
#import "ZDXStoreSearchGoodsViewController.h"
#import <AlipaySDK/AlipaySDK.h>

static NSString *brandChooseCell = @"brandChooseCell";

@interface ZDXStoreHomeViewController ()<ZDXStoreMainTopViewDelegate,UITableViewDelegate,UITableViewDataSource, ZDXStoreCommodityClassifyCellDelegate, ZDXStoreCommodityShowCellDelegate>

// 导航控制器titleView
@property (strong, nonatomic) ZDXStoreMainTopView *topView;

@property (weak, nonatomic) UITableView *tableView;

// tableViewHeaderView
@property (strong, nonatomic) ZDXStoreTableViewHeaderView *headerView;

@property (strong, nonatomic) ZDXStoreCommodityClassifyCell *commodityClassifyCell;

@property (strong, nonatomic) ZDXStoreBrandChooseCell *brandChooseCell;

@property (strong, nonatomic) ZDXStoreCommodityShowCell *commodityShowCell;

// 商品数据
@property (strong, nonatomic) NSMutableArray *goodsDataList;

// 分类数据
@property (strong, nonatomic) NSArray *classifyDataList;


/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;


@property (nonatomic,assign) NSInteger page;

@end

@implementation ZDXStoreHomeViewController

-(NSMutableArray *)goodsDataList{
    if (!_goodsDataList) {
        _goodsDataList = [NSMutableArray array];
    }
    return _goodsDataList;
}

-(ZDXStoreMainTopView *)topView{
    if (!_topView) {
        _topView = [[ZDXStoreMainTopView alloc] initWithFrame:CGRectMake(0, 0, 125, 19)];
        _topView.delegate = self;
    }
    return _topView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {    
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = ZDXRandomColor;
    
    self.page = 1;
    // 导航栏设置
    [self setupNav];
    
    // tableview设置
    [self setupTableView];

    // 回到顶部按钮
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 110, 40, 40);
    
    
    
    // 加载品牌数据
    [self reloadBrandData];
    
    // 加载商品数据
    [self reloadGoodsData];
    
    // 加载分类数据
    [self reloadClassifyData];
}

// 加载分类数据
-(void)reloadClassifyData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Cat/homeFirstCat",hostUrl];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            self.classifyDataList = [ZDXStoreGoodsClassifyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 加载商品数据
-(void)reloadGoodsData{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"page" : [NSString stringWithFormat:@"%ld",_page]};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Goods/homeGoods",hostUrl];
    [manage POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            self.goodsDataList = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //    创建弹出框
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
    
}

// 加载品牌数据
-(void)reloadBrandData{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Brands/homeBrandRecommendation",hostUrl];
    [manage GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) { // 请求数据成功
            NSArray *array = [ZDXStoreBrandModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.brandChooseCell.arr = array;
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //    创建弹出框
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
}

// 加载更多数据
-(void)loadNewData{
    self.page++;
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{@"page" : [NSString stringWithFormat:@"%ld",self.page]};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Goods/homeGoods",hostUrl];
    [manage POST:urlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] integerValue] == 1) { // 请求数据成功
            NSArray *newDataList = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.goodsDataList addObjectsFromArray:newDataList];
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showSuccess:@"暂无更多订单"];
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //    创建弹出框
        [self.tableView.mj_footer endRefreshing];

        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
}

// 导航栏设置
-(void)setupNav{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.topView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索按钮"] style:UIBarButtonItemStyleDone target:self action:@selector(searchClick)];
}


// 搜索按钮事件
-(void)searchClick{
    ZDXStoreSearchGoodsViewController *vc = [[ZDXStoreSearchGoodsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
    NSLog(@"搜索");
//    [[AlipaySDK defaultService] payOrder:@"alipay_sdk=alipay-sdk-php-20161101&app_id=2017061907522300&biz_content=%7B%22body%22%3A%22payment_product%22%2C%22subject%22%3A+%22%E5%95%86%E5%93%81%E8%B4%AD%E4%B9%B0%22%2C%22extend_params%22%3A+%2230%401%22%2C%22out_trade_no%22%3A+%22151390664591976071%22%2C%22timeout_express%22%3A+%2230m%22%2C%22total_amount%22%3A+%22168.00%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fglys.wuliuhangjia.com%2Fapi%2FPay%2Fali_return&sign_type=RSA2&timestamp=2017-12-22+14%3A16%3A42&version=1.0&sign=nGASUKn%2BiSo1MLhqRPouOUJaSUy0IRf5Z2jFoz4X2ru2P0drece341OSc0TPgVtvFwzjDooPPX8O4x%2BeWL9uralCoN5a9ww457FQnsQ2YWWLA6xsNJPj2CI%2FU57Wolx%2BYsTH4Dj1mjccQ1zxYWtGafXzABrAvYZgVRk5Bld5etQNQxEd0jHBzVVXablGJ9X2RrqfFJsI%2B%2BGUR4%2FvwZoqNVoGNsBdpEMHnjOAl%2FLu4mVmpTlgGCjvaWVcq%2FeJ5XKIIbZQTp2zcYP9V5plELG1Vx6JgeyQG9imHHkvGUpEWBS1GygIFQrEt%2BXYaBupK7VVC94gF%2FKbVwD2KZHWNaVmJQ%3D%3D" fromScheme:@"GeLiStoreAliPay" callback:^(NSDictionary *resultDic) {
//        NSLog(@"%@",resultDic);
//    }];
}

#pragma mark - 选择城市
-(void)chooseCity{
    NSLog(@"选择城市");
}

// tableview设置
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setHeaderView:[ZDXStoreTableViewHeaderView headerView:CGRectMake(0, 0, SCREEN_WIDTH, 183)]];

    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Ads/homeCarouselAds",hostUrl];
    [manage GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.headerView.dataList = responseObject[@"data"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableView.mj_footer = footer;
    
    [tableView setTableHeaderView:self.headerView];
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreBrandChooseCell" bundle:nil] forCellReuseIdentifier:brandChooseCell];
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    [self.view addSubview:tableView];
    
    
    self.tableView = tableView;
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZDXStoreCommodityClassifyCell *cell = [ZDXStoreCommodityClassifyCell initWithCommodityClassifyTableView:tableView cellForRowAtIndexPath:indexPath];
        cell.delegate = self;
        if (self.classifyDataList.count > 0) {
            cell.dataList = self.classifyDataList;
        }
        self.commodityClassifyCell = cell;
        return cell;
    }else if (indexPath.row == 1) {
        ZDXStoreBrandChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:brandChooseCell];
        
        self.brandChooseCell = cell;
        return cell;
    }else{
        ZDXStoreCommodityShowCell *cell = [ZDXStoreCommodityShowCell initWithCommodityShowTableView:tableView cellForRowAtIndexPath:indexPath];
        if (self.goodsDataList.count>0) {
            cell.dataList = self.goodsDataList;
        }
        cell.delegate = self;
        self.commodityShowCell = cell;
        return cell;
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.commodityClassifyCell.cellH + 12.5;
    }else if (indexPath.row == 1){
        return self.brandChooseCell.cellH + 12;
    }
    else{
        return self.commodityShowCell.cellH;
    }
}

#pragma mark - cell delagate
#pragma mark 商品分类选择
-(void)selectedCommodityClassifyModel:(ZDXStoreGoodsClassifyModel *)model{
    ZDXStoreClassifyViewController *vc = [[ZDXStoreClassifyViewController alloc] init];
    vc.classifyStr = model.catName;
    vc.tableDataList = self.classifyDataList;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 商品选择
-(void)selectedClickGoodsModel:(ZDXStoreGoodsModel *)goodsModel{
    ZDXStoreCommdityDetailController *vc = [[ZDXStoreCommdityDetailController alloc] init];
    vc.goodsModel = goodsModel;
//    ZDXStoreTestViewController *vc = [[ZDXStoreTestViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > SCREEN_WIDTH) ? NO : YES;
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
@end
