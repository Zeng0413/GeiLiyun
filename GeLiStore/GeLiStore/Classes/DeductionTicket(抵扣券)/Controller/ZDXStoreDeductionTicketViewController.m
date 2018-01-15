//
//  ZDXStoreDeductionTicketViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/3.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreDeductionTicketViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreSelectedTopView.h"
#import "ZDXStoreNoCollectionCell.h"
#import "ZDXStoreDeductionTicketCell.h"
static NSString *deductionTicketCellID = @"DeductionTicketCell";
static NSString *noCollectionCellID = @"noCollectionCellID";
@interface ZDXStoreDeductionTicketViewController ()<ZDXStoreSelectedTopViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation ZDXStoreDeductionTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"抵扣券";
    
    self.dataList = @[@"dsad",@"ewq"];
    // 筛选View
    [self setupFiltrateView];
    
    // 设置tableView
    [self setupTableView];
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
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreDeductionTicketCell" bundle:nil] forCellReuseIdentifier:deductionTicketCellID];
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    tableView.mj_footer = footer;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 筛选View
-(void)setupFiltrateView{
    ZDXStoreSelectedTopView *topView = [[ZDXStoreSelectedTopView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 55)];
    topView.btnDisableColor = colorWithString(@"#ffaf3c");
    topView.list = @[@"所有",@"可用",@"已用"];
    topView.delegate = self;
    [self.view addSubview:topView];
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataList.count > 0) {
        return self.dataList.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        ZDXStoreDeductionTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:deductionTicketCellID];
        return cell;
        
    }
    
    ZDXStoreNoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:noCollectionCellID];
    cell.Img.image = [UIImage imageNamed:@"卡券包为空"];
    cell.title.text = @"您还没有抵扣券～";
    cell.ImgW.constant = 187.5;
    cell.ImgH.constant = 168.5;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count > 0) {
        return 131;
    }
    
    return SCREEN_HEIGHT - 64 - 55;
    
}
@end
