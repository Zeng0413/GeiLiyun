//
//  ZDXStoreWriteOrderViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/24.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreWriteOrderViewController.h"
#import "ZDXStoreOrderAddressDefaultCell.h"
#import "ZDXStoreOrderGoodsShowCell.h"
#import "ZDXStoreConsigneeInfoViewController.h"

static NSString *orderAddressDefaultCellID = @"orderAddressDefaultCell";
static NSString *orderGoodsShowCellID = @"OrderGoodsShowCell";
@interface ZDXStoreWriteOrderViewController ()

@end

@implementation ZDXStoreWriteOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderAddressDefaultCell" bundle:nil] forCellReuseIdentifier:orderAddressDefaultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreOrderGoodsShowCell" bundle:nil] forCellReuseIdentifier:orderGoodsShowCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZDXStoreOrderAddressDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAddressDefaultCellID];
        return cell;
    }
    if (indexPath.section == 1) {
        ZDXStoreOrderGoodsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsShowCellID];
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
        return 59;
    }else if (indexPath.section == 1){
        return 107;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreConsigneeInfoViewController *vc = [[ZDXStoreConsigneeInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
