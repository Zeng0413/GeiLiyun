
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
static NSString *commdityCommentCellID = @"commdityCommentCell";

@interface ZDXStoreCommdityDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ZDXStoreTableViewHeaderView *headerView;

@property (strong, nonatomic)ZDXStoreCommdityDetailInfoCell *commdityInfoCell;
@end

@implementation ZDXStoreCommdityDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置tableView
    [self setupTableView];
    // Do any additional setup after loading the view.
}

// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setHeaderView:[ZDXStoreTableViewHeaderView headerView:CGRectMake(0, 0, SCREEN_WIDTH, 260)]];
    [tableView setTableHeaderView:self.headerView];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreCommdityCommentCell" bundle:nil] forCellReuseIdentifier:commdityCommentCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    ZDXStoreFooterView *footerView = [[ZDXStoreFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_HEIGHT, 49)];
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
        self.commdityInfoCell = cell;
        return cell;
    }
    
    if (indexPath.row == 1) {
        ZDXStoreCommdityCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commdityCommentCellID];
        return cell;
    }
    
    if (indexPath.row == 2) {
        ZDXStoreCommdityCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commdityCommentCellID];
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
        return 155;
    }
    return 0;
}









@end
