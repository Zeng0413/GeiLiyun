//
//  ZDXStoreShoppingCarViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreShoppingCarViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreShopCarTableViewProxy.h"
#import "ZDXStoreShopCarBottomView.h"
#import "ZDXStoreShopCarCell.h"
#import "ZDXStoreShopCarHearView.h"
#import "ZDXStoreBrandModel.h"
#import "ZDXStoreShopCarFormat.h"

#import "ZDXStoreShopCartNoGoodsView.h"

@interface ZDXStoreShoppingCarViewController ()<ZDXStoreShopCarFormatDelegate>

@property (nonatomic, strong) UITableView *shopcartTableView;   /**< 购物车列表 */
@property (nonatomic, strong) ZDXStoreShopCarBottomView *shopcartBottomView;    /**< 购物车底部视图 */
@property (nonatomic, strong) ZDXStoreShopCarTableViewProxy *shopcartTableViewProxy;    /**< tableView代理 */

@property (nonatomic, strong) ZDXStoreShopCarFormat *shopcartFormat;    /**< 负责购物车逻辑处理 */

@property (strong, nonatomic) ZDXStoreShopCartNoGoodsView *shopCartNoGoodsView;

@property (nonatomic, strong) UIButton *editButton;    /**< 编辑按钮 */
@end

@implementation ZDXStoreShoppingCarViewController

#pragma mark - 初始化控件

- (ZDXStoreShopCarFormat *)shopcartFormat {
    if (_shopcartFormat == nil){
        _shopcartFormat = [[ZDXStoreShopCarFormat alloc] init];
        _shopcartFormat.delegate = self;
    }
    return _shopcartFormat;
}

-(UITableView *)shopcartTableView{
    if (_shopcartTableView == nil) {
        _shopcartTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _shopcartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_shopcartTableView registerClass:[ZDXStoreShopCarCell class] forCellReuseIdentifier:@"ZDXStoreShopCarCell"];
        [_shopcartTableView registerClass:[ZDXStoreShopCarHearView class] forHeaderFooterViewReuseIdentifier:@"ZDXStoreShopCarHearView"];
        [_shopcartTableView registerNib:[UINib nibWithNibName:@"ZDXStoreShopCartNoCell" bundle:nil] forCellReuseIdentifier:@"noCell"];
        _shopcartTableView.showsVerticalScrollIndicator = NO;
        _shopcartTableView.delegate = self.shopcartTableViewProxy;
        _shopcartTableView.dataSource = self.shopcartTableViewProxy;
        _shopcartTableView.rowHeight = 135;
        _shopcartTableView.sectionFooterHeight = 10;
        _shopcartTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _shopcartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
     
        
    }
    return _shopcartTableView;
}

-(ZDXStoreShopCarTableViewProxy *)shopcartTableViewProxy{
    if (_shopcartTableViewProxy == nil) {
        _shopcartTableViewProxy = [[ZDXStoreShopCarTableViewProxy alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartTableViewProxy.shopcartProxyProductSelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath) {
            [weakSelf.shopcartFormat selectedProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section) {
            [weakSelf.shopcartFormat selectedBrandAtSection:section isSelected:isSelected];
        };
        
        _shopcartTableViewProxy.shopcartProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath) {
            [weakSelf.shopcartFormat changeCountAtIndexPath:indexPath count:count];
        };
    }
    
    return _shopcartTableViewProxy;
}


-(ZDXStoreShopCarBottomView *)shopcartBottomView{
    if (_shopcartBottomView == nil) {
        _shopcartBottomView = [[ZDXStoreShopCarBottomView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartBottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected) {
            [weakSelf.shopcartFormat selectAllProductWithStatus:isSelected];
        };
        
        _shopcartBottomView.shopcartBotttomViewSettleBlock = ^{
            [weakSelf.shopcartFormat settleSelectedProducts];
        };
        
    }
    return _shopcartBottomView;
}


- (UIButton *)editButton {
    if (_editButton == nil){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 40, 40);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

#pragma mark - shopCarFormat delegate
-(void)shopCarFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray{
    [self.shopCartNoGoodsView removeFromSuperview];
    self.shopcartTableViewProxy.dataArray = dataArray;
    [self.shopcartTableView reloadData];
    
}

// 购物车没有数据，隐藏BottomView
-(void)shopCartNoData{
    [self.view addSubview:self.shopCartNoGoodsView];
    self.shopcartBottomView.hidden = YES;
}

-(void)shopcartFormatAccountForTotalPrice:(float)totalPrice totalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected{
    self.shopcartBottomView.hidden = NO;
    [self.shopcartBottomView setupShopCarBottomViewWithTotalPrice:totalPrice totalCount:totalCount isAllSelected:isAllSelected];
    [self.shopcartTableView reloadData];
}

// 结算
-(void)shopCarFormatSettleForSelectedProduct:(NSArray *)selectedProducts{
    NSLog(@"%@",selectedProducts);
}
- (void)editButtonAction {
    self.editButton.selected = !self.editButton.isSelected;
    [self.shopcartBottomView changeShopCarBottomViewWithStatus:self.editButton.isSelected];
    
    self.shopcartTableViewProxy.status = self.editButton.isSelected;
    [self.shopcartTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = ZDXRandomColor;
   
    self.shopCartNoGoodsView = [ZDXStoreShopCartNoGoodsView view];
    self.shopCartNoGoodsView.frame = self.view.bounds;
    
    [self addSubview];
    [self layoutSubview];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self realodData];

}

-(void)realodData{
    [self.shopcartFormat requestShopCarProductList];
}
-(void)addSubview{
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    [self.view addSubview:self.shopcartTableView];
    [self.view addSubview:self.shopcartBottomView];
    
}

-(void)layoutSubview{
    [self.shopcartBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.height);
        make.height.equalTo(@50);
    }];
    
    [self.shopcartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.height);
    }];
    
}

@end
