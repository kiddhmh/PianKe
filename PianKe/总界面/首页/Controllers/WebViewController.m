//
//  WebViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/17.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "WebViewController.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"
#import "UIBarButtonItem+Helper.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) LoadingView *waitView;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    
    self.navigationItem.backBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    
    [self.waitView showLoadingTo:self.webView];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    }
    return _webView;
}


- (void)setUrl:(NSString *)url
{
    _url = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.waitView dismiss];
    [SVProgressHUD showErrorWithStatus:@"网络不给力"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.waitView dismiss];
}

@end
