//
//  ZDXStoreEditeAddressViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/29.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreEditeAddressViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreEditAddressFirstCell.h"
#import "ZDXStoreAddressRemakeCell.h"
#import "ZDXStoreSetupDefaultAddressCell.h"

static NSString *EditAddressFirstCellID = @"EditAddressFirstCell";
static NSString *addressRemakeCellID = @"addressRemakeCell";
static NSString *setupDefaultAddressCellID = @"setupDefaultAddressCell";

@interface ZDXStoreEditeAddressViewController ()

@end

@implementation ZDXStoreEditeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑收货地址";
    
    // 设置tableView
    [self setupTableView];
    
    [self setupNav];
    
    [self setupBottomView];
}

-(void)setupBottomView{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.x = 0;
    bottomBtn.width = SCREEN_WIDTH;
    bottomBtn.height = 44;
    bottomBtn.y = SCREEN_HEIGHT - 44;
    [bottomBtn setBackgroundColor:colorWithString(@"#f95865")];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView addSubview:bottomBtn];
}

-(void)setupTableView{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = colorWithString(@"#f5f5f5");
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreEditAddressFirstCell" bundle:nil] forCellReuseIdentifier:EditAddressFirstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreAddressRemakeCell" bundle:nil] forCellReuseIdentifier:addressRemakeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreSetupDefaultAddressCell" bundle:nil] forCellReuseIdentifier:setupDefaultAddressCellID];
}

-(void)setupNav{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:colorWithString(@"#262626") forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)save{
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZDXStoreEditAddressFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:EditAddressFirstCellID];
        return cell;
    }
    if (indexPath.row == 1) {
        ZDXStoreAddressRemakeCell *cell = [tableView dequeueReusableCellWithIdentifier:addressRemakeCellID];
        return cell;
    }
    if (indexPath.row == 2) {
        ZDXStoreSetupDefaultAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:setupDefaultAddressCellID];
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
        return 180;
    }else if (indexPath.row == 1){
        return 163;
    }else if (indexPath.row == 2){
        return 78;
    }
    return 50;
}

@end
