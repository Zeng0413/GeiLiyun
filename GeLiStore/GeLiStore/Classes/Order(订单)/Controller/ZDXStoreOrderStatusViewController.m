//
//  ZDXStoreOrderStatusViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/12/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreOrderStatusViewController.h"
#import "ZDXComnous.h"

@interface ZDXStoreOrderStatusViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *tableViewTopView;

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ZDXStoreOrderStatusViewController

//-(UIView *)tableViewTopView{
//    if (!_tableViewTopView) {
//        _tableViewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
//        
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    self.view.backgroundColor = colorWithString(@"#f4f4f4");
    
    // 设置tableView
    [self setupTableView];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    CGFloat btnW = (SCREEN_WIDTH / 2 + 20) / 2;
    UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW, 0, btnW, bottomView.height)];
    payBtn.backgroundColor = colorWithString(@"#f95865");
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:payBtn];
    
    UIButton *cancelOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW * 2, 0, btnW, bottomView.height)];
    cancelOrderBtn.backgroundColor = colorWithString(@"#f4f4f4");
    [cancelOrderBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    [cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:cancelOrderBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = colorWithString(@"#f5f5f5");
    [bottomView addSubview:lineView];
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 5)];
    imageView.image = [UIImage imageNamed:@"等待付款图片"];
    [tableView setTableHeaderView:imageView];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    cell.textLabel.text = @"zdx";
    return cell;
}



@end
