//
//  ZDXStoreTestViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/11/15.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTestViewController.h"
#import "ZDXComnous.h"
@interface ZDXStoreTestViewController ()

@end

@implementation ZDXStoreTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:webView];
    webView.backgroundColor = [UIColor yellowColor];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"goodsId" : @"2"};
    [manager POST:@"http://glys.wuliuhangjia.com/api/v1.Goods/goodsDetails" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *data = responseObject[@"data"];
        NSString *htmlStr = data[@"goodsDesc"];
        [webView loadHTMLString:htmlStr baseURL:nil];
        
        
        
        NSLog(@"%@",htmlStr);
        NSData *data1 = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
        
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data1];
        NSArray *elements  = [xpathParser searchWithXPathQuery:@"//img"];
        NSLog(@"%@",elements);
        for (TFHppleElement *hppleElement in elements) {
            //            NSArray *imageArr = [hppleElement searchWithXPathQuery:@"//img"];
            //            for (TFHppleElement *tempElement in imageArr) {
            NSString *imgStr = [hppleElement objectForKey:@"src"];
            NSLog(@"%@",imgStr);
            //            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
