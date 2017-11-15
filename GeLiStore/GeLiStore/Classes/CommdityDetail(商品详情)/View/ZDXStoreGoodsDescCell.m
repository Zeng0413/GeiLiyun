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
    
//    [self.goodsDescWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}


-(void)setHtmlStr:(NSString *)htmlStr{
    _htmlStr = htmlStr;
    [self.goodsDescWebView loadHTMLString:@"" baseURL:nil];
    
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGSize contentSize = [webView sizeThatFits:CGSizeZero];
//    self.cellH = contentSize.height + 40;
//    
//    // 发出通知
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"NSNotificationWebViewDidFinishLoad" object:nil];
//}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        CGSize fitting = [self.goodsDescWebView sizeThatFits:CGSizeZero];
//        NSLog(@"viewH=%f webW=%f webH=%f",SCREEN_HEIGHT,fitting.width,fitting.height);
//        
//    }
//}
@end
