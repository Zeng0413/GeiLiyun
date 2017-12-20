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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    ZDXStoreUserModel *model = [ZDXStoreUserModelTool userModel];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSDictionary *params = @{@"page" : @1,@"userId" : @(model.userId)};
//    [manager POST:@"http://glys.wuliuhangjia.com/api/v1.Favorites/listGoodsQuery" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
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
