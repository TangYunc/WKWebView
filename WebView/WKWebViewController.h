//
//  WKWebViewController.h
//  WebView
//
//  Created by 唐云川 on 2017/7/4.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKWebViewController : UIViewController

/**
 加载纯外部链接网页
 
 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;
@end
