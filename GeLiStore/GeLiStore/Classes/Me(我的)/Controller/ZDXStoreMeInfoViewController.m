//
//  ZDXStoreMeInfoViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/6.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreMeInfoViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreUserModelTool.h"
#import "WLRPushView1.h"

@interface ZDXStoreMeInfoViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (copy, nonatomic) NSString *userPhotoStr;
@property (copy, nonatomic) NSString *userNameStr;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;

@property (strong, nonatomic) ZDXStoreUserModel *userModel;
@end

@implementation ZDXStoreMeInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    创建相机
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    //    推出效果跳转
    _imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    //    允许编辑
    _imagePickerController.allowsEditing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

    self.userModel = [ZDXStoreUserModelTool userModel];
    
    self.lineView.backgroundColor = colorWithString(@"#f5f5f5");
    self.username.textColor = colorWithString(@"#8a8a8a");
    self.backView.backgroundColor = colorWithString(@"#f4f4f4");
    
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 15;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,self.userModel.userPhoto]] placeholderImage:nil];
    self.username.text = self.userModel.userName;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=item;
    
}

-(void)editButtonAction{
    
    [MBProgressHUD showMessage:@"正在提交..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @(self.userModel.userId);
    params[@"userPhoto"] = self.userPhotoStr;
    params[@"userName"] = self.userNameStr;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Users/toEdit",hostUrl];
    
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 1) {
            [MBProgressHUD showSuccess:@"保存成功"];
            if (self.userNameStr.length > 0) {
                self.userModel.userName = self.userNameStr;
                [ZDXStoreUserModelTool saveUserModel:self.userModel];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];

    }];
}

- (IBAction)clickHeader:(UIButton *)sender {
    //    相机相册选择按钮
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    // 显示
    [actionsheet showInView:self.view];
}

- (IBAction)clickHeaderName:(UIButton *)sender {
    WLRPushView1 *view1 = [[WLRPushView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andTitle:@"用户名"];
    [self.view addSubview:view1];
    view1.block = ^(NSString *titleParam)
    {
        self.userNameStr = titleParam;
        self.username.text = titleParam;
    };
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) { // 照片
        [self selectImageFromLibrary];

    }
    if (buttonIndex == 1) { // 拍照
        
    }
    if (buttonIndex == 2) {
        NSLog(@"取消");
    }
}

// 从相册获取图片或视频
-(void)selectImageFromLibrary{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    [MBProgressHUD showMessage:@"图片正在上传..."];
    
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.headerImageView.image = image;
    
    // 上传图片
    [self uploadPicturesWithImage:image];
    
    //是相机拍出来的照片的情况下存入相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 上传图片
-(void)uploadPicturesWithImage:(UIImage *)image{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"dir" : @"users"};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v1.Uploads/uploadPics",hostUrl];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *photoData = [NSData imageData:image];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
        [formData appendPartWithFileData:photoData name:@"file[]" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 1) { // 上传成功
            NSArray *photoArr = responseObject[@"data"][@"thumb"];
            NSString *userPhotoStr = [photoArr firstObject];
            
            self.userPhotoStr = userPhotoStr;
            self.userModel.userPhoto = userPhotoStr;
            [ZDXStoreUserModelTool saveUserModel:self.userModel];
        }else{
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        UIAlertView * warnningVC = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnningVC show];
    }];
    
}
@end
