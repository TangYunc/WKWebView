//
//  ViewController.m
//  WebView
//
//  Created by 唐云川 on 2017/7/4.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self setUpSubViews];
}

- (void)setUpSubViews{

    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.frame = CGRectMake(100, 100, 150, 20);
    skipBtn.backgroundColor = UIColorFromRGBA(199, 9, 9, 1.0);
    [skipBtn setTitle:@"UIWebView" forState:UIControlStateNormal];
    [skipBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    skipBtn.showsTouchWhenHighlighted = YES;
    [skipBtn addTarget:self action:@selector(skipNextCtrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
    
    UIButton *transpotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    transpotBtn.frame = CGRectMake(100, 300, 150, 20);
    transpotBtn.backgroundColor = UIColorFromRGBA(199, 9, 9, 1.0);
    [transpotBtn setTitle:@"WKWebView" forState:UIControlStateNormal];
    [transpotBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    transpotBtn.showsTouchWhenHighlighted = YES;
    [transpotBtn addTarget:self action:@selector(transpotBtnCtrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transpotBtn];
}

#pragma mark -- 按钮事件
- (void)skipNextCtrl:(UIButton *)button{

    UIWebViewController *webVC = [[UIWebViewController alloc] init];
    webVC.wap_url = @"https://www.jianshu.com";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)transpotBtnCtrl:(UIButton *)button{
    
    WKWebViewController *wkwebVC = [[WKWebViewController alloc] init];
    [wkwebVC loadWebURLSring:@"https://www.baidu.com"];
    [self.navigationController pushViewController:wkwebVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
