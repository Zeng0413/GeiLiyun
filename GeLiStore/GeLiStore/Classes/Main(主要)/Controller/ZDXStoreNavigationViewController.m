//
//  ZDXStoreNavigationViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreNavigationViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreTabBarViewController.h"
@interface ZDXStoreNavigationViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation ZDXStoreNavigationViewController

+(void)initialize{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //存储手势代理
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
    
    // navBar上面所有子控件颜色
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    ZDXStoreTabBarViewController *tabBarVc = (ZDXStoreTabBarViewController *)self.tabBarController;
    // 根控制器的时候显示tabBar;
    if (viewController == self.viewControllers[0]) {
        //    设置导航条背景颜色
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#e93644"];
        self.interactivePopGestureRecognizer.delegate = nil;
        [tabBarVc setTabBarHidden:NO];
    }else{
        self.navigationBar.tintColor = [UIColor blackColor];
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        [tabBarVc setTabBarHidden:YES];
        
        //        不是根控制器的时候显示导航条
        [self.navigationBar setHidden:NO];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回箭头"] highImage:[UIImage imageNamed:@"返回箭头"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        
        
        viewController.navigationItem.leftBarButtonItem = left;
    }
    [super pushViewController:viewController animated:animated];

}


- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
@end
