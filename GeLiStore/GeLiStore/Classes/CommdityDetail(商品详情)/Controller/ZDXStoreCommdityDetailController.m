
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
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreGoodsDescCell.h"
#import "ZDXStoreWriteOrderViewController.h"
#import "ZDXStoreLoginViewController.h"

static NSString *commdityCommentCellID = @"commdityCommentCell";
static NSString *goodsDescCellID = @"goodsDescCell";
@interface ZDXStoreCommdityDetailController ()<UITableViewDataSource, UITableViewDelegate, ZDXStoreFooterViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ZDXStoreTableViewHeaderView *headerView;

@property (strong, nonatomic)ZDXStoreCommdityDetailInfoCell *commdityInfoCell;

@property (strong, nonatomic)ZDXStoreGoodsDescCell *goodsDescCell;

@end

@implementation ZDXStoreCommdityDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品页";
    self.view.backgroundColor = [UIColor whiteColor];
  
    
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
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    if (userModel) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = [NSString stringWithFormat:@"%ld",userModel.userId];
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

-(void)buyGoods{
    ZDXStoreWriteOrderViewController *vc = [[ZDXStoreWriteOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"立即购买");
}
@end
