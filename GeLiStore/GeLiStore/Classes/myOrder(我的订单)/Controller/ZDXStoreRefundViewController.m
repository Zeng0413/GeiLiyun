//
//  ZDXStoreRefundViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreRefundViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreRefundGoodsCell.h"
#import "ZDXStoreOrderDetailModel.h"
#import "ZDXStoreRefundMoneyOrTypeCell.h"
#import "ZDXStoreRefundReasonCell.h"

static NSString *refundMoneyOrTypeCellID = @"RefundMoneyOrTypeCell";
static NSString *refundGoodsCellID = @"RefundGoodsCell";
@interface ZDXStoreRefundViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreRefundReasonCell *refundReasonCell;
@end

@implementation ZDXStoreRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"退款";
    
    // 设置tableView
    [self setupTableView];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.x = 0;
    bottomBtn.width = SCREEN_WIDTH;
    bottomBtn.height = 44;
    bottomBtn.y = SCREEN_HEIGHT - 44;
    [bottomBtn setBackgroundColor:colorWithString(@"#f95865")];
    [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

// 提交
-(void)submit{
    
}

// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRefundGoodsCell" bundle:nil] forCellReuseIdentifier:refundGoodsCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRefundMoneyOrTypeCell" bundle:nil] forCellReuseIdentifier:refundMoneyOrTypeCellID];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.orderDetailModel.goods.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreRefundGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:refundGoodsCellID];
        cell.goodsModel = self.orderDetailModel.goods[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        ZDXStoreRefundMoneyOrTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:refundMoneyOrTypeCellID];
        return cell;
    }
    if (indexPath.section == 2) {
        ZDXStoreRefundReasonCell *cell = [ZDXStoreRefundReasonCell initWithRefundReasonTableView:tableView cellForRowAtIndexPAth:indexPath];
        self.refundReasonCell = cell;
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
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1){
        return 124;
    }else{
        return self.refundReasonCell.cellH;
    }
//    return 50;
}
@end
