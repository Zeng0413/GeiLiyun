//
//  ZDXStoreGoodsDescCell.m
//  GeLiStore
//
//  Created by user99 on 2017/11/15.
//  Copyright © 2017年 user99. All rights reserved.
//

#import "ZDXStoreGoodsDescCell.h"
#import "ZDXComnous.h"

@interface ZDXStoreGoodsDescCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *goodsDescBtn;  // 商品详情按钮
@property (weak, nonatomic) IBOutlet UIButton *goodsParameterBtn; // 规格参数按钮
@property (weak, nonatomic) IBOutlet UIWebView *goodsDescWebView;

@end

@implementation ZDXStoreGoodsDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 商品详情按钮
    [self.goodsDescBtn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateSelected];
    [self.goodsDescBtn setTitleColor:colorWithString(@"#444444") forState:UIControlStateNormal];
    
    // 规格参数按钮
    [self.goodsParameterBtn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateSelected];
    [self.goodsParameterBtn setTitleColor:colorWithString(@"#444444") forState:UIControlStateNormal];
    
    self.goodsDescWebView.delegate = self;
   
    self.goodsDescWebView.scrollView.scrollEnabled = NO;
}


-(void)setHtmlStr:(NSString *)htmlStr{
    _htmlStr = htmlStr;
//    [self.goodsDescWebView loadHTMLString:htmlStr baseURL:nil];
    NSURL *url = [NSURL URLWithString:@"http://wuliuhangjia.com/index.php/Content/index/id/1"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.goodsDescWebView loadRequest:request];

    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGSize contentSize = [webView sizeThatFits:CGSizeZero];
    self.cellH = contentSize.height + 40;
    
    // 发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NSNotificationWebViewDidFinishLoad" object:nil];
}

@end
