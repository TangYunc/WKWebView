//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by 唐云川 on 2017/5/8.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    WKWebView *_webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    NSURL *url = [NSURL URLWithString:@"www.jianshu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

    NSLog(@"webview开始加载");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    NSLog(@"webview加载返回");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    NSLog(@"webview已经结束加载");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{

    NSLog(@"webview加载失败");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

    NSLog(@"已经接收到服务器跳转请求");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    NSLog(@"收到响应后，决定是否跳转");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSLog(@"发送请求之前，决定是否跳转");
}

#pragma mark --
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    NSLog(@"message:%@,frame:%@",message,frame);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
