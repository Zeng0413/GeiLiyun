//
//  ZDXStoreOrderAppraiseViewController.m
//  GeLiStore
//
//  Created by user99 on 2018/1/5.
//  Copyright © 2018年 user99. All rights reserved.
//

#import "ZDXStoreOrderAppraiseViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreGoodsModel.h"
#import "ZDXStoreOrderDetailModel.h"
#import "ZDXStoreRefundGoodsCell.h"
#import "ZDXStoreAppraiseRemarkCell.h"
#import "ZDXStoreAddAppraiseImgCell.h"
#import "MImaLibTool.h"
#import "MShowAllGroup.h"
#import "ZDXStoreGoodsAppraiseDescCell.h"
#import "ZDXStoreAppraiseScoreCell.h"
#import "ZDXStoreGoodsAppraiseBottomView.h"

static NSString *appraiseRemarkCellID = @"AppraiseRemarkCell";
static NSString *refundGoodsCellID = @"RefundGoodsCell";
static NSString *goodsAppraiseDescCellID = @"goodsAppraiseDescCell";
static NSString *appraiseScoreCellID = @"AppraiseScoreCell";

@interface ZDXStoreOrderAppraiseViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate, MShowAllGroupDelegate, ZDXStoreAppraiseScoreCellDelegate, ZDXStoreGoodsAppraiseBottomViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ZDXStoreAppraiseRemarkCell *appraiseRemarkCell;

@property (strong, nonatomic)ZDXStoreAddAppraiseImgCell *addImgCell;

@property (strong, nonatomic) NSMutableArray *imgArrSelected;

@property (nonatomic, strong) NSArray *imgArrGroup;

// 存储照片数组
@property (strong, nonatomic) NSMutableArray *photoArray;

@property (assign, nonatomic) NSInteger goodsScore; // 商品分数
@property (assign, nonatomic) NSInteger deliverGoodsSpeedScore; // 发货速度评分
@property (assign, nonatomic) NSInteger WlSpeedScore; // 物流速度评分
@property (assign, nonatomic) NSInteger serviceAttitudeScore; // 服务态度评分

@end

@implementation ZDXStoreOrderAppraiseViewController

-(NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

-(NSMutableArray *)_imgArrSelected{
    if (!_imgArrSelected) {
        _imgArrSelected = [NSMutableArray array];
    }
    return _imgArrSelected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.goodsScore = 5;
    self.deliverGoodsSpeedScore = 1;
    self.WlSpeedScore = 1;
    self.serviceAttitudeScore = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"评价";
    
    // 添加图片监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImage) name:@"addImageNotification" object:nil];
    
    // 设置tableView
    [self setupTableView];
    
    [self setupBottomView];
}

// 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 100 - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreRefundGoodsCell" bundle:nil] forCellReuseIdentifier:refundGoodsCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreAppraiseRemarkCell" bundle:nil] forCellReuseIdentifier:appraiseRemarkCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreGoodsAppraiseDescCell" bundle:nil] forCellReuseIdentifier:goodsAppraiseDescCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ZDXStoreAppraiseScoreCell" bundle:nil] forCellReuseIdentifier:appraiseScoreCellID];

    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void)setupBottomView{
    ZDXStoreGoodsAppraiseBottomView *bottomView = [[ZDXStoreGoodsAppraiseBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 106, SCREEN_WIDTH, 106)];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
}

#pragma mark - 提交评价
-(void)submitAppraiseClick{
    [MBProgressHUD showMessage:@""];
    // 上传图片
    [self uploadImg];
}

// 上传图片
-(void)uploadImg{
    if (self.photoArray.count>0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *params = @{@"dir" : @"appraises"};
        
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Uploads/uploadPics",hostUrl];
        [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0; i<self.photoArray.count; i++) {
                UIImage *image = _photoArray[i];
                NSData *photoData = [NSData imageData:image];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat =@"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
                // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
                [formData appendPartWithFileData:photoData name:@"file[]" fileName:fileName mimeType:@"image/jpg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress = %@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 1) {
                [MBProgressHUD hideHUD];
                [self orderAppraiseSubmit:responseObject[@"data"][@"savePath"]];
            }else{
                [MBProgressHUD showError:@"图片上传失败"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [warnningVC show];
        }];
    }else{
        [self orderAppraiseSubmit:nil];
    }
}

-(void)orderAppraiseSubmit:(NSArray *)savePaths{
    NSString *imagesStr = @"";
    
    for (NSString *imgStr in savePaths) {
        imagesStr = [imagesStr stringByAppendingString:[NSString stringWithFormat:@"%@,",imgStr]];
    }
    
    if (imagesStr.length > 0) {
        imagesStr = [imagesStr substringToIndex:([imagesStr length] - 1)];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZDXStoreGoodsModel *goodsModel = [self.orderDetailModel.goods firstObject];
    params[@"orderId"] = @(self.orderDetailModel.orderId);
    params[@"goodsId"] = @(goodsModel.goodsId);
    params[@"userId"] = @([ZDXStoreUserModelTool userModel].userId);
    params[@"goodsScore"] = @(self.goodsScore);
    params[@"timeScore"] = @(self.deliverGoodsSpeedScore);
    params[@"serviceScore"] = @(self.serviceAttitudeScore);
    params[@"content"] = self.appraiseRemarkCell.textView.text;
    
    if (imagesStr.length>0) {
        params[@"images"] = imagesStr;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.GoodsAppraises/add",hostUrl];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
    
}

#pragma mark - 监听事件
-(void)addImage{
    //        相机相册选择按钮
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    // 显示
    [actionsheet showInView:self.view];
}

#pragma mark - UIActionSheet代理方法
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 0) {
        [self loadImgDataAndShowAllGroup];
    }
    if (buttonIndex == 1) {
        [self openCamera];
    }
    if (buttonIndex ==2) {
        NSLog(@"取消");
    }
}

#pragma mark 打开相机
-(void)openCamera{
    [self openImagePickerVc:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - 加载照片数据
-(void)loadImgDataAndShowAllGroup{
    if (!_imgArrSelected) {
        self.imgArrSelected = [NSMutableArray array];
    }
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        if (arrObj && arrObj.count > 0) {
            self.imgArrGroup = arrObj;
            if ( self.imgArrGroup.count > 0) {
                MShowAllGroup *svc = [[MShowAllGroup alloc] initWithArrGroup:self.imgArrGroup arrSelected:self.imgArrSelected];
                svc.delegate = self;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
                if (_imgArrSelected) {
                    svc.arrSeleted = _imgArrSelected;
                    svc.mvc.arrSelected = _imgArrSelected;
                }
                NSInteger num = 8 - self.photoArray.count;
                svc.maxCout = num;
                [self presentViewController:nav animated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - 完成选择后返回的图片Array(ALAsset*)
- (void)finishSelectImg{
    //正方形缩略图
    NSMutableArray *thumbnailImgArr = [NSMutableArray array];
    
    for (ALAsset *set in _imgArrSelected) {
        CGImageRef cgImg = [set thumbnail];
        UIImage* image = [UIImage imageWithCGImage: cgImg];
        //添加图片到photosView
        [self.addImgCell addPhoto:image];
        [self.photoArray addObject:image];
        
        [thumbnailImgArr addObject:image];
    }
    
    [self.tableView reloadData];

}
-(void)openImagePickerVc:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - imagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //是相机拍出来的照片的情况下存入相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    
    //添加图片到photosView
    [self.addImgCell addPhoto:image];
    [self.photoArray addObject:image];
    [self.tableView reloadData];
}
#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.orderDetailModel.goods.count;
    }else if (section == 4){
        return 3;
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
        ZDXStoreAppraiseRemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:appraiseRemarkCellID];
        cell.block = ^(NSInteger goodsScore) {
            self.goodsScore = goodsScore;
        };
        self.appraiseRemarkCell = cell;
        return cell;
    }
    if (indexPath.section == 2) {
        ZDXStoreAddAppraiseImgCell *cell = [ZDXStoreAddAppraiseImgCell cellWithAppraiseImgTableView:tableView];
        self.addImgCell = cell;
        return cell;
    }
    if (indexPath.section == 3) {
        ZDXStoreGoodsAppraiseDescCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsAppraiseDescCellID];
        return cell;
    }
    if (indexPath.section == 4) {
        ZDXStoreAppraiseScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:appraiseScoreCellID];
        cell.delegate = self;
        NSArray *arr = @[@"发货速度",@"物流速度",@"服务态度"];
        cell.tag = indexPath.row;
        cell.title.text = arr[indexPath.row];
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
        return self.appraiseRemarkCell.cellH;
    }else if (indexPath.section == 2){
        return self.addImgCell.cellH;
    }else if (indexPath.section == 3) {
        return 54;
    }else if (indexPath.section == 4) {
        return 31;
    }
    return 50;
}


#pragma mark - cell delegate
-(void)goodsScoreTypeCell:(ZDXStoreAppraiseScoreCell *)cell appraiseScore:(NSInteger)score{
    if (cell.tag == 0) {
        self.deliverGoodsSpeedScore = score;
    }else if (cell.tag == 1){
        self.WlSpeedScore = score;
    }else{
        self.serviceAttitudeScore = score;
    }
}
@end
