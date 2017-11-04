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
@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation ZDXStoreHomeViewController

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(ZDXStoreMainTopView *)topView{
    if (!_topView) {
        _topView = [[ZDXStoreMainTopView alloc] initWithFrame:CGRectMake(0, 0, 125, 19)];
        _topView.delegate = self;
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDXRandomColor;
    
    NSArray *imageArr = @[@"item1",@"item2",@"item3",@"item4",@"item3",@"item1",@"item1",@"item2",@"item3",@"item4",@"item3",@"item1",@"item1",@"item2",@"item3",@"item4",@"item3",@"item1"];
    for (int i = 0;i<imageArr.count;i++){
        ZDXStoreProductModel *model = [[ZDXStoreProductModel alloc] init];
        model.productName = @"大金大1匹变频空调客厅卧室用点幅293大金大1匹变频空调客厅卧室用点幅293大金大1匹变频空调客厅卧室用点幅293大金大1匹变频空调客厅卧室用点幅293";
        model.productPrice = 3559.00;
        model.productPicUri = imageArr[i];
        [self.dataList addObject:model];
    }
    
    
    // 导航栏设置
    [self setupNav];
    
    // tableview设置
    [self setupTableView];

}

// 导航栏设置
-(void)setupNav{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.topView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索按钮"] style:UIBarButtonItemStyleDone target:self action:@selector(searchClick)];
}


// 搜索按钮事件
-(void)searchClick{
    NSLog(@"搜索");
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
    [manage GET:@"http://loc.geliyunshang.com/api/v1.Ads/homeCarouselAds" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.headerView.dataList = responseObject[@"data"]; 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [tableView setTableHeaderView:self.headerView];
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreBrandChooseCell" bundle:nil] forCellReuseIdentifier:brandChooseCell];
    [self.view addSubview:tableView];
    
    
    self.tableView = tableView;
    
}
#pragma mark - 选择城市
-(void)chooseCity{
    NSLog(@"选择城市");
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
        self.commodityClassifyCell = cell;
        return cell;
    }else if (indexPath.row == 1) {
        ZDXStoreBrandChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:brandChooseCell];
        self.brandChooseCell = cell;
        return cell;
    }else{
        ZDXStoreCommodityShowCell *cell = [ZDXStoreCommodityShowCell initWithCommodityShowTableView:tableView cellForRowAtIndexPath:indexPath];
        cell.dataList = self.dataList;
        cell.delegate = self;
        self.commodityShowCell = cell;
        return cell;
    }
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
//    }
//    cell.textLabel.font = [UIFont systemFontOfSize:9];
//    cell.textLabel.text = @"zdx";
//    return cell;
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
-(void)selectedCommodityClassifyString:(NSString *)string{
    ZDXStoreClassifyViewController *vc = [[ZDXStoreClassifyViewController alloc] init];
    vc.commdoityTypeStr = string;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 商品选择
-(void)selectedClickProductModel:(ZDXStoreProductModel *)productModel{
    ZDXStoreCommdityDetailController *vc = [[ZDXStoreCommdityDetailController alloc] init];
    vc.productModel = productModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
