//
//  UIWebViewController.m
//  WebView
//
//  Created by 唐云川 on 2017/7/4.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "UIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>


@interface UIWebViewController ()<UIWebViewDelegate>
{
    UILabel *_titleLabel;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,strong,readwrite) UIBarButtonItem *returnButton;//返回按钮
@property (nonatomic,strong,readwrite) UIBarButtonItem *closeItem;//关闭按钮

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.returnButton;
    [self creatWebView];

    
}

- (UIBarButtonItem *)returnButton {
    if (!_returnButton) {
        _returnButton = [[UIBarButtonItem alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"backBtnIcon"];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        button.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setImage:image forState:UIControlStateNormal];//这是一张“<”的图片
        [button addTarget:self action:@selector(respondsToReturnToBack:) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.frame = CGRectMake(15, 0, 56, 20);
        _returnButton.customView = button;
        
    }
    return _returnButton;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(respondsToReturnToFind:)];
    }
    return _closeItem;
}

- (void)setUpSubViews{

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = _titleLabel;
    
    
    [self creatWebView];
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString *theUrl = [NSString stringWithFormat:@"%@@",self.wap_url];
        [self loadString:theUrl];
    }];


}
- (void)creatWebView{

    self.webView = [[UIWebView alloc] init];
    self.webView.backgroundColor = UIColorFromRGBA(249, 249, 251, 1.0);
    self.webView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self loadString:self.wap_url];
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}
#pragma mark - UIWebDelegate
/**
 *  作用：一般用来拦截webView发出的所有请求（加载新的网页）
 *  每当webView即将发送一个请求之前，会先调用这个方法
 *
 *  @param request        即将要发送的请求
 *
 *  @return YES ：允许发送这个请求  NO ：不允许发送这个请求，禁止加载这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"将要开始加载.......");
    /*
    NSString *orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[request.URL absoluteString]];
    if (orderInfo.length > 0) {
        // 调用支付接口进行支付
        [[AlipaySDK defaultService]payUrlOrder:orderInfo fromScheme:@"CpsAlipay" callback:^(NSDictionary* result) {
        }];
        return NO;
    }
    */
    return  YES;
}

/**
 *  UIWevView开始加载内容时调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"正在开始加载.......");
}
/**
 *  UIWevView加载完毕时调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.mj_header endRefreshing];
    // 禁止滚动上下滚动
    [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
    
    //定义好JS要调用的方法
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"与接口端约定的方法名"] = ^(){
        NSArray *prams = [JSContext currentArguments];
        JSValue *jsVal = [prams objectAtIndex:0];
        NSLog(@"接口传过来的参数====%@",jsVal);
    };
    NSString *theTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = theTitle;
    
//    //这也是一种获取标题的方法。
//    JSValue *value = [context evaluateScript:@"document.title"];
//    //更新标题
//    _titleLabel.text = value.toString;
}

/**
 *  加载失败时调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webView.scrollView.mj_header endRefreshing];
    NSLog(@"加载失败.......");
}

#pragma mark -- 按钮点击事件
- (void)respondsToReturnToBack:(UIButton *)sender {
    if ([self.webView canGoBack]) {//判断当前的H5页面是否可以返回
        self.navigationItem.leftBarButtonItems = @[self.returnButton, self.closeItem];
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)respondsToReturnToFind:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
    self.webView.delegate = nil;
    [self.webView stopLoading];
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
