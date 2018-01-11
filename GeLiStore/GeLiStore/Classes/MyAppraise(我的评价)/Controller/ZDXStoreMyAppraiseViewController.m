//
//  ZDXStoreMyAppraiseViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/11.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreMyAppraiseViewController.h"
#import "ZDXStoreSelectedTopView.h"
#import "ZDXStoreAppraiseModel.h"
#import "ZDXStoreUserModel.h"
#import "ZDXComnous.h"
#import "ZDXStoreNoCollectionCell.h"
#import "ZDXStoreMyAppraiseCell.h"

static NSString *noCellID = @"noCellID";
@interface ZDXStoreMyAppraiseViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreSelectedTopViewDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation ZDXStoreMyAppraiseViewController

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.title = @"我的评价";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 加载数据
    [self reloadData];
    
    // 筛选View
    [self setupFiltrateView];
    
    // 设置tableView
    [self setupTableView];
}

-(void)reloadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"userId" : @([ZDXStoreUserModelTool userModel].userId), @"page" : @(self.page)};
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.GoodsAppraises/userAppraise",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataList = [ZDXStoreAppraiseModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55+64, SCREEN_WIDTH, SCREEN_HEIGHT - 55 - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreNoCollectionCell" bundle:nil] forCellReuseIdentifier:noCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 筛选View
-(void)setupFiltrateView{
    ZDXStoreSelectedTopView *topView = [[ZDXStoreSelectedTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 55)];
    topView.btnDisableColor = colorWithString(@"#e63944");
    topView.list = @[@"所有评价",@"带图评价"];
    topView.delegate = self;
    [self.view addSubview:topView];
}

#pragma mark - topView Delegate
-(void)selectedTopViewSelected:(NSInteger)type{
    
}

#pragma mark - tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataList.count > 0) {
        return self.dataList.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        ZDXStoreMyAppraiseCell *cell = [ZDXStoreMyAppraiseCell cellWithAppraiseTableView:tableView];
        return cell;
    }
    
    ZDXStoreNoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:noCellID];
    cell.Img.image = [UIImage imageNamed:@"无评价"];
    cell.title.text = @"您还没有发表过评价～";
    cell.ImgW.constant = 185;
    cell.ImgH.constant = 113;
    return cell;
//    static NSString *indentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
//    }
//    cell.textLabel.text = @"zdx";
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count>0) {
        
    }
    return SCREEN_HEIGHT - 64 - 55;
}
@end
