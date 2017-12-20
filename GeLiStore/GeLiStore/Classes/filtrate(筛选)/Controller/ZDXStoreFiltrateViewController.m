//
//  ZDXStoreFiltrateViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/1.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltrateViewController.h"
#import "ZDXStoreFiltrateTopView.h"
#import "ZDXComnous.h"
#import "ZDXStoreProductModel.h"
#import "ZDXStoreFiltrateCollectionViewCell.h"
#import "ZDXStoreFiltratePushView.h"
#import "ZDXStoreCommdityDetailController.h"
#import "ZDXStoreFiltrateNoGoodsCell.h"

static NSString *filtrateCellID = @"filtrateCell";
static NSString *filtrateNoGoodsCellID = @"FiltrateNoGoodsCell";

@interface ZDXStoreFiltrateViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ZDXStoreFiltrateTopViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) ZDXStoreFiltratePushView *filtratePushView;

@property (strong, nonatomic) UIView *shadowView;
@end

@implementation ZDXStoreFiltrateViewController

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品";
    
    // 筛选栏
    [self setupTopView];
    
    // 初始化collectionView
    [self setupCollectionView];
}

// 初始化collectionView
-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 49, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = colorWithString(@"f4f4f4");
    collectionView.showsVerticalScrollIndicator = NO;
    
    [collectionView registerNib:[UINib nibWithNibName:@"ZDXStoreFiltrateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:filtrateCellID];
    [collectionView registerNib:[UINib nibWithNibName:@"ZDXStoreFiltrateNoGoodsCell" bundle:nil] forCellWithReuseIdentifier:filtrateNoGoodsCellID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

// 筛选栏
-(void)setupTopView{
    ZDXStoreFiltrateTopView *filtrateTopView = [[ZDXStoreFiltrateTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 49)];
    filtrateTopView.delegate = self;
    [self.view addSubview:filtrateTopView];
}

#pragma mark - collection delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataList.count != 0) {
        return self.dataList.count;
    }else{
        return 1;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count != 0) {
        return CGSizeMake((SCREEN_WIDTH - 10) / 2, 253);
    }else{
        return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count != 0) {
        ZDXStoreFiltrateCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:filtrateCellID forIndexPath:indexPath];
        item.goodsModel = self.dataList[indexPath.row];
        return item;
    }else{
        ZDXStoreFiltrateNoGoodsCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:filtrateNoGoodsCellID forIndexPath:indexPath];
        return item;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataList.count != 0) {
        ZDXStoreGoodsModel *model = self.dataList[indexPath.row];
        
        ZDXStoreCommdityDetailController *vc = [[ZDXStoreCommdityDetailController alloc] init];
        vc.goodsModel = model;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - filtrateView delegate
-(void)selectedFiltrateType:(NSString *)type{
    if ([type isEqualToString:@"筛选"]) {
        
        self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        self.shadowView.alpha = 0;
        self.shadowView.backgroundColor = [UIColor colorWithHexString:@"#444444"];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self.shadowView addGestureRecognizer:tapGesture];
        
        [self.view addSubview:self.shadowView];
        self.filtratePushView = [[ZDXStoreFiltratePushView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH * 4 / 5, SCREEN_HEIGHT - 64)];
        [self.view addSubview:self.filtratePushView];
        [UIView animateWithDuration:0.5 animations:^{
            self.shadowView.alpha = 0.6;
            self.filtratePushView.x = SCREEN_WIDTH / 5;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)click{
    [UIView animateWithDuration:0.5 animations:^{
        self.filtratePushView.x = SCREEN_WIDTH;
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        self.shadowView = nil;
        [self.filtratePushView removeFromSuperview];
        self.filtratePushView = nil;
    }];
}
@end
