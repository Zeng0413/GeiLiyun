//
//  ZDXStoreMeCollectionViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeCollectionViewController.h"
#import "ZDXStoreSelectedTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreCollectionGoodsCell.h"
#import "ZDXStoreCollectionStoreCell.h"
#import "ZDXStoreNoCollectionCell.h"
#import "ZDXStoreShopModel.h"
#import "ZDXStoreShopViewController.h"
static NSString *noCollectionCellID = @"noCollectionCellID";
static NSString *collectionGoodsCellID = @"CollectionGoodsCell";
static NSString *collectionStoreCellID = @"CollectionStoreCell";
@interface ZDXStoreMeCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreCollectionGoodsCellDelegate, ZDXStoreSelectedTopViewDelegate, ZDXStoreCollectionStoreCellDelegate>

@property (strong, nonatomic) NSMutableArray *dataList;
@property (weak, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UIButton *editButton;    /**< 编辑按钮 */

@property (strong, nonatomic) UIButton *selectedBtn;

@property (strong, nonatomic) UIButton *bottomBtn;


@property (strong, nonatomic) ZDXStoreCollectionGoodsCell *collectionGoodsCell;

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) NSMutableArray *goodsSelectedArr;

@property (strong, nonatomic) NSMutableArray *shopSelectedArr;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;

@property (assign, nonatomic) NSInteger num;

@property (nonatomic,assign) NSInteger page;

@property (assign, nonatomic) NSInteger type;
@end

@implementation ZDXStoreMeCollectionViewController

-(NSMutableArray *)goodsSelectedArr{
    if (!_goodsSelectedArr) {
        _goodsSelectedArr = [NSMutableArray array];
    }
    return _goodsSelectedArr;
}

-(NSMutableArray *)shopSelectedArr{
    if (!_shopSelectedArr) {
        _shopSelectedArr = [NSMutableArray array];
    }
    return _shopSelectedArr;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UIButton *)editButton {
    if (_editButton == nil){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 40, 40);
        [_editButton setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        
        _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

-(void)editButtonAction{
    self.isSelected = !self.isSelected;
    if (self.isSelected) {
        [self.editButton setTitle:@"完成" forState:UIControlStateNormal];
        self.tableView.height = self.tableView.height - self.bottomBtn.height;
        [self.view addSubview:self.bottomBtn];
    }else{
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.bottomBtn removeFromSuperview];
        self.tableView.height = self.tableView.height + self.bottomBtn.height;

    }
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"num"];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self addObserver:self forKeyPath:@"num" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    self.title = @"我的收藏";
    
    self.page = 1;
    
    self.type = 1; // 默认选择商品
    
    self.userModel = [ZDXStoreUserModelTool userModel];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = colorWithString(@"#f4f4f4");
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    // 收藏筛选View
    [self setupFiltrateView];
    
    // 设置tableView
    [self setupTableView];
    
    // 加载数据
    [self reloadGoodsData];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.x = 0;
    self.bottomBtn.width = SCREEN_WIDTH;
    self.bottomBtn.height = 44;
    self.bottomBtn.y = SCREEN_HEIGHT - 44;
    
    self.bottomBtn.enabled = NO;
    [self.bottomBtn setBackgroundColor:ZDXColor(255, 130, 142)];
    [self.bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
}



// 设置tableView
-(void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55+64, SCREEN_WIDTH, SCREEN_HEIGHT - 55 - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreNoCollectionCell" bundle:nil] forCellReuseIdentifier:noCollectionCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreCollectionGoodsCell" bundle:nil] forCellReuseIdentifier:collectionGoodsCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreCollectionStoreCell" bundle:nil] forCellReuseIdentifier:collectionStoreCellID];
    
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableView.mj_footer = footer;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

// 收藏筛选View
-(void)setupFiltrateView{
    ZDXStoreSelectedTopView *topView = [[ZDXStoreSelectedTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 55)];
    topView.list = @[@"商品",@"店铺",@"共享/二手特卖"];
    topView.delegate = self;
    [self.view addSubview:topView];
}


#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataList.count>0) {
        return self.dataList.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        if (self.type == 1) { // 商品
            ZDXStoreCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionGoodsCellID forIndexPath:indexPath];
            
            cell.goodsModel = self.dataList[indexPath.row];
            cell.delegate = self;
            if (self.isSelected) {
                [cell isEditStatus:YES];
            }else{
                [cell isEditStatus:NO];
            }
            self.collectionGoodsCell = cell;
            return cell;
        }else if (self.type == 2){ // 店铺
            ZDXStoreCollectionStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionStoreCellID];
            cell.shopModel = self.dataList[indexPath.row];
            cell.delegate = self;
            
            if (self.isSelected) {
                [cell isEditCollectionStore:YES];
            }else{
                [cell isEditCollectionStore:NO];
            }
            return cell;
        }
        
    }
    
    
    ZDXStoreNoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:noCollectionCellID];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        if (self.type == 1) {
            return 140;
        }else if (self.type == 2){
            return 102;
        }
    }
    
    return SCREEN_HEIGHT - 64 - 55;

}

// 删除收藏商品
-(void)deleteClick{
    [MBProgressHUD showMessage:@""];
    if (self.type == 1) { // 删除商品
        if (self.goodsSelectedArr.count == 1) {
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            ZDXStoreGoodsModel *goodsModel = self.goodsSelectedArr.firstObject;
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"type"] = @0;
            params[@"id"] = @(goodsModel.favoriteId);
            params[@"userId"] = @(self.userModel.userId);
            
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/cancel",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"code"] integerValue] == 1) {
                    [self.goodsSelectedArr removeAllObjects];
                    [self reloadGoodsData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }else{
            NSString *ids = @"";
            
            for (int i = 0; i < self.goodsSelectedArr.count; i++) {
                ZDXStoreGoodsModel *goodsModel = self.goodsSelectedArr[i];
                ids = [ids stringByAppendingString:[NSString stringWithFormat:@"%ld,",goodsModel.favoriteId]];
            }
            
            ids = [ids substringToIndex:([ids length] - 1)];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"type"] = @0;
            params[@"ids"] = ids;
            params[@"userId"] = @(self.userModel.userId);
            
            NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/batchCancel",hostUrl];
            [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"code"] integerValue] == 1) {
                    [self.goodsSelectedArr removeAllObjects];
                    [self reloadGoodsData];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }else if (self.type == 2){ // 删除店铺
        if (self.shopSelectedArr.count == 1) {
            [self cancelStore];
        }else{
            [self batchStore]; // 批量删除收藏店铺
        }
    }
    
}

#pragma mark -- KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"num"]) {
        if (_goodsSelectedArr.count > 0 || _shopSelectedArr.count > 0) {
            self.bottomBtn.backgroundColor = colorWithString(@"#f95865");
            self.bottomBtn.enabled = YES;
        }else{
            self.bottomBtn.backgroundColor = ZDXColor(255, 130, 142);
            self.bottomBtn.enabled = NO;
        }
    }
}

#pragma mark - storeCell delegate
// 进店
-(void)toShopBtnClick:(ZDXStoreShopModel *)shopModel{
    ZDXStoreShopViewController *vc = [[ZDXStoreShopViewController alloc] init];
    vc.shopId = shopModel.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)collectionStoreClick:(UITableViewCell *)storeCell{
    if (self.type == 2) {
        NSIndexPath *index = [self.tableView indexPathForCell:storeCell];
        ZDXStoreShopModel *shopModel = self.dataList[index.row];
        shopModel.isSelected = !shopModel.isSelected;
        [self.tableView reloadData];
    }
}

-(void)selectedStoreWithShopModel:(ZDXStoreShopModel *)shopModel selectedStatus:(BOOL)selectedStatus{
    if (selectedStatus) {
        [self.shopSelectedArr addObject:shopModel];
    }else{
        [self.shopSelectedArr removeObject:shopModel];
    }
    
    self.num++;
}

#pragma mark - goodsCell delegate
-(void)myTabClick:(UITableViewCell *)cell{
    if (self.type == 1) {
        NSIndexPath *indx = [self.tableView indexPathForCell:cell];
        ZDXStoreGoodsModel *goodsModel = self.dataList[indx.row];
        goodsModel.isSelected = !goodsModel.isSelected;
        [self.tableView reloadData];
    }
    
}
#pragma mark 商品选择
-(void)collectionGoodsWithModel:(ZDXStoreGoodsModel *)goodsModel selectedStatus:(BOOL)selectedStatus{
    
    if (selectedStatus) {
        [self.goodsSelectedArr addObject:goodsModel];
    }else{
        [self.goodsSelectedArr removeObject:goodsModel];
    }
    
    self.num++;
}



#pragma mark - filtrateView delegate
-(void)selectedTopViewSelected:(NSInteger)type{
    self.page = 1;
    [self.goodsSelectedArr removeAllObjects];
    [self.shopSelectedArr removeAllObjects];
    [self.dataList removeAllObjects];
    self.type = type;
    if (type == 1) {
        if (self.goodsSelectedArr.count>0) {
            self.bottomBtn.backgroundColor = colorWithString(@"#f95865");
            self.bottomBtn.enabled = YES;
        }else{
            self.bottomBtn.backgroundColor = ZDXColor(255, 130, 142);
            self.bottomBtn.enabled = NO;
        }
        // 加载收藏商品数据
        [self reloadGoodsData];
    }else if (type == 2){
        if (self.shopSelectedArr.count>0) {
            self.bottomBtn.backgroundColor = colorWithString(@"#f95865");
            self.bottomBtn.enabled = YES;
        }else{
            self.bottomBtn.backgroundColor = ZDXColor(255, 130, 142);
            self.bottomBtn.enabled = NO;
        }
        // 加载收藏店铺数据
        [self reloadShopData];
    }else{
        
    }
    [self.tableView reloadData];
}

// 加载收藏店铺数据
-(void)reloadShopData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/listShopQuery",hostUrl];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(self.page);
    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        self.dataList = [ZDXStoreShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

    }];
}

// 加载收藏商品数据
-(void)reloadGoodsData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/listGoodsQuery",hostUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(self.userModel.userId);
    params[@"page"] = @1;
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        //        if ([responseObject[@"code"] integerValue] == 1) { // 数据加载成功
        
        self.dataList = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
        //        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 加载更多数据
-(void)loadNewData{
    if (self.type == 1) { // 更多商品
        self.page++;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/listGoodsQuery",hostUrl];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = @(self.userModel.userId);
        params[@"page"] = @(self.page);
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] integerValue] == 1) {
                NSArray *list = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.dataList addObjectsFromArray:list];
                [self.tableView reloadData];
            }else{
                [MBProgressHUD showSuccess:@"暂无更多订单"];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else if (self.type == 2){
        self.page++;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/listShopQuery",hostUrl];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"page"] = @(self.page);
        params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] integerValue] == 1) {
                NSArray *list = [ZDXStoreShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.dataList addObjectsFromArray:list];
                [self.tableView reloadData];
            }else{
                [MBProgressHUD showSuccess:@"暂无更多店铺"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableView.mj_footer endRefreshing];

        }];
    }else{
        
    }
    
}

// 批量删除店铺
-(void)batchStore{
    NSString *ids = @"";
    
    for (int i = 0; i < self.shopSelectedArr.count; i++) {
        ZDXStoreShopModel *shopModel = self.shopSelectedArr[i];
        ids = [ids stringByAppendingString:[NSString stringWithFormat:@"%ld,",shopModel.favoriteId]];
    }
    
    ids = [ids substringToIndex:([ids length] - 1)];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @1;
    params[@"ids"] = ids;
    params[@"userId"] = @(self.userModel.userId);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/batchCancel",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [self.shopSelectedArr removeAllObjects];
            [self reloadShopData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 删除店铺
-(void)cancelStore{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    ZDXStoreShopModel *shopModel = self.shopSelectedArr.firstObject;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @1;
    params[@"id"] = @(shopModel.favoriteId);
    params[@"userId"] = @(self.userModel.userId);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/cancel",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [self.shopSelectedArr removeAllObjects];
            [self reloadShopData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
