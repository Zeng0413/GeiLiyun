//
//  ZDXStoreChooseBrandView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreChooseBrandView.h"
#import "ZDXStoreBrandCollectionViewCell.h"
#import "ZDXStoreBrandModel.h"
#import "ZDXComnous.h"
@interface ZDXStoreChooseBrandView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;

}



@end

@implementation ZDXStoreChooseBrandView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10; //最小item间距（默认为10）
        layout.minimumLineSpacing = 10; // 最小行间距（默认10）
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [_collectionView registerClass:[ZDXStoreBrandCollectionViewCell class] forCellWithReuseIdentifier:@"ZDXStoreBrandCollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = false;
        [self addSubview:_collectionView];
    }
    
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 74);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZDXStoreBrandCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZDXStoreBrandCollectionViewCell" forIndexPath:indexPath];
    ZDXStoreBrandModel *brandModel = self.dataList[indexPath.row];
    [item.brandImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,brandModel.brandImg]] placeholderImage:[UIImage imageNamed:@"品牌加载"]];
    return item;
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    [_collectionView reloadData];
}
@end
