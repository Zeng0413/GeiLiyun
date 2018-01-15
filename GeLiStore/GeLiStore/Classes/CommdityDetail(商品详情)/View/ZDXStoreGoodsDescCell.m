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

@property (assign, nonatomic) NSInteger num;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewH;

@end

@implementation ZDXStoreGoodsDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.goodsDescWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    self.goodsDescWebView.delegate = self;
    self.goodsDescWebView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:self.goodsDescWebView];
    
    
    // 商品详情按钮
    [self.goodsDescBtn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateSelected];
    [self.goodsDescBtn setTitleColor:colorWithString(@"#444444") forState:UIControlStateNormal];
    
    // 规格参数按钮
    [self.goodsParameterBtn setTitleColor:colorWithString(@"#e93644") forState:UIControlStateSelected];
    [self.goodsParameterBtn setTitleColor:colorWithString(@"#444444") forState:UIControlStateNormal];
    
    
}


-(void)setHtmlStr:(NSString *)htmlStr{
    _htmlStr = htmlStr;
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",htmlStr]; // 这里的webInfo就是原始的HTML字符串。
    
    [self.goodsDescWebView loadHTMLString:htmls baseURL:[NSURL URLWithString:hostUrl]];
//    NSURL *url = [NSURL URLWithString:@"http://wuliuhangjia.com/index.php/Content/index/id/1"];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [self.goodsDescWebView loadRequest:request];

    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    //获取到webview的高度
//    CGFloat height = [[self.goodsDescWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    CGSize contentSize = [webView sizeThatFits:CGSizeZero];
//    self.cellH = contentSize.height + 40;
//    
//    self.webViewH.constant = contentSize.height;
    self.num++;
    //获取到webview的高度
    CGFloat height = [[self.goodsDescWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.goodsDescWebView.frame = CGRectMake(self.goodsDescWebView.frame.origin.x,self.goodsDescWebView.frame.origin.y, SCREEN_WIDTH, height);
    
    if (height>50) {
        // 发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NSNotificationWebViewDidFinishLoad" object:nil];
    }
    
}

@end
