//
//  SQSecondViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQSecondViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "LPXQheadView.h"
@interface SQSecondViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) LPXQheadView *headerView;

@property (nonatomic,strong) UIWebView *webView;
@end

@implementation SQSecondViewController

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.view addSubview:self.headerView];
    self.headerView.hotList = self.hotList;
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - 懒加载
- (LPXQheadView *)headerView
{
    if (!_headerView) {
        _headerView = [[LPXQheadView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 180)];
    }
    return _headerView;
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 244, 375, 50)];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
    
}

@end
