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
#import "AFNetworking.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) LoadingView *waitView;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    
    [self.waitView showLoadingTo:self.webView];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [_webView.scrollView setBounces:NO];
        _webView.mediaPlaybackAllowsAirPlay= YES;
        _webView.mediaPlaybackRequiresUserAction = YES;
        _webView.delegate = self;
    }
    return _webView;
}


- (void)setUrl:(NSString *)url
{
    _url = url;
    NSString *newUrl = [NSString stringWithFormat:@"http://%@",url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:newUrl]];
    [self.webView loadRequest:request];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.waitView dismiss];
    [SVProgressHUD showErrorWithStatus:@"网络不给力"];
    NSLog(@"%@",error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.waitView dismiss];
}


@end
