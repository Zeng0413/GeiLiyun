//
//  ZDXStoreBrandChooseCell.m
//  GeLiStore
//
//  Created by user99 on 2017/10/25.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreBrandChooseCell.h"
#import "ZDXStoreChooseBrandView.h"
#import "ZDXComnous.h"
@interface ZDXStoreBrandChooseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerView;
@property (weak, nonatomic) ZDXStoreChooseBrandView *chooseBrandView;

@end
@implementation ZDXStoreBrandChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://glys.wuliuhangjia.com/api/v1.Ads/home1F" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        [self.bannerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,dic[@"adFile"]]] placeholderImage:[UIImage imageNamed:@"小banner加载"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    self.bannerView.layer.masksToBounds = YES;
    self.bannerView.layer.cornerRadius = 20;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    ZDXStoreChooseBrandView *view = [[ZDXStoreChooseBrandView alloc] initWithFrame:CGRectMake(14, 142, SCREEN_WIDTH - 28, 37)];
    [self.contentView addSubview:view];
    self.chooseBrandView = view;
    
    UIImageView *xsyhImage = [[UIImageView alloc] init];
    
    xsyhImage.y = CGRectGetMaxY(view.frame) + 6;
    xsyhImage.width = 163;
    xsyhImage.height = 22;
    xsyhImage.x = SCREEN_WIDTH / 2 - xsyhImage.width / 2;
    
    xsyhImage.image = [UIImage imageNamed:@"旧品换新抵扣现金"];
    [self.contentView addSubview:xsyhImage];
    
    self.cellH = CGRectGetMaxY(xsyhImage.frame);
    // Initialization code
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    self.chooseBrandView.dataList = arr;
}

@end
