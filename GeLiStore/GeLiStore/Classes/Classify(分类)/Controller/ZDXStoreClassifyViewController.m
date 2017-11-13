//
//  ZDXStoreClassifyViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/30.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreClassifyViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreClassifyLeftCell.h"
#import "ZDXStoreCommdityClassifyBannerCell.h"
#import "ZDXStoreCommdoityClassifyCollectionCell.h"
#import "ZDXStoreFiltrateViewController.h"
#import "ZDXStoreGoodsClassifyModel.h"
#import "ZDXStoreGoodsClassifySubModel.h"

static NSString *commdityClassifyBannerCellID = @"commdityClassifyBannerCell";
static NSString *commodityClassifyCellID = @"commodityClassifyCell";
@interface ZDXStoreClassifyViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionDataList;

@property (strong, nonatomic) NSArray *dataList;

@property (assign, nonatomic) NSInteger tableViewSelectedIndex;
@property (copy, nonatomic) NSString *bannerUrlStr;

@property (strong, nonatomic) ZDXStoreCommdityClassifyBannerCell *bannerCell;
@end

@implementation ZDXStoreClassifyViewController


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 57;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [_tableView registerClass:[ZDXStoreClassifyLeftCell class] forCellReuseIdentifier:kCellIdentifier_Left];

    }
    return _tableView;
    
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumInteritemSpacing = 10; //最小item间距（默认为10）
//        layout.minimumLineSpacing = 10; // 最小行间距（默认10）
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 64, SCREEN_WIDTH * 3 / 4, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZDXStoreCommdityClassifyBannerCell" bundle:nil] forCellWithReuseIdentifier:commdityClassifyBannerCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZDXStoreCommdoityClassifyCollectionCell" bundle:nil] forCellWithReuseIdentifier:commodityClassifyCellID];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    for (int i = 0; i < self.tableDataList.count; i++) {
        ZDXStoreGoodsClassifyModel *model = self.tableDataList[i];
        if ([self.classifyStr isEqualToString:model.catName]) {
            self.tableViewSelectedIndex = i;
            ZDXStoreGoodsClassifyModel *model = self.tableDataList[self.tableViewSelectedIndex];
            
            // 加载banner数据
            [self reloadBannerData:model.catId];
            break;
        }
    }
    
    // 加载分类信息
    [self reloadClassifyData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.tableViewSelectedIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self addSubViews];
    
    
}

// 加载分类信息
-(void)reloadClassifyData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://glys.wuliuhangjia.com/api/v1.Cat/classifiedManagement" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataList = [ZDXStoreGoodsClassifyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        ZDXStoreGoodsClassifyModel *model = self.dataList[self.tableViewSelectedIndex];
        self.collectionDataList = model.child;
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 加载banner数据
-(void)reloadBannerData:(NSInteger)catId{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *param = @{@"catId" : [NSString stringWithFormat:@"%ld",catId]};
    [manager POST:@"http://glys.wuliuhangjia.com/api/v1.Ads/catAds" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            NSDictionary *dic = responseObject[@"data"];
            self.bannerUrlStr = dic[@"adFile"];
            self.bannerCell.bannerUrlStr = self.bannerUrlStr;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)addSubViews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}

#pragma mark - tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreClassifyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    ZDXStoreGoodsClassifyModel *model = self.tableDataList[indexPath.row];
    cell.name.text = model.catName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreGoodsClassifyModel *model = self.tableDataList[indexPath.row];
    [self reloadBannerData:model.catId];
    
    self.tableViewSelectedIndex = indexPath.row;
    [self reloadClassifyData];
}

#pragma mark - collection delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.collectionDataList.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreCommdityClassifyBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commdityClassifyBannerCellID forIndexPath:indexPath];

        self.bannerCell = cell;
        return cell;
    }
    if (indexPath.section == 1) {
        ZDXStoreCommdoityClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commodityClassifyCellID forIndexPath:indexPath];
        cell.model = self.collectionDataList[indexPath.row];
        return cell;
        
    }
    return nil;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.width, 105);
    }else{
        return CGSizeMake((collectionView.width - 10) / 2, 134);
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        ZDXStoreFiltrateViewController *vc = [[ZDXStoreFiltrateViewController alloc] init];
        ZDXStoreGoodsClassifySubModel *model = self.collectionDataList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
