//
//  ZDXStoreConsigneeInfoViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreConsigneeInfoViewController.h"
#import "ZDXStoreEditeAddressViewController.h"
#import "ZDXStoreNoConsigneeInfoCell.h"
#import "ZDXComnous.h"

static NSString *NoConsigneeInfoCellID = @"NoConsigneeInfoCell";

@interface ZDXStoreConsigneeInfoViewController ()<ZDXStoreNoConsigneeInfoCellDelegate>

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation ZDXStoreConsigneeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货人信息";
    
    // 设置tableView
    [self setupTableView];
 
    [self setupNav];
    
}

-(void)setupNav{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
}

// 设置tableView
-(void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreNoConsigneeInfoCell" bundle:nil] forCellReuseIdentifier:NoConsigneeInfoCellID];
}

// 新增收获地址
-(void)addAddress{
    ZDXStoreEditeAddressViewController *vc = [[ZDXStoreEditeAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataList.count != 0) {
        return self.dataList.count;
    }
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataList.count != 0) {
        static NSString *indentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        }
        cell.textLabel.text = @"zdx";
        return cell;
    }
    
    ZDXStoreNoConsigneeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NoConsigneeInfoCellID];
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataList.count != 0) {
        return 50;
    }
    
    return SCREEN_HEIGHT - 64;
}

-(void)addNewAddress{
    ZDXStoreEditeAddressViewController *vc = [[ZDXStoreEditeAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
