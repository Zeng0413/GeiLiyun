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
#import "ZDXStoreUserModel.h"
static NSString *refundMoneyOrTypeCellID = @"RefundMoneyOrTypeCell";
static NSString *refundGoodsCellID = @"RefundGoodsCell";
@interface ZDXStoreRefundViewController ()<UITableViewDelegate, UITableViewDataSource, ZDXStoreRefundReasonCellDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) ZDXStoreRefundReasonCell *refundReasonCell;

@property (assign, nonatomic) NSInteger reasonTag;
@end

@implementation ZDXStoreRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"退款";
    
    // 注册通知，监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:) name:UIKeyboardWillHideNotification object:nil];

    
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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderId"] = @(self.orderDetailModel.orderId);
    params[@"reasonId"] = @(self.reasonTag);
    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
    params[@"refundRemark"] = self.refundReasonCell.textView.text;
    if (!self.reasonTag) {
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"请选择取消原因" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Orders/cancellation",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRefundGoodsCell" bundle:nil] forCellReuseIdentifier:refundGoodsCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRefundMoneyOrTypeCell" bundle:nil] forCellReuseIdentifier:refundMoneyOrTypeCellID];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - 键盘监听
-(void)keyboardDidShow:(NSNotification *)notification{
    // 获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSLog(@"%@",keyboardObject);
    
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //设置view的frame，往上平移
    CGRect frame = self.view.frame;
    if (!(frame.origin.y < 0)) {
        frame.origin.y -= keyboardRect.size.height - 44;
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = frame;
        }];
    }
   
}

-(void)keyboardDidHidden:(NSNotification *)notification{
    // 获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSLog(@"%@",keyboardObject);
    
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.view.frame;
    frame.origin.y +=keyboardRect.size.height - 44;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
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
        cell.refundMoney.text = [NSString stringWithFormat:@"¥%@",self.orderDetailModel.totalMoney];
        return cell;
    }
    if (indexPath.section == 2) {
        ZDXStoreRefundReasonCell *cell = [ZDXStoreRefundReasonCell initWithRefundReasonTableView:tableView cellForRowAtIndexPAth:indexPath];
        cell.delegate = self;
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
}

#pragma mark - cell delegate
-(void)selectedRefundReasonTag:(NSInteger)reasonTag{
    self.reasonTag = reasonTag;
}
@end
