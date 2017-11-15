//
//  ZDXStoreTableViewHeaderView.m
//  GeLiStore
//
//  Created by user99 on 2017/10/20.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreTableViewHeaderView.h"
#import "ZDXComnous.h"

@interface ZDXStoreTableViewHeaderView ()<UIScrollViewDelegate, SDCycleScrollViewDelegate>{
    NSInteger count;
}

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;


@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end
@implementation ZDXStoreTableViewHeaderView


+(instancetype)headerView:(CGRect)frame{
    ZDXStoreTableViewHeaderView *headerView = [[self alloc] init];
    headerView.backgroundColor = [UIColor redColor];

    headerView.frame = frame;
    
    headerView.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, headerView.width, headerView.height) delegate:headerView placeholderImage:nil];
    headerView.cycleScrollView.backgroundColor = [UIColor whiteColor];
    headerView.cycleScrollView.placeholderImage = [UIImage imageNamed:@"首页-顶部banner-加载"];
    headerView.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    headerView.cycleScrollView.autoScrollTimeInterval = 2.5;
    headerView.cycleScrollView.currentPageDotColor = colorWithString(@"#e93644");
    headerView.cycleScrollView.pageDotColor = [UIColor whiteColor];
    [headerView addSubview:headerView.cycleScrollView];
    
    return headerView;
}

-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    NSMutableArray *arr = [NSMutableArray array];
    for (id temp in dataList) {
        NSString *imageStr;
        if ([temp isKindOfClass:[NSDictionary class]]) {
           imageStr = [NSString stringWithFormat:@"%@%@",hostUrl,temp[@"adFile"]];
        }else{
            imageStr = [NSString stringWithFormat:@"%@%@",hostUrl,temp];
        }
        [arr addObject:imageStr];
    }
    _cycleScrollView.imageURLStringsGroup = arr;
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

//-(void)dealloc{
//    [self.timer invalidate];
//    [self setTimer:nil];
//}
//
//+(instancetype)headerView:(CGRect)frame{
//    ZDXStoreTableViewHeaderView *headerView = [[self alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
//    
//    headerView.frame = frame;
//    headerView.scrollView = [[UIScrollView alloc] init];
//    headerView.scrollView.pagingEnabled = YES;
//    headerView.userInteractionEnabled = YES;
//    [headerView.scrollView setShowsHorizontalScrollIndicator:NO]; // 隐藏横向滚动条
//    [headerView.scrollView setDelegate:headerView];
//    
//    [headerView.scrollView setFrame:headerView.bounds];
//
//    [headerView addSubview:headerView.scrollView];
//    
//
//    headerView.pageControl = [[UIPageControl alloc] init];
//    headerView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    headerView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#e93644"];
//    [headerView addSubview:headerView.pageControl];
//    return headerView;
//}
//
//
//-(void)click{
//    NSLog(@"当前Index=%ld",self.pageControl.currentPage);
//}
//
//
//-(void)setDataList:(NSArray *)dataList{
//    _dataList = dataList;
//    
//    CGFloat width = CGRectGetWidth(self.bounds);
//    count = dataList.count;
//    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
//    [self.scrollView addGestureRecognizer:gesture];
//    
//    [self.scrollView setContentSize:CGSizeMake(count * width, 0)];
//    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 20, width, 20);
//    self.pageControl.numberOfPages = count;
//    [self addImageViews:dataList];
//    [self initTimer];
//}
//
//-(void)willMoveToSuperview:(UIView *)newSuperview{
//    
//    
//}
//
//
//
//-(void)addImageViews:(NSArray *)dataList{
//    CGFloat width = CGRectGetWidth(self.frame);
//    CGFloat height = CGRectGetHeight(self.frame);
//    for (int i = 0; i<count; i++) {
//        NSDictionary *dict = dataList[i];
//        NSString *urlStr = dict[@"adFile"];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,urlStr]] placeholderImage:nil];
//        [self.scrollView addSubview:imageView];
//    }
//}
//
//-(void)initTimer{
//    if (!self.timer) {
//        self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(changImage) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    }
//    
//    
//}
//
//
//-(void)changImage{
//    self.currentPage++;
//    if (self.currentPage>=count) {
//        self.currentPage = 0;
//    }
//    [self.scrollView setContentOffset:CGPointMake(self.currentPage * CGRectGetWidth(self.frame), 0) animated:YES];
//}
//
//#pragma mark - scrollView delegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.pageControl setCurrentPage:(scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame))];
//}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if (self.timer) {
//        [self.timer invalidate];
//        [self setTimer:nil];
//    }
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self initTimer];
//}


@end
