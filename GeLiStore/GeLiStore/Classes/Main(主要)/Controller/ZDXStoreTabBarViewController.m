//
//  ZDXStoreTabBarViewController.m
//  GeLiStore
//
//  Created by user99 on 2017/10/19.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTabBarViewController.h"
#import "ZDXComnous.h"
#import "ZDXStoreTabBar.h"
#import "ZDXStoreNavigationViewController.h"
@interface ZDXStoreTabBarViewController ()<ZDXStoreTabBarDelegate>

@property (strong, nonatomic) ZDXStoreTabBar *ZDXTabBar;

@end

@implementation ZDXStoreTabBarViewController

-(ZDXStoreTabBar *)ZDXTabBar{
    if (!_ZDXTabBar) {
        _ZDXTabBar = [[ZDXStoreTabBar alloc] initWithFrame:self.tabBar.frame];
        _ZDXTabBar.delegate = self;
    }
    return _ZDXTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.加载控制器
    [self configViewControllers];
    
    // 2.加载tabbar
    [self.view addSubview:self.ZDXTabBar];
    
    // 移除系统的tabBar
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
    
    // 解决tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    // Do any additional setup after loading the view.
}

-(void)configViewControllers{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"ZDXStoreHomeViewController",@"ZDXStoreShareViewController",@"ZDXStoreRecylingInNewViewController",@"ZDXStoreShoppingCarViewController",@"ZDXStoreMeViewController"]];
    
    for (int i = 0; i<array.count; i++) {
        UIViewController *vc = [[NSClassFromString(array[i]) alloc] init];
        ZDXStoreNavigationViewController *nav = [[ZDXStoreNavigationViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = array;
}

-(void)setTabBarHidden:(BOOL)hidden{
    self.ZDXTabBar.hidden = hidden;
}

#pragma mark - ZDXTabBar delegate
-(void)selectedTabBarIndex:(NSInteger)index{
    self.selectedIndex = index;
}
@end
