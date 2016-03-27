//
//  SYSecondViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/21.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SYSecondViewController.h"
#import "HttpRequestMacro.h"
#import "HttpTool.h"
#import "NSString+ChangeHtmlString.h"
#import "LoadingView.h"
#import "SVProgressHUD.h"

@interface SYSecondViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) NSString *html;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,strong) LoadingView *waitView;
@end

@implementation SYSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.scrollView addSubview:self.waitView];
    
    [self sendRequestOrNot];
}


- (void)sendRequestOrNot
{
    if (self.contentid.length >2) {
        [self sendRequestWithUrl];
    }
}


- (void)sendRequestWithUrl
{
    NSDictionary *params = @{
                             @"contentid":self.contentid,
                             @"client":@"2",
                             @"auth":@"DZdoQym1w8KtDCsV8Hs3om1TJxQJarZr6K9Wc9UWFicWP229JPSh1U7P4"
                             };
    [HttpTool postWithPath:@"article/info" params:params success:^(id JSON) {
        
        NSLog(@"%@",JSON);
        if (![JSON[@"data"][@"html"] isKindOfClass:[NSNull class]]) {
            self.html = JSON[@"data"][@"html"];
        }
        [self.scrollView addSubview:self.webView];
        
        [self.waitView dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        [self.waitView dismiss];
    }];
}


#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, self.view.frame.size.height -64)];
        _scrollView.pagingEnabled = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(0, 10000);
    }
    return _scrollView;
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0)];
        self.html = [NSString getHtmlString:self.html];
        [self.webView loadHTMLString:self.html baseURL:nil];
        _webView.delegate = self;
    }
    return _webView;
}


#pragma mark - webView的代理方法实现
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect rect = webView.frame;
    rect.size.width = SCREENWIDTH;
    rect.size.height = 1;
    webView.frame = rect;
    
    rect.size.height = webView.scrollView.contentSize.height;
    webView.frame = rect;
    
    self.scrollView.contentSize = CGSizeMake(0, rect.size.height);
}

- (void)deliverContentidWithString:(NSString *)contentid
{
    self.contentid = contentid;
}


@end
