//
//  ZDXStoreFiltratePushView.m
//  GeLiStore
//
//  Created by zdx on 2017/11/2.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreFiltratePushView.h"
#import "ZDXComnous.h"
#import "ZDXStoreFiltrateTableViewHeaderView.h"
#import "ZDXStoreFiltratePushViewTypeCell.h"
@interface ZDXStoreFiltratePushView ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreFiltratePushViewTypeCell *pushViewTypeCell;
@end

@implementation ZDXStoreFiltratePushView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        // 设置tableView
        [self setupTableView];
    }
    return self;
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZDXStoreFiltratePushViewTypeCell *cell = [ZDXStoreFiltratePushViewTypeCell initWithTableView:tableView cellForRowAtIndexPath:indexPath];
        self.pushViewTypeCell = cell;
        return cell;
    }
    static NSString *inder = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:inder];
    }
    cell.textLabel.text = @"ZDX";
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.pushViewTypeCell.cellH;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"类别",@"品牌"];
    ZDXStoreFiltrateTableViewHeaderView *headerView = [[ZDXStoreFiltrateTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 39)];
    headerView.titleName.text = arr[section];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 39;
}















@end
