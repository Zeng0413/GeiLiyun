//
//  ZDXStoreSearchGoodsViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreSearchGoodsViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreFiltrateViewController.h"

@interface ZDXStoreSearchGoodsViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *searchReaultList;
@property (weak, nonatomic) UITableView *tableView;



@end

@implementation ZDXStoreSearchGoodsViewController

-(NSMutableArray *)searchReaultList{
    if (!_searchReaultList) {
        _searchReaultList = [NSMutableArray array];
    }
    return _searchReaultList;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置状态栏
    [self setupSatesAndNav];
    
    // 设置tableView
    [self setupTableView];

}

-(void)setupSatesAndNav{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, STATE_HEIGHT, SCREEN_WIDTH, 53)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    // 下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, navView.height-1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [navView addSubview:lineView];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(34, 0, SCREEN_WIDTH - 34, navView.height)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate = self;
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.showsCancelButton = NO;
    searchBar.placeholder = @"请输入商品名";
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索框"] forState:UIControlStateNormal];
    [navView addSubview:searchBar];
    self.searchBar = searchBar;

    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.width = 13;
    backBtn.height = 21;
    backBtn.x = 10;
    backBtn.y = navView.height / 2 - backBtn.height / 2;
    [backBtn setImage:[UIImage imageNamed:@"返回箭头"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];

}

// 设置tableView
-(void)setupTableView{
    CGFloat statheight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, statheight + 53, SCREEN_WIDTH, SCREEN_HEIGHT - statheight - 53)];
    //    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indetifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetifer];
    }
    cell.textLabel.text = @"";
    return cell;
}

-(void)backClick{
    [self.searchBar endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
}

#pragma mark - searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [MBProgressHUD showMessage:@""];
    ZDXStoreFiltrateViewController *vc = [[ZDXStoreFiltrateViewController alloc] init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @1;
    params[@"type"] = @1;
    params[@"keyword"] = searchBar.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Search/keywordSearch",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        NSMutableArray *classifyArr = [NSMutableArray array];
        classifyArr = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.dataList = classifyArr;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

    }];
    
}

@end
