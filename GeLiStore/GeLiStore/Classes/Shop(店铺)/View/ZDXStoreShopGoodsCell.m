//
//  ZDXStoreShopGoodsCell.m
//  GeLiStore
//
//  Created by user99 on 2017/12/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShopGoodsCell.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreFiltrateCollectionViewCell.h"

static NSString *filtrateCellID = @"filtrateCell";
@interface ZDXStoreShopGoodsCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) ZDXStoreFiltrateCollectionViewCell *cell;
@end

@implementation ZDXStoreShopGoodsCell

+(instancetype)initWithShopGoodsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    ZDXStoreShopGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ZDXStoreShopGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCollectionView];
    }
    return self;
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10; //最小item间距（默认为10）
    layout.minimumLineSpacing = 10; // 最小行间距（默认10）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1000) collectionViewLayout:layout];
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [collectionView registerNib:[UINib nibWithNibName:@"ZDXStoreFiltrateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:filtrateCellID];
    collectionView.showsVerticalScrollIndicator = false;
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.width - 10) / 2, 276 + 10);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreFiltrateCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:filtrateCellID forIndexPath:indexPath];
    item.goodsModel = self.dataList[indexPath.row];
    self.cell = item;
    return item;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreGoodsModel *model = self.dataList[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectedClickGoodsModel:)]) {
        [self.delegate selectedClickGoodsModel:model];
    }
    
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    NSInteger count = 0;
    if ((self.dataList.count % 2) != 0) {
        count = dataList.count / 2 + 1;
    }else{
        count = self.dataList.count / 2;
    }
    _collectionView.height = count * 276 + (count - 1) * 10 + count * 10;
    self.cellH = count * 276 + (count - 1) * 10 + count * 10;
}
@end
