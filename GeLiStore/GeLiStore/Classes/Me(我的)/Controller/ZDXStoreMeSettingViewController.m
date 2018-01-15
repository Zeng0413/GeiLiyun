//
//  ZDXStoreMeSettingViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/10.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreMeSettingViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreSettingCell.h"

static NSString *settingCellID = @"settingCell";
@interface ZDXStoreMeSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *array1;
@property (strong, nonatomic) NSArray *array2;
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation ZDXStoreMeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"image"] = @"地址图标";
    dict[@"title"] = @"收货人信息";
    self.array1 = @[dict];
    
    NSMutableDictionary *dict1 =[NSMutableDictionary dictionary];
    dict1[@"image"] = @"更新图标";
    dict1[@"title"] = @"检查更新";
    
    NSMutableDictionary *dict2 =[NSMutableDictionary dictionary];
    dict2[@"image"] = @"联系我们图标";
    dict2[@"title"] = @"联系我们";
    self.array2 = @[dict1, dict2];
    
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
    [bottomBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

// 退出登陆
-(void)loginOut{
    [MBProgressHUD showMessage:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [ZDXStoreUserModelTool deleteFile];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = colorWithString(@"#f4f4f4");
    
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreSettingCell" bundle:nil] forCellReuseIdentifier:settingCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.array1.count;
    }else{
        return self.array2.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDXStoreSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID];
    if (indexPath.section == 0) {
        cell.dict = self.array1[indexPath.row];
        return cell;
    }else{
        cell.dict = self.array2[indexPath.row];
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 21)];
    view.backgroundColor = colorWithString(@"#f4f4f4");
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 21;
}
@end
