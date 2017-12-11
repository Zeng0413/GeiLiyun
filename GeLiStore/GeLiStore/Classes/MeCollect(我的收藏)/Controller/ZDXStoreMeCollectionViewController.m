//
//  ZDXStoreMeCollectionViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/11.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeCollectionViewController.h"
#import "ZDXStoreCollectionTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreCollectionGoodsCell.h"
#import "ZDXStoreNoCollectionCell.h"

static NSString *noCollectionCellID = @"noCollectionCellID";
static NSString *collectionGoodsCellID = @"CollectionGoodsCell";
@interface ZDXStoreMeCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreCollectionGoodsCellDelegate>

@property (strong, nonatomic) NSMutableArray *dataList;
@property (weak, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UIButton *editButton;    /**< 编辑按钮 */

@property (strong, nonatomic) UIButton *selectedBtn;

@property (strong, nonatomic) UIButton *bottomBtn;


@property (strong, nonatomic) ZDXStoreCollectionGoodsCell *collectionGoodsCell;

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) NSMutableArray *goodsSelectedArr;

@end

@implementation ZDXStoreMeCollectionViewController

-(NSMutableArray *)goodsSelectedArr{
    if (!_goodsSelectedArr) {
        _goodsSelectedArr = [NSMutableArray array];
    }
    return _goodsSelectedArr;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = colorWithString(@"#f4f4f4");
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    // 收藏筛选View
    [self setupFiltrateView];
    
    // 设置tableView
    [self setupTableView];
    
    // 加载数据
    [self reloadData];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.x = 0;
    self.bottomBtn.width = SCREEN_WIDTH;
    self.bottomBtn.height = 44;
    self.bottomBtn.y = SCREEN_HEIGHT - 44;
    [self.bottomBtn setBackgroundColor:colorWithString(@"#f95865")];
    [self.bottomBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
}

// 加载数据
-(void)reloadData{
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Favorites/listGoodsQuery",hostUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(userModel.userId);
    params[@"page"] = @1;
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) { // 数据加载成功
            self.dataList = [ZDXStoreGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

// 收藏筛选View
-(void)setupFiltrateView{
    ZDXStoreCollectionTopView *topView = [[ZDXStoreCollectionTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 55)];
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
        ZDXStoreCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionGoodsCellID];
        cell.goodsModel = self.dataList[indexPath.row];
        cell.delegate = self;
        if (self.isSelected) {
            [cell isEditStatus:YES];
        }else{
            [cell isEditStatus:NO];
        }
        self.collectionGoodsCell = cell;
        return cell;
    }
    
    
    ZDXStoreNoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:noCollectionCellID];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        return 140;
    }
    
    return SCREEN_HEIGHT - 64 - 55;

}

// 删除收藏商品
-(void)deleteClick{
    
}

#pragma mark - cell delegate
#pragma mark 商品选择
-(void)collectionGoodsWithModel:(ZDXStoreGoodsModel *)goodsModel selectedStatus:(BOOL)selectedStatus{
    if (selectedStatus) {
        [self.goodsSelectedArr addObject:goodsModel];
    }else{
        [self.goodsSelectedArr removeObject:goodsModel];
    }
}
@end
