 //
//  ZDXStoreEditAddressViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/30.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreEditAddressViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreEditAddressFirstCell.h"
#import "ZDXStoreAddressRemakeCell.h"
#import "ZDXStoreSetupDefaultAddressCell.h"
#import "ZDXStoreCityModel.h"
#import "ZDXStoreUserModelTool.h"
#define provinceType 0
#define cityType 1
#define distanceType 2

static NSString *EditAddressFirstCellID = @"EditAddressFirstCell";
static NSString *addressRemakeCellID = @"addressRemakeCell";
static NSString *setupDefaultAddressCellID = @"setupDefaultAddressCell";

@interface ZDXStoreEditAddressViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, ZDXStoreEditAddressFirstCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *distanceArray;
@property (assign, nonatomic) BOOL pickIsScroll;

@property (strong, nonatomic) ZDXStoreEditAddressFirstCell *editAddressFirstCell;
@property (strong, nonatomic) ZDXStoreAddressRemakeCell *remakeCell;

@property (assign, nonatomic) NSInteger areaId;
@property (assign, nonatomic) NSInteger isDefault;

@end

@implementation ZDXStoreEditAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑收货地址";
    self.isDefault = 0;
    
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
    [bottomBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = colorWithString(@"#f5f5f5");
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreEditAddressFirstCell" bundle:nil] forCellReuseIdentifier:EditAddressFirstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreAddressRemakeCell" bundle:nil] forCellReuseIdentifier:addressRemakeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDXStoreSetupDefaultAddressCell" bundle:nil] forCellReuseIdentifier:setupDefaultAddressCellID];
    [self.view addSubview:self.tableView];
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
    NSArray *msgArr = @[self.editAddressFirstCell.conginnerTextField.text, self.editAddressFirstCell.phoneNumTextField.text, [NSString stringWithFormat:@"%ld",self.areaId], self.remakeCell.textView.text];
    for (NSString *str in msgArr) {
        if (str.length < 1) {
            //    创建弹出框
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"资料不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [MBProgressHUD hideHUD]
            ;
            [warnningVC show];
            return;
        }
    }
    [MBProgressHUD showMessage:@"正在保存..."];
    ZDXStoreUserModel *userModel = [ZDXStoreUserModelTool userModel];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.areaId) {
        params[@"areaId"] = @(self.areaId);
    }else{
        params[@"areaId"] = @(self.consigneeInfoModel.areaId);
    }
    params[@"userId"] = @(userModel.userId);
    params[@"userAddress"] = self.remakeCell.textView.text;
    params[@"userName"] = self.editAddressFirstCell.conginnerTextField.text;
    params[@"userPhone"] = self.editAddressFirstCell.phoneNumTextField.text;
    params[@"isDefault"] = @(self.isDefault);
    
    NSString *urlStr = @"";
    if (self.consigneeInfoModel) {
        urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/toEdit",hostUrl];
    }else{
        urlStr = [NSString stringWithFormat:@"%@api/v1.Useraddress/add",hostUrl];
    }
    
    
    
    
    
    
    
    
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 1) {
            [MBProgressHUD showSuccess:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZDXStoreEditAddressFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:EditAddressFirstCellID];
        if (self.consigneeInfoModel) {
            cell.conginnerTextField.text = self.consigneeInfoModel.userName;
            cell.phoneNumTextField.text = self.consigneeInfoModel.userPhone;
            cell.addressLabel.text = self.consigneeInfoModel.areaName;
        }
        cell.delegate = self;
        self.editAddressFirstCell = cell;
        return cell;
    }
    if (indexPath.row == 1) {
        ZDXStoreAddressRemakeCell *cell = [tableView dequeueReusableCellWithIdentifier:addressRemakeCellID];
        if (self.consigneeInfoModel) {
            cell.textView.text = self.consigneeInfoModel.userAddress;
        }
        self.remakeCell = cell;
        return cell;
    }
    if (indexPath.row == 2) {
        ZDXStoreSetupDefaultAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:setupDefaultAddressCellID];
        cell.block = ^(NSInteger type) {
            self.isDefault = type;
        };
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


#define mark - pickView delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == provinceType) {
        return self.provinceArray.count;
    }else if (component == cityType){
        return self.cityArray.count;
    }else{
        return self.distanceArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == provinceType) {
        if (self.provinceArray.count != 0) {
            ZDXStoreCityModel *model = self.provinceArray[row];
            return model.areaName;
        }else{
            return @"";
        }
    }else if (component == cityType){
        if (self.cityArray.count!=0) {
            ZDXStoreCityModel *model = self.cityArray[row];
            return model.areaName;
        }else{
            return @"";
        }
        
        
    }else{
        
        if (self.distanceArray.count!=0) {
            ZDXStoreCityModel *model = self.distanceArray[row];
            return model.areaName;
        }else{
            return @"";
        }
        
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == provinceType) {
        self.pickIsScroll = NO;
        ZDXStoreCityModel *model = self.provinceArray[row];
        [self LoadDataWithCityID:model.areaId addressType:2];
        
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else if (component == cityType){
        ZDXStoreCityModel *model = self.cityArray[row];
        [self LoadDataWithCityID:model.areaId addressType:3];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

#pragma mark - cell delegate
-(void)chooseAddress{
    [self LoadDataWithCityID:0 addressType:1];
    [self LoadDataWithCityID:110000 addressType:2];
    [self LoadDataWithCityID:110100 addressType:3];

}

-(void)LoadDataWithCityID:(NSInteger)cityID addressType:(NSInteger)type{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"parentId" : @(cityID)};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Areas/areasLists",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            if (type == 1) { // 省
                self.provinceArray = [ZDXStoreCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.pickerView reloadAllComponents];

            }else if (type == 2){ // 市
                self.cityArray = [ZDXStoreCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                if (!self.pickIsScroll) {
                    ZDXStoreCityModel *model = self.cityArray[0];
                    [self LoadDataWithCityID:model.areaId addressType:3];

                }
                [self.pickerView reloadComponent:cityType];
            }else{ // 区
                self.distanceArray = [ZDXStoreCityModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.pickerView reloadComponent:distanceType];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    if (type == 1) {
        self.pickerView = [[UIPickerView alloc]init];
        self.pickerView.frame = CGRectMake(0, 20, 320, 200);
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSInteger row1 = [self.pickerView selectedRowInComponent:provinceType];
            NSInteger row2 = [self.pickerView selectedRowInComponent:cityType];
            NSInteger row3 = [self.pickerView selectedRowInComponent:distanceType];
            
            ZDXStoreCityModel *model1 = [[ZDXStoreCityModel alloc] init];
            ZDXStoreCityModel *model2 = [[ZDXStoreCityModel alloc] init];
            ZDXStoreCityModel *model3 = [[ZDXStoreCityModel alloc] init];
            if (self.provinceArray.count!=0) {
                model1 = self.provinceArray[row1];
            }
            if (self.cityArray.count!=0) {
                model2 = self.cityArray[row2];
            }
            if (self.distanceArray.count!=0) {
                model3 = self.distanceArray[row3];
            }
            NSString *str = [NSString stringWithFormat:@"%@ %@ %@",model1.areaName,model2.areaName,model3.areaName];
            self.editAddressFirstCell.addressLabel.text = str;
            
            self.areaId = model3.areaId;
        }];
        
        [alertController.view addSubview:self.pickerView];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


@end
